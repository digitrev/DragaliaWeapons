﻿using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class MaterialDTO
    {
        public string MaterialId { get; set; }
        public string Material1 { get; set; }
        public string Category { get; set; }
        public bool? Active { get; set; }
    }
}