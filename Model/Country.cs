using System;
using System.Collections.Generic;
using System.Linq;

namespace MarrueCov.Models
{
    public record Country
    {
        public string Name { get; set; }
        public Region[] Regions { get; set; }
        public TimeStamp[] Evolution { get; set; }
        public Data Details {get; set;}
    }
}