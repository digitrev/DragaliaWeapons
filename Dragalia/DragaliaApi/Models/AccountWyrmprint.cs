﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace DragaliaApi.Models
{
    public partial class AccountWyrmprint
    {
        public int AccountId { get; set; }
        public int WyrmprintId { get; set; }
        public int WyrmprintLevel { get; set; }
        public int WyrmprintLevelWanted { get; set; }
        public int Unbind { get; set; }
        public int UnbindWanted { get; set; }
        public int Copies { get; set; }
        public int CopiesWanted { get; set; }

        public virtual Account Account { get; set; }
        public virtual Wyrmprint Wyrmprint { get; set; }
    }
}