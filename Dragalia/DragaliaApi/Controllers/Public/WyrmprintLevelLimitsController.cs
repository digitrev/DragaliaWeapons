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

namespace DragaliaApi.Controllers.Public
{
    [Route("api/[controller]")]
    [ApiController]
    public class WyrmprintLevelLimitsController : ControllerBase
    {
        private readonly DragaliaContext _context;

        public WyrmprintLevelLimitsController(DragaliaContext context)
        {
            _context = context;
        }

        // GET: api/WyrmprintLevelLimits
        [HttpGet]
        public async Task<ActionResult<IEnumerable<WyrmprintLimits>>> GetWyrmprintLevelLimits()
        {
            try
            {
                return await _context.WyrmprintLevelLimits
                    .GroupBy(wll => wll.WyrmprintRarity,
                                (r, wll) => new WyrmprintLimits
                        {
                            Rarity = r,
                            Level = wll.Max(w => w.MaxWyrmprintLevel)
                        })
                    .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/WyrmprintLevelLimits/5
        [HttpGet("{rarity}")]
        public async Task<ActionResult<WyrmprintLimits>> GetWyrmprintLevelLimit(int rarity)
        {
            try
            {
                var rval = await _context.WyrmprintLevelLimits.Where(wll => wll.WyrmprintRarity == rarity)
                    .GroupBy(wll => wll.WyrmprintRarity,
                                (r, wll) => new WyrmprintLimits
                                {
                                    Rarity = r,
                                    Level = wll.Max(w => w.MaxWyrmprintLevel)
                                })
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
    }
}
