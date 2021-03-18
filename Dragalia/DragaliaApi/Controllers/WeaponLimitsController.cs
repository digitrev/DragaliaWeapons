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
    [Route("api/WeaponLimits")]
    [ApiController]
    public class WeaponLimitsController : ControllerBase
    {
        private readonly DragaliaContext _context;

        public WeaponLimitsController(DragaliaContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<WeaponLimits>>> GetWeaponLimits()
        {
            try
            {
                return await _context.Weapons.Include(w => w.WeaponUpgrades)
                    .ThenInclude(wu => wu.UpgradeType)
                    .Join(_context.WeaponLevels.GroupBy(wl => wl.Rarity,
                                                        (rarity, wl) => new { rarity, level = wl.Max(x => x.WeaponLevel1) }),
                          w => w.Rarity,
                          wl => wl.rarity,
                          (w, wl) => new { w, wl.level }
                          )
                    .Select(x => new WeaponLimits
                    {
                        WeaponID = x.w.WeaponId,
                        Level = x.level,
                        Unbind = x.w.WeaponUpgrades.Where(wu => wu.UpgradeType.UpgradeType1 == "Unbind")
                                                   .Select(wu => wu.Step)
                                                   .DefaultIfEmpty()
                                                   .Max(),
                        Refinement = x.w.WeaponUpgrades.Where(wu => wu.UpgradeType.UpgradeType1 == "Refinement")
                                                       .Select(wu => wu.Step)
                                                       .DefaultIfEmpty()
                                                       .Max(),
                        Slots = x.w.WeaponUpgrades.Where(wu => wu.UpgradeType.UpgradeType1 == "Slots")
                                                  .Select(wu => wu.Step)
                                                  .DefaultIfEmpty()
                                                  .Max() +
                                x.w.WeaponUpgrades.Where(wu => wu.UpgradeType.UpgradeType1 == "Dominion")
                                                  .Select(wu => wu.Step)
                                                  .DefaultIfEmpty()
                                                  .Max(),
                        Bonus = x.w.WeaponUpgrades.Where(wu => wu.UpgradeType.UpgradeType1 == "Weapon Bonus")
                                                  .Select(wu => wu.Step)
                                                  .DefaultIfEmpty()
                                                  .Max()
                    })
                    .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }
        [HttpGet("{weaponID}")]
        public async Task<ActionResult<WeaponLimits>> GetWeaponLimitsByWeapon(int weaponID)
        {
            try
            {
                return await _context.Weapons.Where(w => w.WeaponId == weaponID)
                    .Include(w => w.WeaponUpgrades)
                    .ThenInclude(wu => wu.UpgradeType)
                    .Join(_context.WeaponLevels.GroupBy(wl => wl.Rarity,
                                                        (rarity, wl) => new { rarity, level = wl.Max(x => x.WeaponLevel1) }),
                          w => w.Rarity,
                          wl => wl.rarity,
                          (w, wl) => new { w, wl.level }
                          )
                    .Select(x => new WeaponLimits
                    {
                        WeaponID = x.w.WeaponId,
                        Level = x.level,
                        Unbind = x.w.WeaponUpgrades.Where(wu => wu.UpgradeType.UpgradeType1 == "Unbind")
                                                   .Select(wu => wu.Step)
                                                   .DefaultIfEmpty()
                                                   .Max(),
                        Refinement = x.w.WeaponUpgrades.Where(wu => wu.UpgradeType.UpgradeType1 == "Refinement")
                                                       .Select(wu => wu.Step)
                                                       .DefaultIfEmpty()
                                                       .Max(),
                        Slots = x.w.WeaponUpgrades.Where(wu => wu.UpgradeType.UpgradeType1 == "Slots")
                                                  .Select(wu => wu.Step)
                                                  .DefaultIfEmpty()
                                                  .Max() +
                                x.w.WeaponUpgrades.Where(wu => wu.UpgradeType.UpgradeType1 == "Dominion")
                                                  .Select(wu => wu.Step)
                                                  .DefaultIfEmpty()
                                                  .Max(),
                        Bonus = x.w.WeaponUpgrades.Where(wu => wu.UpgradeType.UpgradeType1 == "Weapon Bonus")
                                                  .Select(wu => wu.Step)
                                                  .DefaultIfEmpty()
                                                  .Max()
                    })
                    .FirstOrDefaultAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/WeaponLimits/unbind
        [HttpGet("unbind")]
        public async Task<ActionResult<IEnumerable<WeaponUnbindLimit>>> GetWeaponUnbindLimits(int? rarity)
        {
            try
            {
                return await _context.WeaponUnbindLimits.Where(wul => rarity == null || wul.WeaponRarity == rarity)
                                                        .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/WeaponLimits/level
        [HttpGet("level")]
        public async Task<ActionResult<IEnumerable<WeaponLevelLimit>>> GetWeaponLevelLimits(int? rarity)
        {
            try
            {
                return await _context.WeaponLevelLimits.Where(wll => rarity == null || wll.WeaponRarity == rarity)
                                                       .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }
    }
}
