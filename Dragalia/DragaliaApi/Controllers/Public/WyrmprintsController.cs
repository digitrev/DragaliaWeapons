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
    [Route("api/Wyrmprints")]
    [ApiController]
    public class WyrmprintsController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public WyrmprintsController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/Wyrmprints
        [HttpGet]
        public async Task<ActionResult<IEnumerable<WyrmprintDTO>>> GetWyrmprints()
        {
            try
            {
                return await _context.Wyrmprints.Include(wp => wp.Affinity)
                                                .Include(wp => wp.WyrmprintAbilities)
                                                .ThenInclude(wa => wa.Ability)
                                                .OrderByDescending(wp => wp.Rarity)
                                                .ThenByDescending(wp => wp.WyrmprintId)
                                                .Select(wp => _mapper.Map<WyrmprintDTO>(wp))
                                                .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/Wyrmprints/5
        [HttpGet("{wyrmprintID}")]
        public async Task<ActionResult<WyrmprintDTO>> GetWyrmprint(int wyrmprintID)
        {
            try
            {
                return await _context.Wyrmprints.Where(wp => wp.WyrmprintId == wyrmprintID)
                                                .Include(wp => wp.Affinity)
                                                .Include(wp => wp.WyrmprintAbilities)
                                                .ThenInclude(wa => wa.Ability)
                                                .Select(wp => _mapper.Map<WyrmprintDTO>(wp))
                                                .FirstOrDefaultAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }
    }
}
