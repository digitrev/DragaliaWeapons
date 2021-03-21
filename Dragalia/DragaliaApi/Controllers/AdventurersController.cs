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
    [Route("api/Adventurers")]
    [ApiController]
    public class AdventurersController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public AdventurersController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/Adventurers
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AdventurerDTO>>> GetAdventurers()
        {
            try
            {
                return await _context.Adventurers.Include(a => a.Element)
                                                 .Include(a => a.WeaponType)
                                                 .OrderBy(a => a.Element.SortOrder)
                                                 .ThenBy(a => a.WeaponTypeId)
                                                 .ThenByDescending(a => a.Rarity)
                                                 .Select(a => _mapper.Map<AdventurerDTO>(a))
                                                 .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/Adventurers/5
        [HttpGet("{adventurerID}")]
        public async Task<ActionResult<AdventurerDTO>> GetAdventurer(int adventurerID)
        {
            try
            {
                return await _context.Adventurers.Where(a => a.AdventurerId == adventurerID)
                                                 .Include(a => a.Element)
                                                 .Include(a => a.WeaponType)
                                                 .Select(a => _mapper.Map<AdventurerDTO>(a))
                                                 .FirstOrDefaultAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }
    }
}
