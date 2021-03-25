using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class AccountWyrmprintDTO
    {
        public int WyrmprintId { get; set; }
        public int WyrmprintLevel { get; set; }
        public int WyrmprintLevelWanted { get; set; }
        public int Unbind { get; set; }
        public int UnbindWanted { get; set; }
        public int Copies { get; set; }
        public int CopiesWanted { get; set; }

        public virtual WyrmprintDTO Wyrmprint { get; set; }
    }
}
