using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DragaliaApi.Data;
using DragaliaApi.Models;
using AutoMapper;
using DragaliaApi.Models.DTO;

namespace DragaliaApi.Controllers
{
    [Route("api/AccountPassives")]
    [ApiController]
    public class AccountPassivesController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public AccountPassivesController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/AccountPassives
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AccountPassiveDTO>>> GetAccountPassives()
        {
            var accountID = await AccountsController.GetAccountID();
            try
            {
                return await _context.AccountPassives.Where(ap => ap.AccountId == accountID)
                                                     .Include(ap => ap.Passive)
                                                     .ThenInclude(p => p.Ability)
                                                     .Include(ap => ap.Passive)
                                                     .ThenInclude(p => p.Element)
                                                     .Include(ap => ap.Passive)
                                                     .ThenInclude(p => p.WeaponType)
                                                     .OrderBy(ap => ap.Passive.WeaponTypeId)
                                                     .ThenBy(ap => ap.Passive.Element.SortOrder)
                                                     .ThenBy(ap => ap.Passive.SortOrder)
                                                     .Select(ap => _mapper.Map<AccountPassiveDTO>(ap))
                                                     .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/AccountPassives/5
        [HttpGet("{passiveID}")]
        public async Task<ActionResult<AccountPassiveDTO>> GetAccountPassive(int passiveID)
        {
            var accountID = await AccountsController.GetAccountID();
            try
            {
                return await _context.AccountPassives.Where(ap => ap.AccountId == accountID && ap.PassiveId == passiveID)
                                                     .Include(ap => ap.Passive)
                                                     .ThenInclude(p => p.Ability)
                                                     .Include(ap => ap.Passive)
                                                     .ThenInclude(p => p.Element)
                                                     .Include(ap => ap.Passive)
                                                     .ThenInclude(p => p.WeaponType)
                                                     .OrderBy(ap => ap.Passive.WeaponTypeId)
                                                     .ThenBy(ap => ap.Passive.Element.SortOrder)
                                                     .ThenBy(ap => ap.Passive.SortOrder)
                                                     .Select(ap => _mapper.Map<AccountPassiveDTO>(ap))
                                                     .FirstOrDefaultAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // PUT: api/AccountPassives/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{passiveID}")]
        public async Task<IActionResult> PutAccountPassive(int passiveID, AccountPassiveDTO accountPassiveDTO)
        {
            var accountID = await AccountsController.GetAccountID();
            var accountPassive = await _context.AccountPassives.FindAsync(accountID, passiveID);

            accountPassive.Owned = accountPassiveDTO.Owned;
            accountPassive.Wanted = accountPassiveDTO.Wanted;

            _context.Entry(accountPassive).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException) when (!AccountPassiveExists(accountID, passiveID))
            {
                return NotFound();
            }

            return NoContent();
        }

        // POST: api/AccountPassives
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<AccountPassiveDTO>> PostAccountPassive(AccountPassiveDTO accountPassiveDTO)
        {
            var accountID = await AccountsController.GetAccountID();
            var accountPassive = _mapper.Map<AccountPassive>(accountPassiveDTO);
            accountPassive.AccountId = accountID;

            _context.AccountPassives.Add(accountPassive);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException) when (AccountPassiveExists(accountID, accountPassive.PassiveId))
            {
                return Conflict();
            }

            return CreatedAtAction(
                nameof(GetAccountPassive),
                new { accountID = accountPassive.AccountId, passiveID = accountPassive.PassiveId },
                _mapper.Map<AccountPassiveDTO>(accountPassive)
                );
        }

        // DELETE: api/AccountPassives/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAccountPassive(int passiveID)
        {
            var accountID = await AccountsController.GetAccountID();
            var accountPassive = await _context.AccountPassives.FindAsync(accountID, passiveID);
            if (accountPassive == null)
            {
                return NotFound();
            }

            _context.AccountPassives.Remove(accountPassive);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool AccountPassiveExists(int accountID, int passiveID) => _context.AccountPassives.Any(ap => ap.AccountId == accountID
                                                                                                              && ap.PassiveId == passiveID);
    }
}
