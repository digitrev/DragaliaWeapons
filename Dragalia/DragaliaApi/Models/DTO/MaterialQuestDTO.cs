using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class MaterialQuestDTO
    {
        public string MaterialId { get; set; }
        public int QuestId { get; set; }

        public virtual MaterialDTO Material { get; set; }
        public virtual QuestDTO Quest { get; set; }

    }
}
