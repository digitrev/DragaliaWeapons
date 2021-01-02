using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class WeaponDTO
    {
        public int? WeaponId { get; set; }
        public string Weapon1 { get; set; }
        public string WeaponSeries { get; set; }
        public string WeaponType { get; set; }
        public int? Rarity { get; set; }
        public string Element { get; set; }

        public static WeaponDTO ToDTO(Weapon weapon) => new WeaponDTO
        {
            WeaponId = weapon?.WeaponId,
            Weapon1 = weapon?.Weapon1,
            WeaponSeries = weapon?.WeaponSeries?.WeaponSeries1,
            WeaponType = weapon?.WeaponType?.WeaponType1,
            Rarity = weapon?.Rarity,
            Element = weapon?.Element?.Element1
        };
    }
}
