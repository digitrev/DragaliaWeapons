using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class AccountAdventurerDTO
    {
        public int AdventurerId { get; set; }
        public int CurrentLevel { get; set; }
        public int WantedLevel { get; set; }

        public virtual AdventurerDTO Adventurer { get; set; }
    }
}
