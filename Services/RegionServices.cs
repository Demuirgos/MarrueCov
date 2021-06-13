using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Api.Models;
using MongoDB.Driver;

namespace Api.Services
{
    public class RegionService
    {
        private readonly IMongoCollection<Region> _regions;

        public RegionService(IDatabaseSettings settings)
        {
            var client = new MongoClient(settings.ConnectionString);
            var database = client.GetDatabase(settings.DatabaseName);

            _regions = database.GetCollection<Region>(settings.RegionsCollectionName);
        }

        public List<Region> Get() =>
            _regions.Find(Region => true).ToList();
        
        public void Create(Region region) =>
            _regions.InsertOne(region);

        public void Update(string _id, Region regionIn) =>
            _regions.ReplaceOne(region => region.Id == _id, regionIn);
    }
}
