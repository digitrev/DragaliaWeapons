using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DragaliaApi.Models.DTO
{
    public class ElementDTO
    {
        public int ElementId { get; set; }
        public string Element1 { get; set; }

        public static ElementDTO ToTDO(Element element) => new ElementDTO
        {
            ElementId = element.ElementId,
            Element1 = element.Element1
        };
    }
}
