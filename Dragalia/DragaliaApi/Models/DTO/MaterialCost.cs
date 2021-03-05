using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class MaterialCost
    {
        public string Product { get; set; }
        public MaterialDTO Material { get; set; }
        public int Quantity { get; set; }
    }
}
