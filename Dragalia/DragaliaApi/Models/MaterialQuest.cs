﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace DragaliaApi.Models
{
    public partial class MaterialQuest
    {
        public string MaterialId { get; set; }
        public int QuestId { get; set; }

        public virtual Material Material { get; set; }
        public virtual Quest Quest { get; set; }
    }
}