using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class WyrmprintDTO
    {
        public int WyrmprintId { get; set; }
        public string Wyrmprint { get; set; }
        public int Rarity { get; set; }
        public string Affinity { get; set; }
        public IEnumerable<string> Abilities { get; set; }
    }
}
