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
    [Route("api/AccountWeapons")]
    [ApiController]
    public class AccountWeaponsController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public AccountWeaponsController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/AccountWeapons
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AccountWeaponDTO>>> GetAccountWeapons()
        {
            var accountID = await AccountsController.GetAccountID();
            try
            {
                return await _context.AccountWeapons.Where(aw => aw.AccountId == accountID)
                                                    .Include(aw => aw.Weapon)
                                                    .ThenInclude(w => w.Element)
                                                    .Include(aw => aw.Weapon)
                                                    .ThenInclude(w => w.WeaponSeries)
                                                    .Include(aw => aw.Weapon)
                                                    .ThenInclude(w => w.WeaponType)
                                                    .OrderBy(aw => aw.Weapon.WeaponSeries.SortOrder)
                                                    .ThenBy(aw => aw.Weapon.WeaponTypeId)
                                                    .ThenBy(aw => aw.Weapon.Rarity)
                                                    .ThenBy(aw => aw.Weapon.Element.SortOrder)
                                                    .Select(aw => _mapper.Map<AccountWeaponDTO>(aw))
                                                    .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/AccountWeapons/1002
        [HttpGet("{weaponID}")]
        public async Task<ActionResult<AccountWeaponDTO>> GetAccountWeapon(int weaponID)
        {
            var accountID = await AccountsController.GetAccountID();
            try
            {
                return await _context.AccountWeapons.Where(aw => aw.AccountId == accountID && aw.WeaponId == weaponID)
                                                    .Include(aw => aw.Weapon)
                                                    .ThenInclude(w => w.Element)
                                                    .Include(aw => aw.Weapon)
                                                    .ThenInclude(w => w.WeaponSeries)
                                                    .Include(aw => aw.Weapon)
                                                    .ThenInclude(w => w.WeaponType)
                                                    .Select(aw => _mapper.Map<AccountWeaponDTO>(aw))
                                                    .FirstAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET /api/AccountWeapons/untracked
        [HttpGet("untracked")]
        public async Task<ActionResult<IEnumerable<WeaponDTO>>> GetUntrackedWeapons()
        {
            var accountID = await AccountsController.GetAccountID();
            try
            {
                return await _context.Weapons.Include(w => w.Element)
                                             .Include(w => w.WeaponSeries)
                                             .Include(w => w.WeaponType)
                                             .Where(w => !_context.AccountWeapons.Any(aw => aw.AccountId == accountID && aw.WeaponId == w.WeaponId))
                                             .OrderBy(w => w.WeaponSeries.SortOrder)
                                             .ThenBy(w => w.WeaponTypeId)
                                             .ThenBy(w => w.Rarity)
                                             .ThenBy(w => w.Element.SortOrder)
                                             .Select(w => _mapper.Map<WeaponDTO>(w))
                                             .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }


        // PUT: api/AccountWeapons/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{weaponID}")]
        public async Task<IActionResult> PutAccountWeapon(int weaponID, AccountWeaponDTO accountWeaponDTO)
        {
            var accountID = await AccountsController.GetAccountID();
            var accountWeapon = await _context.AccountWeapons.FindAsync(accountID, weaponID);

            accountWeapon.Copies = accountWeaponDTO.Copies;
            accountWeapon.CopiesWanted = accountWeaponDTO.CopiesWanted;
            accountWeapon.WeaponLevel = accountWeaponDTO.WeaponLevel;
            accountWeapon.WeaponLevelWanted = accountWeaponDTO.WeaponLevelWanted;
            accountWeapon.Unbind = accountWeaponDTO.Unbind;
            accountWeapon.UnbindWanted = accountWeaponDTO.UnbindWanted;
            accountWeapon.Refine = accountWeaponDTO.Refine;
            accountWeapon.RefineWanted = accountWeaponDTO.RefineWanted;
            accountWeapon.Slot = accountWeaponDTO.Slot;
            accountWeapon.SlotWanted = accountWeaponDTO.SlotWanted;
            accountWeapon.Dominion = accountWeaponDTO.Dominion;
            accountWeapon.DominionWanted = accountWeaponDTO.DominionWanted;
            accountWeapon.Bonus = accountWeaponDTO.Bonus;
            accountWeapon.BonusWanted = accountWeaponDTO.BonusWanted;

            _context.Entry(accountWeapon).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException) when (!AccountWeaponExists(accountID, weaponID))
            {
                return NotFound();
            }

            return NoContent();
        }

        // POST: api/AccountWeapons
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<AccountWeapon>> PostAccountWeapon(AccountWeaponDTO accountWeaponDTO)
        {
            var accountID = await AccountsController.GetAccountID();
            var accountWeapon = _mapper.Map<AccountWeapon>(accountWeaponDTO);
            accountWeapon.AccountId = accountID;

            _context.AccountWeapons.Add(accountWeapon);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException) when (AccountWeaponExists(accountWeapon.AccountId, accountWeapon.WeaponId))
            {
                return Conflict();
            }

            return CreatedAtAction(
                nameof(GetAccountWeapon),
                new { accountID = accountWeapon.AccountId, weaponID = accountWeapon.WeaponId },
                _mapper.Map<AccountWeaponDTO>(accountWeapon));
        }

        // DELETE: api/AccountWeapons/5/1001
        [HttpDelete("{weaponID}")]
        public async Task<IActionResult> DeleteAccountWeapon(int weaponID)
        {
            var accountID = await AccountsController.GetAccountID();
            var accountWeapon = await _context.AccountWeapons.FindAsync(accountID, weaponID);
            if (accountWeapon == null)
            {
                return NotFound();
            }

            _context.AccountWeapons.Remove(accountWeapon);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpGet("costs")]
        public async Task<ActionResult<IEnumerable<MaterialCost>>> GetWeaponCosts(int? weaponID)
        {
            try
            {
                var accountID = await AccountsController.GetAccountID();
                var materialCosts = new List<MaterialCost>();

                //Weapon crafting
                materialCosts.AddRange(await _context.AccountWeapons
                    .Where(aw => aw.AccountId == accountID
                                 && aw.CopiesWanted > 0
                                 && aw.Copies == 0
                                 && (weaponID == null || aw.WeaponId == weaponID))
                    .Include(aw => aw.Weapon)
                    .ThenInclude(w => w.WeaponCraftings)
                    .ThenInclude(wc => wc.Material)
                    .Include(aw => aw.Weapon)
                    .ThenInclude(w => w.Element)
                    .Include(aw => aw.Weapon)
                    .ThenInclude(w => w.WeaponSeries)
                    .Include(aw => aw.Weapon)
                    .ThenInclude(aw => aw.WeaponType)
                    .SelectMany(aw => aw.Weapon.WeaponCraftings,
                        (aw, wc) => new { aw, wc })
                    .OrderBy(x => x.aw.Weapon.WeaponSeries.SortOrder)
                    .ThenBy(x => x.aw.Weapon.WeaponTypeId)
                    .ThenBy(x => x.aw.Weapon.Rarity)
                    .ThenBy(x => x.aw.Weapon.Element.SortOrder)
                    .ThenBy(x => x.wc.Material.SortPath)
                    .Select(x => new MaterialCost
                    {
                        Product = $"{x.aw.Weapon.Weapon1}: Craft",
                        Material = _mapper.Map<MaterialDTO>(x.wc.Material),
                        Quantity = x.wc.Quantity
                    })
                    .ToListAsync());

                //Unbinding, refining, copies, slots, and bonuses
                materialCosts.AddRange(await _context.AccountWeapons
                    .Where(aw => aw.AccountId == accountID
                                 && (weaponID == null || aw.WeaponId == weaponID))
                    .Include(aw => aw.Weapon)
                    .ThenInclude(w => w.WeaponUpgrades)
                    .ThenInclude(wu => wu.UpgradeType)
                    .Include(aw => aw.Weapon)
                    .ThenInclude(w => w.Element)
                    .Include(aw => aw.Weapon)
                    .ThenInclude(w => w.WeaponSeries)
                    .Include(aw => aw.Weapon)
                    .ThenInclude(aw => aw.WeaponType)
                    .SelectMany(aw => aw.Weapon.WeaponUpgrades,
                        (aw, wu) => new { aw, wu })
                    .OrderBy(x => x.aw.Weapon.WeaponSeries.SortOrder)
                    .ThenBy(x => x.aw.Weapon.WeaponTypeId)
                    .ThenBy(x => x.aw.Weapon.Rarity)
                    .ThenBy(x => x.aw.Weapon.Element.SortOrder)
                    .ThenBy(x => x.wu.UpgradeType.UpgradeType1)
                    .ThenBy(x => x.wu.Step)
                    .ThenBy(x => x.wu.Material.SortPath)
                    .Where(x =>
                           (x.wu.UpgradeType.UpgradeType1 == "Unbind"
                            && x.aw.Unbind < x.wu.Step
                            && x.wu.Step <= x.aw.UnbindWanted)
                        || (x.wu.UpgradeType.UpgradeType1 == "Refinement"
                            && x.aw.Refine < x.wu.Step
                            && x.wu.Step <= x.aw.RefineWanted)
                        || (x.wu.UpgradeType.UpgradeType1 == "Copies"
                            && x.aw.Copies < x.wu.Step
                            && x.wu.Step <= x.aw.CopiesWanted)
                        || (x.wu.UpgradeType.UpgradeType1 == "Slots"
                            && x.aw.Slot < x.wu.Step
                            && x.wu.Step <= x.aw.SlotWanted)
                        || (x.wu.UpgradeType.UpgradeType1 == "Dominion"
                            && x.aw.Dominion < x.wu.Step
                            && x.wu.Step <= x.aw.DominionWanted)
                        || (x.wu.UpgradeType.UpgradeType1 == "Weapon Bonus"
                            && x.aw.Bonus < x.wu.Step
                            && x.wu.Step <= x.aw.BonusWanted)
                        )
                    .Select(x => new MaterialCost
                    {
                        Product = $"{x.aw.Weapon.Weapon1}: {x.wu.UpgradeType.UpgradeType1} {x.wu.Step}",
                        Material = _mapper.Map<MaterialDTO>(x.wu.Material),
                        Quantity = x.wu.Quantity
                    })
                    .ToListAsync());

                //Weapon level
                materialCosts.AddRange(await _context.AccountWeapons
                    .Where(aw => aw.AccountId == accountID
                                 && (weaponID == null || aw.WeaponId == weaponID))
                    .Include(aw => aw.Weapon)
                    .ThenInclude(w => w.Element)
                    .Include(aw => aw.Weapon)
                    .ThenInclude(w => w.WeaponSeries)
                    .Include(aw => aw.Weapon)
                    .ThenInclude(aw => aw.WeaponType)
                    .Join(_context.WeaponLevels.Include(wl => wl.Material),
                        aw => aw.Weapon.Rarity,
                        wl => wl.Rarity,
                        (aw, wl) => new { aw, wl })
                    .OrderBy(x => x.aw.Weapon.WeaponSeries.SortOrder)
                    .ThenBy(x => x.aw.Weapon.WeaponTypeId)
                    .ThenBy(x => x.aw.Weapon.Rarity)
                    .ThenBy(x => x.aw.Weapon.Element.SortOrder)
                    .ThenBy(x => x.wl.WeaponLevel1)
                    .ThenBy(x => x.wl.Material.SortPath)
                    .Where(x => x.aw.WeaponLevel < x.wl.WeaponLevel1 && x.wl.WeaponLevel1 <= x.aw.WeaponLevelWanted)
                    .Select(x => new MaterialCost
                    {
                        Product = $"{x.aw.Weapon.Weapon1}: Level {x.wl.WeaponLevel1}",
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

        private bool AccountWeaponExists(int accountID, int weaponID) => _context.AccountWeapons.Any(e => e.AccountId == accountID
                                                                                                          && e.WeaponId == weaponID);
    }
}
