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
    [Route("api/AccountInventories")]
    [ApiController]
    public class AccountInventoriesController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public AccountInventoriesController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/AccountInventories
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AccountInventoryDTO>>> GetAccountInventories()
        {
            var accountID = await AccountsController.GetAccountID();
            try
            {
                return await _context.AccountInventories.Where(ai => ai.AccountId == accountID)
                                                        .Include(ai => ai.Material)
                                                        .ThenInclude(m => m.Category)
                                                        .Where(ai => ai.Material.Category != null)
                                                        .OrderBy(ai => ai.Material.SortPath)
                                                        .Select(ai => _mapper.Map<AccountInventoryDTO>(ai))
                                                        .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/AccountInventories/5
        [HttpGet("{materialID}")]
        public async Task<ActionResult<AccountInventoryDTO>> GetAccountInventory(string materialID)
        {
            var accountID = await AccountsController.GetAccountID();
            try
            {
                return await _context.AccountInventories.Where(ai => ai.AccountId == accountID && ai.MaterialId == materialID)
                                                        .Include(ai => ai.Material)
                                                        .ThenInclude(m => m.Category)
                                                        .Where(ai => ai.Material.Category != null)
                                                        .Select(ai => _mapper.Map<AccountInventoryDTO>(ai))
                                                        .FirstAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }

        }

        // GET: api/AccountInventories/multi
        [HttpGet("filter")]
        public async Task<ActionResult<IEnumerable<AccountInventoryDTO>>> GetAccountInventories(List<string> materials)
        {
            var accountID = await AccountsController.GetAccountID();
            try
            {
                return await _context.AccountInventories.Where(ai => ai.AccountId == accountID && materials.Any(m => m == ai.MaterialId))
                                                        .Include(ai => ai.Material)
                                                        .ThenInclude(m => m.Category)
                                                        .Where(ai => ai.Material.Category != null)
                                                        .OrderBy(ai => ai.Material.SortPath)
                                                        .Select(ai => _mapper.Map<AccountInventoryDTO>(ai))
                                                        .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/AccountInventories/untracked
        [HttpGet("untracked")]
        public async Task<ActionResult<IEnumerable<MaterialDTO>>> GetUntrackedInventory()
        {
            var accountID = await AccountsController.GetAccountID();
            try
            {
                return await _context.Materials.Include(m => m.Category)
                                               .Where(m => m.Category != null
                                                           && !_context.AccountInventories.Any(aw => aw.AccountId == accountID && aw.MaterialId == m.MaterialId))
                                               .OrderBy(m => m.SortPath)
                                               .Select(m => _mapper.Map<MaterialDTO>(m))
                                               .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }



        // PUT: api/AccountInventories/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{materialID}")]
        public async Task<IActionResult> PutAccountInventory(string materialID, AccountInventoryDTO accountInventoryDTO)
        {
            var accountID = await AccountsController.GetAccountID();
            var accountInventory = await _context.AccountInventories.FindAsync(accountID, materialID);

            accountInventory.Quantity = accountInventoryDTO.Quantity;

            _context.Entry(accountInventory).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException) when (!AccountInventoryExists(accountID, materialID))
            {
                return NotFound();
            }

            return NoContent();
        }

        // POST: api/AccountInventories
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<AccountInventory>> PostAccountInventory(AccountInventoryDTO accountInventoryDTO)
        {
            var accountID = await AccountsController.GetAccountID();
            var accountInventory = _mapper.Map<AccountInventory>(accountInventoryDTO);
            accountInventory.AccountId = accountID;

            _context.AccountInventories.Add(accountInventory);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException) when (AccountInventoryExists(accountInventory.AccountId, accountInventory.MaterialId))
            {
                return Conflict();
            }

            return CreatedAtAction(
                nameof(GetAccountInventory),
                new { accountID = accountInventory.AccountId, materialID = accountInventory.MaterialId },
                _mapper.Map<AccountInventoryDTO>(accountInventory));
        }

        // DELETE: api/AccountInventories/5
        [HttpDelete("{materialID}")]
        public async Task<IActionResult> DeleteAccountInventory(string materialID)
        {
            var accountID = await AccountsController.GetAccountID();
            var accountInventory = await _context.AccountInventories.FindAsync(accountID, materialID);
            if (accountInventory == null)
            {
                return NotFound();
            }

            _context.AccountInventories.Remove(accountInventory);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool AccountInventoryExists(int accountID, string materialID)
        {
            return _context.AccountInventories.Any(e => e.AccountId == accountID && e.MaterialId == materialID);
        }
    }
}
