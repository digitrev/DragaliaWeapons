using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class PassiveDTO
    {
        public int PassiveId { get; set; }
        public int AbilityNumber { get; set; }
        public string Ability { get; set; }
        public string Element { get; set; }
        public string WeaponType { get; set; }
    }
}
