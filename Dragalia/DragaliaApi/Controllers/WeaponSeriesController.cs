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
    [Route("api/[controller]")]
    [ApiController]
    public class WeaponSeriesController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public WeaponSeriesController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/WeaponSeries
        [HttpGet]
        public async Task<ActionResult<IEnumerable<WeaponSeriesDTO>>> GetWeaponSeries()
        {
            try
            {
                return await _context.WeaponSeries.OrderBy(ws => ws.SortOrder)
                                                  .Select(ws => _mapper.Map<WeaponSeriesDTO>(ws))
                                                  .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }

        }
    }
}
