using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DragaliaApi.Data;
using DragaliaApi.Models;

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
