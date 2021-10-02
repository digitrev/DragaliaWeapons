﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace DragaliaApi.Models
{
    public partial class Facility
    {
        public Facility()
        {
            FacilityUpgrades = new HashSet<FacilityUpgrade>();
        }

        public int FacilityId { get; set; }
        public string Facility1 { get; set; }
        public int Limit { get; set; }
        public int? CategoryId { get; set; }
        public bool? Active { get; set; }

        public virtual Category Category { get; set; }
        public virtual ICollection<FacilityUpgrade> FacilityUpgrades { get; set; }
    }
}