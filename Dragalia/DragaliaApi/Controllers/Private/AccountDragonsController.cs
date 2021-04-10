using AutoMapper;
using DragaliaApi.Data;
using DragaliaApi.Models;
using DragaliaApi.Models.DTO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Controllers.Private
{
    [Authorize]
    [Route("api/AccountDragons")]
    [ApiController]
    public class AccountDragonsController : AuthController
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public AccountDragonsController(DragaliaContext context, IMapper mapper, IConfiguration configuration) : base(context, mapper, configuration)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/AccountDragons
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AccountDragonDTO>>> GetAccountDragons()
        {
            try
            {
                var accountID = await GetAccountID();
                return await _context.AccountDragons.Where(ad => ad.AccountId == accountID)
                                                    .Include(ad => ad.Dragon)
                                                    .ThenInclude(d => d.Element)
                                                    .OrderBy(ad => ad.Dragon.Element.SortOrder)
                                                    .ThenByDescending(ad => ad.Dragon.Rarity)
                                                    .ThenByDescending(ad => ad.DragonId)
                                                    .Select(ad => _mapper.Map<AccountDragonDTO>(ad))
                                                    .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/AccountDragons/5
        [HttpGet("{dragonID}")]
        public async Task<ActionResult<AccountDragonDTO>> GetAccountDragon(int dragonID)
        {
            try
            {
                var accountID = await GetAccountID();
                var rval = await _context.AccountDragons.Where(ad => ad.AccountId == accountID && ad.DragonId == dragonID)
                                                        .Include(ad => ad.Dragon)
                                                        .ThenInclude(d => d.Element)
                                                        .Select(ad => _mapper.Map<AccountDragonDTO>(ad))
                                                        .FirstOrDefaultAsync();

                if (rval == null)
                    return NotFound();
                return rval;
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // PUT: api/AccountDragons/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{dragonID}")]
        public async Task<IActionResult> PutAccountDragon(int dragonID, AccountDragonDTO accountDragonDTO)
        {
            var accountID = await GetAccountID();
            var accountDragon = await _context.AccountDragons.FindAsync(accountID, dragonID);

            accountDragon.Unbind = accountDragonDTO.Unbind;
            accountDragon.UnbindWanted = accountDragonDTO.UnbindWanted;

            _context.Entry(accountDragon).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException) when (!AccountDragonExists(accountID, dragonID))
            {
                return NotFound();
            }

            return NoContent();
        }

        // POST: api/AccountDragons
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<AccountDragonDTO>> PostAccountDragon(AccountDragonDTO accountDragonDTO)
        {
            var accountID = await GetAccountID();
            var accountDragon = _mapper.Map<AccountDragon>(accountDragonDTO);
            accountDragon.AccountId = accountID;

            _context.AccountDragons.Add(accountDragon);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException) when (AccountDragonExists(accountID, accountDragon.DragonId))
            {
                return Conflict();
            }

            return CreatedAtAction(
                nameof(GetAccountDragon),
                new { accountID = accountDragon.AccountId, dragonID = accountDragon.DragonId },
                _mapper.Map<AccountDragonDTO>(accountDragon)
                );
        }

        // DELETE: api/AccountDragons/5
        [HttpDelete("{dragonID}")]
        public async Task<IActionResult> DeleteAccountDragon(int dragonID)
        {
            var accountID = await GetAccountID();
            var accountDragon = await _context.AccountDragons.FindAsync(accountID, dragonID);
            if (accountDragon == null)
            {
                return NotFound();
            }

            _context.AccountDragons.Remove(accountDragon);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpGet("costs")]
        public async Task<ActionResult<IEnumerable<MaterialCost>>> GetDragonCosts(int? dragonID)
        {
            try
            {
                var accountID = await GetAccountID();

                return await _context.AccountDragons
                    .Where(ad => ad.AccountId == accountID
                                 && (dragonID == null || ad.DragonId == dragonID))
                    .Include(ad => ad.Dragon)
                    .ThenInclude(d => d.Element)
                    .Include(ad => ad.Dragon)
                    .ThenInclude(d => d.DragonUnbinds)
                    .ThenInclude(du => du.Material)
                    .SelectMany(ad => ad.Dragon.DragonUnbinds,
                        (accountDragon, dragonEssence) => new { accountDragon, dragonEssence })
                    .Where(x => x.accountDragon.UnbindWanted > x.accountDragon.Unbind)
                    .OrderBy(x => x.accountDragon.Dragon.Element.SortOrder)
                    .ThenByDescending(x => x.accountDragon.Dragon.Rarity)
                    .ThenByDescending(x => x.accountDragon.DragonId)
                    .ThenBy(x => x.dragonEssence.Material.SortPath)
                    .Select(x => new MaterialCost
                    {
                        Product = $"{x.accountDragon.Dragon.Dragon1} Unbinds",
                        Material = _mapper.Map<MaterialDTO>(x.dragonEssence.Material),
                        Quantity = x.dragonEssence.Quantity * (x.accountDragon.UnbindWanted - x.accountDragon.Unbind)
                    })
                    .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        private bool AccountDragonExists(int accountID, int dragonID) => _context.AccountDragons.Any(e => e.AccountId == accountID
                                                                                                          && e.DragonId == dragonID);
    }
}
