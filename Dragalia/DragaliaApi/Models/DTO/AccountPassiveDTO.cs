using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class AccountPassiveDTO
    {
        public int PassiveId { get; set; }
        public bool Owned { get; set; }
        public bool Wanted { get; set; }

        public virtual PassiveDTO Passive { get; set; }

    }
}
