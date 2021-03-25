using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class AccountDragonDTO
    {
        public int DragonId { get; set; }
        public int Unbind { get; set; }
        public int UnbindWanted { get; set; }

        public virtual AccountDTO Account { get; set; }
        public virtual DragonDTO Dragon { get; set; }
    }
}
