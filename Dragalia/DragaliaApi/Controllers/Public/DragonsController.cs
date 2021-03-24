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
    [Route("api/[controller]")]
    [ApiController]
    public class DragonsController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public DragonsController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/Dragons
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DragonDTO>>> GetDragons()
        {
            try
            {
                return await _context.Dragons.Include(d => d.Element)
                                             .OrderByDescending(d => d.Rarity)
                                             .ThenBy(d => d.Element.SortOrder)
                                             .Select(d => _mapper.Map<DragonDTO>(d))
                                             .ToListAsync();

            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/Dragons/5
        [HttpGet("{dragonID}")]
        public async Task<ActionResult<DragonDTO>> GetDragon(int dragonID)
        {
            try
            {
                return await _context.Dragons.Where(d => d.DragonId == dragonID)
                                             .Include(d => d.Element)
                                             .OrderByDescending(d => d.Rarity)
                                             .ThenBy(d => d.Element.SortOrder)
                                             .Select(d => _mapper.Map<DragonDTO>(d))
                                             .FirstOrDefaultAsync();

            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }
    }
}
