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
                                               .Where(m => m.Category != null)
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

        [HttpGet("quests")]
        public async Task<ActionResult<IEnumerable<MaterialQuestDTO>>> GetMaterialQuests(string materials)
        {
            string[] materialArray = materials != null ? materials.Split(',') : Array.Empty<string>();
            try
            {
                var mqs = await _context.MaterialQuests.Where(mq => materialArray.Length == 0
                                                                    || materialArray.Any(m => m == mq.MaterialId))
                                                       .Include(mq => mq.Material)
                                                       .ThenInclude(m => m.Category)
                                                       .Include(mq => mq.Quest)
                                                       .ToListAsync();

                var allQuests = await _context.Quests.ToListAsync();

                var newMqs = new List<MaterialQuest>();

                foreach (var mq in mqs)
                {
                    newMqs.AddRange(allQuests.Where(q => q.QuestId != mq.QuestId
                                                         && q.SortPath.IsDescendantOf(mq.Quest.SortPath))
                                       .Select(q => new MaterialQuest
                                       {
                                           Material = mq.Material,
                                           MaterialId = mq.MaterialId,
                                           Quest = q,
                                           QuestId = q.QuestId
                                       })
                                       .ToList());
                }

                mqs.AddRange(newMqs);

                return mqs.OrderBy(mq => mq.Quest.SortPath)
                          .ThenBy(mq => mq.Material.SortPath)
                          .Select(q => _mapper.Map<MaterialQuestDTO>(q))
                          .ToList();

            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }
    }
}
