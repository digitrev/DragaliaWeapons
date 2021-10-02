﻿using System;
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
    [Route("api/MaterialList")]
    [ApiController]
    public class MaterialsController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public MaterialsController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/MaterialList
        [HttpGet]
        public async Task<ActionResult<IEnumerable<MaterialDTO>>> GetMaterials()
        {
            try
            {
                return await _context.Materials.Include(m => m.Category)
                                               .Where(m => m.Category.Category1 != "Unused")
                                               .OrderBy(m => m.SortPath)
                                               .Select(m => _mapper.Map<MaterialDTO>(m))
                                               .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/MaterialList/5
        [HttpGet("{id}")]
        public async Task<ActionResult<MaterialDTO>> GetMaterial(string id)
        {
            try
            {
                var material = await _context.Materials.FindAsync(id);

                if (material == null)
                {
                    return NotFound();
                }

                return _mapper.Map<MaterialDTO>(material);

            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

    }
}
