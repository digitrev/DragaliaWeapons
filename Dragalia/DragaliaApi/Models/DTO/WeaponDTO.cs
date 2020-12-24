using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class WeaponDTO
    {
        public int WeaponId { get; set; }
        public string Weapon1 { get; set; }
        public int WeaponSeriesId { get; set; }
        public int WeaponTypeId { get; set; }
        public int Rarity { get; set; }
        public int ElementId { get; set; }

        public virtual ElementDTO Element { get; set; }
        public virtual WeaponSeries WeaponSeries { get; set; }
        public virtual WeaponType WeaponType { get; set; }

        public static WeaponDTO ToDTO(Weapon weapon) => new WeaponDTO
        {
            WeaponId = weapon.WeaponId,
            Weapon1 = weapon.Weapon1,
            WeaponSeriesId = weapon.WeaponSeriesId,
            WeaponTypeId = weapon.WeaponTypeId,
            Rarity = weapon.Rarity,
            ElementId = weapon.ElementId,
            Element = weapon.Element == null ? null : ElementDTO.ToTDO(weapon.Element),
            WeaponSeries = weapon.WeaponSeries,
            WeaponType = weapon.WeaponType
        };
    }
}
