using AutoMapper;
using DragaliaApi.Data;
using DragaliaApi.Models;
using DragaliaApi.Models.Auth;
using DragaliaApi.Models.DTO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using RestSharp;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace DragaliaApi.Controllers.Private
{
    public class AuthController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;
        private readonly string _auth0UserInfo;

        public AuthController(DragaliaContext context, IMapper mapper, IConfiguration configuration)
        {
            _context = context;
            _mapper = mapper;
            _auth0UserInfo = $"{configuration["Auth0:Authority"]}userinfo";
        }

        protected async Task<User> GetUserInfo()
        {
            var client = new RestClient(_auth0UserInfo);
            var request = new RestRequest(Method.GET);
            request.AddHeader("Authorization", Request.Headers["Authorization"].First());

            for (var i = 0; i < 5; ++i)
            {
                var response = await client.ExecuteAsync<User>(request);
                if (response.IsSuccessful)
                {
                    return response.Data;
                }
                else if (response.StatusCode == System.Net.HttpStatusCode.TooManyRequests)
                {
                    await Task.Delay(60 * 1000);
                }
            }
            return null;
        }

        protected async Task<int> GetAccountID()
        {
            var authID = User.FindFirst(ClaimTypes.NameIdentifier).Value;

            return await _context.Accounts.Where(a => a.AuthId == authID)
                                          .Select(a => a.AccountId)
                                          .FirstOrDefaultAsync();
        }
    }


    [Authorize]
    [Route("api/Accounts")]
    [ApiController]
    public class AccountsController : AuthController
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public AccountsController(DragaliaContext context, IMapper mapper, IConfiguration configuration) : base(context, mapper, configuration)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/Accounts
        [HttpGet]
        public async Task<ActionResult<AccountDTO>> GetAccount()
        {
            var accountID = await GetAccountID();
            var account = await _context.Accounts.FindAsync(accountID);

            if (account == null)
            {
                return NotFound();
            }

            return _mapper.Map<AccountDTO>(account);
        }

        // PUT: api/Accounts/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut]
        public async Task<IActionResult> UpdateAccount()
        {
            var user = await GetUserInfo();
            var accountID = await GetAccountID();

            var account = await _context.Accounts.FindAsync(accountID);

            if (account != null)
            {
                account.AuthId = user.Sub;
                account.AccountName = user.Name;
                account.AccountEmail = user.Email;
                _context.Entry(account).State = EntityState.Modified;
                await _context.SaveChangesAsync();
            }
            else
            {
                account = new Account { AuthId = user.Sub, AccountName = user.Name, AccountEmail = user.Email };
                _context.Accounts.Add(account);
                await _context.SaveChangesAsync();
            }

            return NoContent();
        }

        private bool AccountExists(int accountID) => _context.Accounts.Any(e => e.AccountId == accountID);
    }
}
