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
            return await _context.AccountWeapons.Include(aw => aw.Weapon).ToListAsync();
        }

        // GET: api/AccountWeapons/5
        [HttpGet("{id}")]
        public async Task<ActionResult<AccountWeapon>> GetAccountWeapon(int id)
        {
            var accountWeapon = await _context.AccountWeapons.FindAsync(id);

            if (accountWeapon == null)
            {
                return NotFound();
            }

            return accountWeapon;
        }

        // PUT: api/AccountWeapons/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutAccountWeapon(int id, AccountWeapon accountWeapon)
        {
            if (id != accountWeapon.AccountId)
            {
                return BadRequest();
            }

            _context.Entry(accountWeapon).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AccountWeaponExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/AccountWeapons
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<AccountWeapon>> PostAccountWeapon(AccountWeapon accountWeapon)
        {
            _context.AccountWeapons.Add(accountWeapon);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (AccountWeaponExists(accountWeapon.AccountId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetAccountWeapon", new { id = accountWeapon.AccountId }, accountWeapon);
        }

        // DELETE: api/AccountWeapons/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAccountWeapon(int id)
        {
            var accountWeapon = await _context.AccountWeapons.FindAsync(id);
            if (accountWeapon == null)
            {
                return NotFound();
            }

            _context.AccountWeapons.Remove(accountWeapon);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool AccountWeaponExists(int id) => _context.AccountWeapons.Any(e => e.AccountId == id);

        private static AccountWeaponDTO AccountWeaponToDTO (AccountWeapon accountWeapon) => new AccountWeaponDTO
        {
            AccountId = accountWeapon.AccountId,
            WeaponId = accountWeapon.WeaponId,
            Copies = accountWeapon.Copies,
            CopiesWanted = accountWeapon.CopiesWanted,
            WeaponLevel = accountWeapon.WeaponLevel,
            WeaponLevelWanted = accountWeapon.WeaponLevelWanted,
            Unbind = accountWeapon.Unbind,
            UnbindWanted = accountWeapon.UnbindWanted,
            Refine = accountWeapon.Refine,

        }
    }
}
