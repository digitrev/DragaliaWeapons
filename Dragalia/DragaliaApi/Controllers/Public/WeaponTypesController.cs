using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DragaliaApi.Data;
using DragaliaApi.Models;
using AutoMapper;
using DragaliaApi.Models.DTO;

namespace DragaliaApi.Controllers.Public
{
    [Route("api/weaponTypes")]
    [ApiController]
    public class WeaponTypesController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public WeaponTypesController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/WeaponTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<WeaponTypeDTO>>> GetWeaponTypes()
        {
            try
            {
                return await _context.WeaponTypes.OrderBy(wt => wt.WeaponTypeId)
                                                 .Select(wt => _mapper.Map<WeaponTypeDTO>(wt))
                                                 .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }
    }
}
