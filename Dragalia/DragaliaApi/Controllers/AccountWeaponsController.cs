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
    [Route("api/AccountWeapons")]
    [ApiController]
    public class AccountWeaponsController : ControllerBase
    {
        private readonly DragaliaContext _context;

        public AccountWeaponsController(DragaliaContext context)
        {
            _context = context;
        }

        // GET: api/AccountWeapons
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AccountWeaponDTO>>> GetAccountWeapons()
        {
            return await _context.AccountWeapons.Include(aw => aw.Weapon).ThenInclude(w => w.Element)
                                                .Include(aw => aw.Weapon).ThenInclude(w => w.WeaponSeries)
                                                .Include(aw => aw.Weapon).ThenInclude(w => w.WeaponType)
                                                .Select(aw => AccountWeaponDTO.ToDTO(aw))
                                                .ToListAsync();
        }

        // GET: api/AccountWeapons/5
        [HttpGet("{accountID}")]
        public async Task<ActionResult<IEnumerable<AccountWeaponDTO>>> GetAccountWeapons(int accountID)
        {
            return await _context.AccountWeapons.Where(aw => aw.AccountId == accountID)
                                                .Include(aw => aw.Weapon).ThenInclude(w => w.Element)
                                                .Include(aw => aw.Weapon).ThenInclude(w => w.WeaponSeries)
                                                .Include(aw => aw.Weapon).ThenInclude(w => w.WeaponType)
                                                .Select(aw => AccountWeaponDTO.ToDTO(aw))
                                                .ToListAsync();
        }

        // GET: api/AccountWeapons/5/1002
        [HttpGet("{accountID}/{weaponID}")]
        public async Task<ActionResult<AccountWeaponDTO>> GetAccountWeapon(int accountID, int weaponID)
        {
            var accountWeapon = await _context.AccountWeapons.FindAsync(accountID, weaponID);

            _context.Entry(accountWeapon)
                    .Reference(aw => aw.Weapon)
                    .Load();

            _context.Entry(accountWeapon.Weapon)
                    .Reference(w => w.Element)
                    .Load();

            _context.Entry(accountWeapon.Weapon)
                    .Reference(w => w.WeaponSeries)
                    .Load();

            _context.Entry(accountWeapon.Weapon)
                    .Reference(w => w.WeaponType)
                    .Load();

            if (accountWeapon == null)
            {
                return NotFound();
            }

            return AccountWeaponDTO.ToDTO(accountWeapon);
        }

        // PUT: api/AccountWeapons/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{accountID}/{weaponID}")]
        public async Task<IActionResult> PutAccountWeapon(int accountID, int weaponID, AccountWeaponDTO accountWeaponDTO)
        {
            if (accountID != accountWeaponDTO.AccountId || weaponID != accountWeaponDTO.WeaponId)
            {
                return BadRequest();
            }

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
            var accountWeapon = new AccountWeapon
            {
                AccountId = accountWeaponDTO.AccountId,
                WeaponId = accountWeaponDTO.WeaponId,
                Copies = accountWeaponDTO.Copies,
                CopiesWanted = accountWeaponDTO.CopiesWanted,
                WeaponLevel = accountWeaponDTO.WeaponLevel,
                WeaponLevelWanted = accountWeaponDTO.WeaponLevelWanted,
                Unbind = accountWeaponDTO.Unbind,
                UnbindWanted = accountWeaponDTO.UnbindWanted,
                Refine = accountWeaponDTO.Refine,
                RefineWanted = accountWeaponDTO.RefineWanted,
                Slot = accountWeaponDTO.Slot,
                SlotWanted = accountWeaponDTO.SlotWanted,
                Bonus = accountWeaponDTO.Bonus,
                BonusWanted = accountWeaponDTO.BonusWanted
            };

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
                AccountWeaponDTO.ToDTO(accountWeapon));
        }

        // DELETE: api/AccountWeapons/5/1001
        [HttpDelete("{accountID}/{weaponID}")]
        public async Task<IActionResult> DeleteAccountWeapon(int accountID, int weaponID)
        {
            var accountWeapon = await _context.AccountWeapons.FindAsync(accountID, weaponID);
            if (accountWeapon == null)
            {
                return NotFound();
            }

            _context.AccountWeapons.Remove(accountWeapon);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool AccountWeaponExists(int accountID, int weaponID) => _context.AccountWeapons.Any(e => e.AccountId == accountID
                                                                                                          && e.WeaponId == weaponID);


    }
}
