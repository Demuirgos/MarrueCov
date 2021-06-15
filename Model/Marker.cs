using System;
using System.Collections.Generic;
using System.Linq;



namespace MarrueCov.Models
{
    public class Location
    {
        public double latitude { get; set; }
        public double longitude{ get; set; }
    }

    public class Pushpin
    {
        public string color{ get; set; }
        public Location location{ get; set; }
    }
}