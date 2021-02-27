using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class AccountInventoryDTO
    {
        public string MaterialId { get; set; }
        public int Quantity { get; set; }

        public virtual MaterialDTO Material { get; set; }
    }
}
