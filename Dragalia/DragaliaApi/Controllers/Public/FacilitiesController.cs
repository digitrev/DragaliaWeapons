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

namespace DragaliaApi.Controllers.Public
{
    [Route("api/FacilityList")]
    [ApiController]
    public class FacilitiesController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public FacilitiesController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/Facilities
        [HttpGet]
        public async Task<ActionResult<IEnumerable<FacilityDTO>>> GetFacilities()
        {
            try
            {
                return await _context.Facilities.Include(f => f.Category)
                                                .OrderBy(f => f.Category.SortPath)
                                                .ThenBy(f => f.FacilityId)
                                                .Select(f => _mapper.Map<FacilityDTO>(f))
                                                .ToListAsync();
            }
            catch(Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/Facilities/5
        [HttpGet("{facilityID}")]
        public async Task<ActionResult<FacilityDTO>> GetFacility(int facilityID)
        {
            try
            {
                return await _context.Facilities.Where(f => f.FacilityId == facilityID)
                                                .Include(f => f.Category)
                                                .Select(f => _mapper.Map<FacilityDTO>(f))
                                                .FirstAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        private bool FacilityExists(int id)
        {
            return _context.Facilities.Any(e => e.FacilityId == id);
        }
    }
}
