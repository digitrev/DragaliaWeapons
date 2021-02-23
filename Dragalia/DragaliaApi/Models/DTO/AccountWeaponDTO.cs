using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class AccountWeaponDTO
    {
        public int WeaponId { get; set; }
        public int Copies { get; set; }
        public int CopiesWanted { get; set; }
        public int WeaponLevel { get; set; }
        public int WeaponLevelWanted { get; set; }
        public int Unbind { get; set; }
        public int UnbindWanted { get; set; }
        public int Refine { get; set; }
        public int RefineWanted { get; set; }
        public bool Slot { get; set; }
        public bool SlotWanted { get; set; }
        public bool Bonus { get; set; }
        public bool BonusWanted { get; set; }
        public virtual WeaponDTO Weapon { get; set; }
    }
}
