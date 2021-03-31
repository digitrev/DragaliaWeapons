using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class AdventurerDTO
    {
        public int AdventurerId { get; set; }
        public string Adventurer { get; set; }
        public int Rarity { get; set; }
        public string Element { get; set; }
        public string WeaponType { get; set; }
        public int MCLimit { get; set; }

    }
}
