﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace DragaliaApi.Models
{
    public partial class WyrmprintLevel
    {
        public int Rarity { get; set; }
        public int WyrmprintLevel1 { get; set; }
        public string MaterialId { get; set; }
        public int Quantity { get; set; }

        public virtual Material Material { get; set; }
    }
}