using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class AccountFacilityDTO
    {
        public int FacilityId { get; set; }
        public int CopyNumber { get; set; }
        public int CurrentLevel { get; set; }
        public int WantedLevel { get; set; }

        public virtual FacilityDTO Facility { get; set; }
    }
}
