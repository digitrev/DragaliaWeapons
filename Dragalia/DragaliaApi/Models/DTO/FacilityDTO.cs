using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class FacilityDTO
    {
        public int FacilityId { get; set; }
        public string Facility { get; set; }
        public int Limit { get; set; }
        public string Category { get; set; }
    }
}
