﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace DragaliaApi.Models
{
    public partial class Category
    {
        public Category()
        {
            Facilities = new HashSet<Facility>();
            Materials = new HashSet<Material>();
        }

        public int CategoryId { get; set; }
        public string Category1 { get; set; }

        public virtual ICollection<Facility> Facilities { get; set; }
        public virtual ICollection<Material> Materials { get; set; }
    }
}