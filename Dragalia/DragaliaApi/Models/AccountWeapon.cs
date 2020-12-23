﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace DragaliaApi.Models
{
    public partial class AccountWeapon
    {
        public int AccountId { get; set; }
        public int WeaponId { get; set; }
        public int Copies { get; set; }
        public int CopiesWanted { get; set; }
        public int WeaponLevel { get; set; }
        public int WeaponLevelWanted { get; set; }
        public int Unbind { get; set; }
        public int UnbindWanted { get; set; }
        public bool Refine { get; set; }
        public bool RefineWanted { get; set; }
        public bool Slot { get; set; }
        public bool SlotWanted { get; set; }
        public bool Bonus { get; set; }
        public bool BonusWanted { get; set; }

        public virtual Account Account { get; set; }
        public virtual Weapon Weapon { get; set; }
    }
}