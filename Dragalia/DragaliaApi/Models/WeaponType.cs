﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace DragaliaApi.Models
{
    public partial class WeaponType
    {
        public WeaponType()
        {
            Passives = new HashSet<Passive>();
            Weapons = new HashSet<Weapon>();
        }

        public int WeaponTypeId { get; set; }
        public string WeaponType1 { get; set; }

        public virtual ICollection<Passive> Passives { get; set; }
        public virtual ICollection<Weapon> Weapons { get; set; }
    }
}