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

namespace DragaliaApi.Controllers.Private
{
    [Route("api/AccountAdventurers")]
    [ApiController]
    public class AccountAdventurersController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public AccountAdventurersController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/AccountAdventurers
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AccountAdventurerDTO>>> GetAccountAdventurers()
        {
            try
            {
                var accountID = await AccountsController.GetAccountID();
                return await _context.AccountAdventurers.Where(aa => aa.AccountId == accountID)
                                                        .Include(aa => aa.Adventurer)
                                                        .ThenInclude(a => a.Element)
                                                        .OrderBy(aa => aa.Adventurer.Element.SortOrder)
                                                        .ThenBy(aa => aa.Adventurer.WeaponTypeId)
                                                        .ThenByDescending(aa => aa.Adventurer.Rarity)
                                                        .Select(aa => _mapper.Map<AccountAdventurerDTO>(aa))
                                                        .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/AccountAdventurers/5
        [HttpGet("{adventurerID}")]
        public async Task<ActionResult<AccountAdventurerDTO>> GetAccountAdventurer(int adventurerID)
        {
            try
            {
                var accountID = await AccountsController.GetAccountID();
                return await _context.AccountAdventurers.Where(aa => aa.AccountId == accountID && aa.AdventurerId == adventurerID)
                                                        .Include(aa => aa.Adventurer)
                                                        .Select(aa => _mapper.Map<AccountAdventurerDTO>(aa))
                                                        .FirstOrDefaultAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // PUT: api/AccountAdventurers/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{adventurerID}")]
        public async Task<IActionResult> PutAccountAdventurer(int adventurerID, AccountAdventurerDTO accountAdventurerDTO)
        {
            var accountID = await AccountsController.GetAccountID();
            var accountAdventurer = await _context.AccountAdventurers.FindAsync(accountID, adventurerID);

            accountAdventurer.CurrentLevel = accountAdventurerDTO.CurrentLevel;
            accountAdventurer.WantedLevel = accountAdventurerDTO.WantedLevel;

            _context.Entry(accountAdventurer).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException) when (!AccountAdventurerExists(accountID, adventurerID))
            {
                return NotFound();
            }

            return NoContent();
        }

        // POST: api/AccountAdventurers
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<AccountAdventurerDTO>> PostAccountAdventurer(AccountAdventurerDTO accountAdventurerDTO)
        {
            var accountID = await AccountsController.GetAccountID();
            var accountAdventurer = _mapper.Map<AccountAdventurer>(accountAdventurerDTO);
            accountAdventurer.AccountId = accountID;

            _context.AccountAdventurers.Add(accountAdventurer);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException) when (AccountAdventurerExists(accountID, accountAdventurer.AdventurerId))
            {
                return Conflict();
            }

            return CreatedAtAction(
                nameof(GetAccountAdventurer),
                new { accountID = accountAdventurer.AccountId, adventurerID = accountAdventurer.AdventurerId },
                _mapper.Map<AccountAdventurerDTO>(accountAdventurer));
        }

        // DELETE: api/AccountAdventurers/5
        [HttpDelete("{adventurerID}")]
        public async Task<IActionResult> DeleteAccountAdventurer(int adventurerID)
        {
            var accountID = await AccountsController.GetAccountID();
            var accountAdventurer = await _context.AccountAdventurers.FindAsync(accountID, adventurerID);
            if (accountAdventurer == null)
            {
                return NotFound();
            }

            _context.AccountAdventurers.Remove(accountAdventurer);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpGet("costs")]
        public async Task<ActionResult<IEnumerable<MaterialCost>>> GetAdventurerCosts(int? adventurerID)
        {
            try
            {
                var accountID = await AccountsController.GetAccountID();
                return await _context.AccountAdventurers
                    .Where(aa => aa.AccountId == accountID
                                 && (adventurerID == null || aa.AdventurerId == adventurerID))
                    .Include(aa => aa.Adventurer)
                    .ThenInclude(a => a.ManaCircles)
                    .ThenInclude(mc => mc.Material)
                    .Include(aa => aa.Adventurer)
                    .ThenInclude(a => a.Element)
                    .SelectMany(aa => aa.Adventurer.ManaCircles, 
                        (accountAdventurer, manaCircle) => new { accountAdventurer, manaCircle})
                    .Where(x => x.accountAdventurer.CurrentLevel < x.manaCircle.ManaNode
                                && x.manaCircle.ManaNode <= x.accountAdventurer.WantedLevel)
                    .OrderByDescending(x => x.accountAdventurer.Adventurer.Element.SortOrder)
                    .ThenBy(x => x.accountAdventurer.Adventurer.WeaponTypeId)
                    .ThenByDescending(x => x.accountAdventurer.Adventurer.Rarity)
                    .Select(x => new MaterialCost
                    {
                        Product = $"{x.accountAdventurer.Adventurer.Adventurer1} MC #{x.manaCircle.ManaNode}",
                        Material = _mapper.Map<MaterialDTO>(x.manaCircle.Material),
                        Quantity = x.manaCircle.Quantity
                    })
                    .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        private bool AccountAdventurerExists(int accountID, int adventurerID) => _context.AccountAdventurers.Any(aa => aa.AccountId == accountID
                                                                                                                       && aa.AdventurerId == adventurerID);
    }
}
