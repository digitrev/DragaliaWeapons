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

namespace DragaliaApi.Controllers
{
    [Route("api/Accounts")]
    [ApiController]
    public class AccountsController : ControllerBase
    {
        private readonly DragaliaContext _context;

        public AccountsController(DragaliaContext context)
        {
            _context = context;
        }

        // GET: api/Accounts
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AccountDTO>>> GetAccounts()
        {
            return await _context.Accounts.Select(a => AccountDTO.ToDTO(a))
                                          .ToListAsync();
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

            return AccountDTO.ToDTO(account);
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
            var account = new Account
            {
                AccountName = accountDTO.AccountName,
                AccountEmail = accountDTO.AccountEmail
            };

            _context.Accounts.Add(account);
            await _context.SaveChangesAsync();

            return CreatedAtAction(
                nameof(GetAccount),
                new { id = account.AccountId },
                AccountDTO.ToDTO(account));
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
