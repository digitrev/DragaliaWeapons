﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace DragaliaApi.Models
{
    public partial class Affinity
    {
        public Affinity()
        {
            Wyrmprints = new HashSet<Wyrmprint>();
        }

        public int AffinityId { get; set; }
        public string Affinity1 { get; set; }
        public bool? Active { get; set; }

        public virtual ICollection<Wyrmprint> Wyrmprints { get; set; }
    }
}