﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace DragaliaApi.Models
{
    public partial class WeaponUpgrade
    {
        public int WeaponId { get; set; }
        public int UpgradeTypeId { get; set; }
        public int Step { get; set; }
        public string MaterialId { get; set; }
        public int Quantity { get; set; }

        public virtual Material Material { get; set; }
        public virtual UpgradeType UpgradeType { get; set; }
        public virtual Weapon Weapon { get; set; }
    }
}