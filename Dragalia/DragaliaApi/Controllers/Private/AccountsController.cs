using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DragaliaApi.Data;
using DragaliaApi.Models;
using DragaliaApi.Models.DTO;
using AutoMapper;

namespace DragaliaApi.Controllers.Private
{
    public class AuthController: ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public AuthController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<int> GetAccountID()
        {
            string authID = "test";
            return await _context.Accounts.Where(a => a.AuthId == authID)
                                          .Select(a => a.AccountId)
                                          .FirstOrDefaultAsync();
            //return await Task.FromResult(1);
        }
    }


    [Route("api/Accounts")]
    [ApiController]
    public class AccountsController : AuthController
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public AccountsController(DragaliaContext context, IMapper mapper) : base(context, mapper)
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
        [HttpPut("{accountID}")]
        public async Task<IActionResult> UpdateAccount(AccountDTO accountDTO)
        {
            var accountID = await GetAccountID();
            var account = await _context.Accounts.FindAsync(accountID);

            account.AccountName = accountDTO.AccountName;
            account.AccountEmail = accountDTO.AccountEmail;

            _context.Entry(account).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException) when (!AccountExists(accountID))
            {
                return NotFound();
            }

            return NoContent();
        }

        private bool AccountExists(int accountID) => _context.Accounts.Any(e => e.AccountId == accountID);
    }
}
