﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace DragaliaApi.Models
{
    public partial class ManaCircle
    {
        public int AdventurerId { get; set; }
        public int ManaNode { get; set; }
        public string MaterialId { get; set; }
        public int Quantity { get; set; }

        public virtual Adventurer Adventurer { get; set; }
        public virtual Material Material { get; set; }
    }
}