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
    [Route("api/Weapons")]
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

        // GET: api/Weapons
        [HttpGet]
        public async Task<ActionResult<IEnumerable<WeaponDTO>>> GetWeapons()
        {
            return await _context.Weapons.Include(w => w.Element)
                                         .Include(w => w.WeaponSeries)
                                         .Include(w => w.WeaponType)
                                         .Select(w => _mapper.Map<WeaponDTO>(w))
                                         .ToListAsync();
        }

        // GET: api/Weapons/5
        [HttpGet("{id}")]
        public async Task<ActionResult<WeaponDTO>> GetWeapon(int id)
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
    }
}
