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
    [Route("api/Passives")]
    [ApiController]
    public class PassivesController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public PassivesController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/Passives
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PassiveDTO>>> GetPassives()
        {
            try
            {
                return await _context.Passives.Include(p => p.Element)
                                      .Include(p => p.WeaponType)
                                      .Include(p => p.Ability)
                                      .OrderBy(p => p.WeaponTypeId)
                                      .ThenBy(p => p.Element.SortOrder)
                                      .ThenBy(p => p.SortOrder)
                                      .Select(p => _mapper.Map<PassiveDTO>(p))
                                      .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/Passives/5
        [HttpGet("{passiveID}")]
        public async Task<ActionResult<PassiveDTO>> GetPassive(int passiveID)
        {
            try
            {
                return await _context.Passives.Where(p => p.PassiveId == passiveID)
                                              .Include(p => p.Element)
                                              .Include(p => p.WeaponType)
                                              .Include(p => p.Ability)
                                              .Select(p => _mapper.Map<PassiveDTO>(p))
                                              .FirstOrDefaultAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }

        }
    }
}
