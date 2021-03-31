using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class DragonDTO
    {
        public int DragonId { get; set; }
        public string Dragon { get; set; }
        public int Rarity { get; set; }
        public string Element { get; set; }
    }
}
