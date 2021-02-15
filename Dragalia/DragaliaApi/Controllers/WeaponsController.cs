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
    [Route("api/WeaponList")]
    [ApiController]
    public class WeaponsController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public WeaponsController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/WeaponList
        [HttpGet]
        public async Task<ActionResult<IEnumerable<WeaponDTO>>> GetWeapons(string element, string series, string type)
        {
            try
            {
                return await _context.Weapons.Include(w => w.Element)
                                             .Include(w => w.WeaponSeries)
                                             .Include(w => w.WeaponType)
                                             .Where(w => (element == null || w.Element.Element1.Equals(element))
                                                         && (series == null || w.WeaponSeries.WeaponSeries1.Equals(series))
                                                         && (type == null || w.WeaponType.WeaponType1.Equals(type)))
                                             .Select(w => _mapper.Map<WeaponDTO>(w))
                                             .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/WeaponList/5
        [HttpGet("{id}")]
        public async Task<ActionResult<WeaponDTO>> GetWeapon(int id)
        {
            try
            {
                var weapon = await _context.Weapons.FindAsync(id);

                _context.Entry(weapon)
                        .Reference(w => w.Element)
                        .Load();

                _context.Entry(weapon)
                        .Reference(w => w.WeaponSeries)
                        .Load();

                _context.Entry(weapon)
                        .Reference(w => w.WeaponType)
                        .Load();

                if (weapon == null)
                {
                    return NotFound();
                }

                return _mapper.Map<WeaponDTO>(weapon);
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }
    }
}
