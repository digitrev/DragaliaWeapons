using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class WeaponDTO
    {
        public int WeaponId { get; set; }
        public string Weapon { get; set; }
        public string WeaponSeries { get; set; }
        public string WeaponType { get; set; }
        public int Rarity { get; set; }
        public string Element { get; set; }
    }
}
