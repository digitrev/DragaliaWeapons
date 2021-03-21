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
    [Route("api/FacilityLimits")]
    [ApiController]
    public class FacilityLimitsController: ControllerBase
    {
        private readonly DragaliaContext _context;

        public FacilityLimitsController(DragaliaContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<FacilityLimits>>> GetFacilityLimits()
        {
            try
            {
                return await _context.Facilities.Include(f => f.FacilityUpgrades)
                    .Select(f => new FacilityLimits
                    {
                        FacilityID = f.FacilityId,
                        MaxLevel = f.FacilityUpgrades.Select(fu => fu.FacilityLevel)
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
        [HttpGet("{facilityID}")]
        public async Task<ActionResult<FacilityLimits>> GetFacilityLimitsByFacility(int facilityID)
        {
            try
            {
                return await _context.Facilities.Include(f => f.FacilityUpgrades)
                    .Select(f => new FacilityLimits
                    {
                        FacilityID = f.FacilityId,
                        MaxLevel = f.FacilityUpgrades.Select(fu => fu.FacilityLevel)
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
    }
}
