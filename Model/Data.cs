using System;
using System.Collections.Generic;
using System.Linq;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Api.Models
{
    public record Data {
        public int Confirmed {get; set;}
        public int Deaths {get; set;}
        public int Recovered {get; set;}
        public int Vaccinated {get; set;}
        public int Tested {get; set;}
    } 
}