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

namespace DragaliaApi.Controllers
{
    [Route("api/Accounts")]
    [ApiController]
    public class AccountsController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public AccountsController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/Accounts
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AccountDTO>>> GetAccounts()
        {
            //return await _context.Accounts.Select(a => AccountDTO.ToDTO(a))
            //                              .ToListAsync();
            return await _context.Accounts.Select(a => _mapper.Map<AccountDTO>(a)).ToListAsync();
        }

        // GET: api/Accounts/5
        [HttpGet("{accountID}")]
        public async Task<ActionResult<AccountDTO>> GetAccount(int accountID)
        {
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
        public async Task<IActionResult> UpdateAccount(int accountID, AccountDTO accountDTO)
        {
            if (accountID != accountDTO.AccountId)
            {
                return BadRequest();
            }

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

        // POST: api/Accounts
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<AccountDTO>> CreateAccount(AccountDTO accountDTO)
        {
            var account = _mapper.Map<Account>(accountDTO);

            _context.Accounts.Add(account);
            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetAccount),
                new { id = account.AccountId },
                _mapper.Map<AccountDTO>(account));
        }

        // DELETE: api/Accounts/5
        [HttpDelete("{accountID}")]
        public async Task<IActionResult> DeleteAccount(int accountID)
        {
            var account = await _context.Accounts.FindAsync(accountID);
            if (account == null)
            {
                return NotFound();
            }

            _context.Accounts.Remove(account);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool AccountExists(int accountID) => _context.Accounts.Any(e => e.AccountId == accountID);
    }
}
