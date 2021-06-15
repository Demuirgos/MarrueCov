using System;
using System.Collections.Generic;
using System.Linq;

namespace MarrueCov.Models
{
    public record Region
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public Data Details { get; set; }
    }
}