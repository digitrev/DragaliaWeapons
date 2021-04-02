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
    [Route("api/AccountWyrmprints")]
    [ApiController]
    public class AccountWyrmprintsController : AuthController
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public AccountWyrmprintsController(DragaliaContext context, IMapper mapper, IConfiguration configuration) : base(context, mapper, configuration)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/AccountWyrmprints
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AccountWyrmprintDTO>>> GetAccountWyrmprints()
        {
            try
            {
                var accountID = await GetAccountID();
                return await _context.AccountWyrmprints.Where(aw => aw.AccountId == accountID)
                                                       .Include(aw => aw.Wyrmprint)
                                                       .ThenInclude(w => w.WyrmprintAbilities)
                                                       .ThenInclude(wa => wa.Ability)
                                                       .Include(aw => aw.Wyrmprint)
                                                       .ThenInclude(w => w.Affinity)
                                                       .OrderByDescending(aw => aw.Wyrmprint.Rarity)
                                                       .Select(aw => _mapper.Map<AccountWyrmprintDTO>(aw))
                                                       .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/AccountWyrmprints/5
        [HttpGet("{wyrmprintID}")]
        public async Task<ActionResult<AccountWyrmprintDTO>> GetAccountWyrmprint(int wyrmprintID)
        {
            try
            {
                var accountID = await GetAccountID();
                var rval = await _context.AccountWyrmprints.Where(aw => aw.AccountId == accountID && aw.WyrmprintId == wyrmprintID)
                                                           .Include(aw => aw.Wyrmprint)
                                                           .ThenInclude(w => w.WyrmprintAbilities)
                                                           .ThenInclude(wa => wa.Ability)
                                                           .Include(aw => aw.Wyrmprint)
                                                           .ThenInclude(w => w.Affinity)
                                                           .OrderByDescending(aw => aw.Wyrmprint.Rarity)
                                                           .Select(aw => _mapper.Map<AccountWyrmprintDTO>(aw))
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

        // PUT: api/AccountWyrmprints/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{wyrmprintID}")]
        public async Task<IActionResult> PutAccountWyrmprint(int wyrmprintID, AccountWyrmprintDTO accountWyrmprintDTO)
        {
            var accountID = await GetAccountID();
            var accountWyrmprint = await _context.AccountWyrmprints.FindAsync(accountID, wyrmprintID);

            accountWyrmprint.Unbind = accountWyrmprintDTO.Unbind;
            accountWyrmprint.UnbindWanted = accountWyrmprintDTO.UnbindWanted;
            accountWyrmprint.Copies = accountWyrmprintDTO.Copies;
            accountWyrmprint.CopiesWanted = accountWyrmprintDTO.CopiesWanted;
            accountWyrmprint.WyrmprintLevel = accountWyrmprintDTO.WyrmprintLevel;
            accountWyrmprint.WyrmprintLevelWanted = accountWyrmprintDTO.WyrmprintLevelWanted;

            _context.Entry(accountWyrmprint).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException) when (!AccountWyrmprintExists(accountID, wyrmprintID))
            {
                return NotFound();
            }

            return NoContent();
        }

        // POST: api/AccountWyrmprints
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<AccountWyrmprint>> PostAccountWyrmprint(AccountWyrmprintDTO accountWyrmprintDTO)
        {
            var accountID = await GetAccountID();
            var accountWyrmprint = _mapper.Map<AccountWyrmprint>(accountWyrmprintDTO);
            accountWyrmprint.AccountId = accountID;

            _context.AccountWyrmprints.Add(accountWyrmprint);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException) when (AccountWyrmprintExists(accountID, accountWyrmprint.WyrmprintId))
            {
                return Conflict();
            }

            return CreatedAtAction(
                nameof(GetAccountWyrmprint),
                new { accountID = accountWyrmprint.AccountId, WyrmprintID = accountWyrmprint.WyrmprintId },
                _mapper.Map<AccountWyrmprintDTO>(accountWyrmprint));
        }

        // DELETE: api/AccountWyrmprints/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAccountWyrmprint(int id)
        {
            var accountWyrmprint = await _context.AccountWyrmprints.FindAsync(id);
            if (accountWyrmprint == null)
            {
                return NotFound();
            }

            _context.AccountWyrmprints.Remove(accountWyrmprint);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpGet("costs")]
        public async Task<ActionResult<IEnumerable<MaterialCost>>> GetWyrmprintCosts(int? wyrmprintID)
        {
            try
            {
                var accountID = await GetAccountID();
                var materialCosts = new List<MaterialCost>();

                //Unbinding, copies
                materialCosts.AddRange(await _context.AccountWyrmprints
                    .Where(aw => aw.AccountId == accountID
                                 && (wyrmprintID == null || aw.WyrmprintId == wyrmprintID))
                    .Include(aw => aw.Wyrmprint)
                    .ThenInclude(w => w.WyrmprintUpgrades)
                    .ThenInclude(wu => wu.UpgradeType)
                    .SelectMany(aw => aw.Wyrmprint.WyrmprintUpgrades,
                        (aw, wu) => new { aw, wu })
                    .OrderByDescending(x => x.aw.Wyrmprint.Rarity)
                    .ThenBy(x => x.wu.UpgradeType.UpgradeType1)
                    .ThenBy(x => x.wu.Step)
                    .ThenBy(x => x.wu.Material.SortPath)
                    .Where(x =>
                           (x.wu.UpgradeType.UpgradeType1 == "Unbind"
                            && x.aw.Unbind < x.wu.Step
                            && x.wu.Step <= x.aw.UnbindWanted)
                        || (x.wu.UpgradeType.UpgradeType1 == "Copies"
                            && x.aw.Copies < x.wu.Step
                            && x.wu.Step <= x.aw.CopiesWanted)
                        )
                    .Select(x => new MaterialCost
                    {
                        Product = $"{x.aw.Wyrmprint.Wyrmprint1}: {x.wu.UpgradeType.UpgradeType1} {x.wu.Step}",
                        Material = _mapper.Map<MaterialDTO>(x.wu.Material),
                        Quantity = x.wu.Quantity
                    })
                    .ToListAsync());

                //Weapon level
                materialCosts.AddRange(await _context.AccountWyrmprints
                    .Where(aw => aw.AccountId == accountID
                                 && (wyrmprintID == null || aw.WyrmprintId == wyrmprintID))
                    .Join(_context.WyrmprintLevels.Include(wl => wl.Material),
                        aw => aw.Wyrmprint.RarityGroup,
                        wl => wl.Rarity,
                        (aw, wl) => new { aw, wl })
                    .OrderByDescending(x => x.aw.Wyrmprint.Rarity)
                    .ThenBy(x => x.wl.WyrmprintLevel1)
                    .ThenBy(x => x.wl.Material.SortPath)
                    .Where(x => x.aw.WyrmprintLevel < x.wl.WyrmprintLevel1
                                && x.wl.WyrmprintLevel1 <= x.aw.WyrmprintLevelWanted)
                    .Select(x => new MaterialCost
                    {
                        Product = $"{x.aw.Wyrmprint.Wyrmprint1}: Level {x.wl.WyrmprintLevel1}",
                        Material = _mapper.Map<MaterialDTO>(x.wl.Material),
                        Quantity = x.wl.Quantity
                    })
                    .ToListAsync());

                return materialCosts;
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        private bool AccountWyrmprintExists(int accountID, int wyrmprintID) => _context.AccountWyrmprints.Any(aw => aw.AccountId == accountID
                                                                                                                    && aw.WyrmprintId == wyrmprintID);
    }
}
