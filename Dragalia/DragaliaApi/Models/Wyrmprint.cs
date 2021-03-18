﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace DragaliaApi.Models
{
    public partial class Wyrmprint
    {
        public Wyrmprint()
        {
            AccountWyrmprints = new HashSet<AccountWyrmprint>();
            WyrmprintAbilities = new HashSet<WyrmprintAbility>();
            WyrmprintUpgrades = new HashSet<WyrmprintUpgrade>();
        }

        public int WyrmprintId { get; set; }
        public string Wyrmprint1 { get; set; }
        public int Rarity { get; set; }
        public int? AffinityId { get; set; }
        public bool? Active { get; set; }

        public virtual Affinity Affinity { get; set; }
        public virtual ICollection<AccountWyrmprint> AccountWyrmprints { get; set; }
        public virtual ICollection<WyrmprintAbility> WyrmprintAbilities { get; set; }
        public virtual ICollection<WyrmprintUpgrade> WyrmprintUpgrades { get; set; }
    }
}