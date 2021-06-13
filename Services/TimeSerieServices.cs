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
    public class TimeSerieService
    {
        private readonly IMongoCollection<TimeStamp> _timeStamp;

        public TimeSerieService(IDatabaseSettings settings)
        {
            var client = new MongoClient(settings.ConnectionString);
            var database = client.GetDatabase(settings.DatabaseName);

            _timeStamp = database.GetCollection<TimeStamp>(settings.TimeSeriesCollectionName);
        }

        public List<TimeStamp> Get() =>
            _timeStamp.Find(TimeStamp => true).ToList();

        public TimeStamp Create(TimeStamp TimeStamp)
        {
            _timeStamp.InsertOne(TimeStamp);
            return TimeStamp;
        }

        public void Update(string id, TimeStamp TimeStampIn) =>
            _timeStamp.ReplaceOne(TimeStamp => TimeStamp.Id == id, TimeStampIn);
    }
}
