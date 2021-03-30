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
    public class QuestsController : ControllerBase
    {
        private readonly DragaliaContext _context;
        private readonly IMapper _mapper;

        public QuestsController(DragaliaContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/Quests
        [HttpGet]
        public async Task<ActionResult<IEnumerable<QuestDTO>>> GetQuests()
        {
            try
            {
                return await _context.Quests.OrderBy(q => q.SortPath)
                                            .Select(q => _mapper.Map<QuestDTO>(q))
                                            .ToListAsync();
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }

        // GET: api/Quests/5
        [HttpGet("{questID}")]
        public async Task<ActionResult<QuestDTO>> GetQuest(int questID)
        {
            try
            {
                var rval = await _context.Quests.Where(q => q.QuestId == questID)
                                                .Select(q => _mapper.Map<QuestDTO>(q))
                                                .FirstOrDefaultAsync();

                if (rval == null)
                    return NotFound();
                return rval;
            }
            catch (Exception ex)
            {
                return Problem(detail: ex.ToString(), statusCode: 500);
            }
        }
    }
}
