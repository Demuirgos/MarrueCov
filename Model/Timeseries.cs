using System;
using System.Collections.Generic;
using System.Linq;

namespace MarrueCov.Models
{
    public record TimeStamp
    {
        public string Id { get; set; }
        public DateTime Date {get; set;}
        public Data Details { get; set; }
    }
}