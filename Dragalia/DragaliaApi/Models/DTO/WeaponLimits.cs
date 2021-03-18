using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class WeaponLimits
    {
        public int WeaponID { get; set; }
        public int Level { get; set; }
        public int Unbind { get; set; }
        public int Refinement { get; set; }
        public int Slots { get; set; }
        public int Dominion { get; set; }
        public int Bonus { get; set; }
    }
}
