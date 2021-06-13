using System;
using System.Collections.Generic;
using System.Collections;
using System.Text;
using System.Linq;
using System.Net;
using Newtonsoft.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using MongoDB.Driver.Linq;
using MongoDB.Driver;
using Api.Models;

namespace Api.Services
{
    public class MainService
    {
        private readonly RegionService _regionsService;
        private readonly TimeSerieService _timeSeriesService;
        private readonly IMongoCollection<TrackerMarker> _timeStamps;

        public MainService(IDatabaseSettings settings)
        {
            var client = new MongoClient(settings.ConnectionString);
            var database = client.GetDatabase(settings.DatabaseName);

            _timeStamps = database.GetCollection<TrackerMarker>(settings.TimeStampsCollectionName);
            _regionsService = new RegionService(settings);
            _timeSeriesService = new TimeSerieService(settings);
        }

        public Country Get() {
            Update(this);
            return new Country {
                Name = "Morocco",
                Regions = _regionsService.Get().ToArray(),
                Evolution = _timeSeriesService.Get().ToArray(),
                Details = Details(_timeSeriesService.Get())
            };
        }

        public Data Details (IEnumerable<TimeStamp> stamps) => 
            new Data {
                Vaccinated = (from stamp in stamps select stamp.Details.Vaccinated).Sum(),
                Deaths =  (from stamp in stamps select stamp.Details.Deaths).Sum(),
                Recovered =  (from stamp in stamps select stamp.Details.Recovered).Max(),
                Tested =  (from stamp in stamps select stamp.Details.Tested).Sum(),
                Confirmed =  (from stamp in stamps select stamp.Details.Confirmed).Sum()
            };

        public static Action<MainService> Update = (MainService reference) => {
            var isUpdate = reference._timeStamps.AsQueryable<TrackerMarker>()
                                    .OrderByDescending(stamp => stamp.Date)
                                    .Where(stamp => stamp.Date == DateTime.Now.ToString("MM/dd/yyyy"))
                                    .Any();
            if(isUpdate) return;

            using(var client = new WebClient()){

                var regionJson = client.DownloadString("https://services3.arcgis.com/hjUMsSJ87zgoicvl/arcgis/rest/services/Covid_19/FeatureServer/0/query?where=1%3D1&outFields=RegionFr,Cases,Deaths,Recoveries,Nom_Région_FR&returnGeometry=false&outSR=4326&f=json");
                dynamic regionData = JsonConvert.DeserializeObject(regionJson);
                var regionIsolated = regionData.features;

                var timeJson = new Dictionary<string, dynamic>() {
                    ["part1"] = JsonConvert.DeserializeObject(Encoding.ASCII.GetString(client.DownloadData("https://covid.ourworldindata.org/data/owid-covid-data.json"))),
                    ["part2"] = JsonConvert.DeserializeObject(Encoding.ASCII.GetString(client.DownloadData("https://pomber.github.io/covid19/timeseries.json")))
                };
                var timeStampsPart1 = timeJson["part1"].MAR.data;
                var timeStampsPart2 = timeJson["part2"].Morocco;

                var time_records   =from stamp in ((IEnumerable) timeStampsPart1).Cast<dynamic>()
                                    let found =(from record in reference._timeSeriesService.Get() 
                                                where record.Date == (DateTime)stamp.date 
                                                select record).Count() > 0
                                    where found == false
                                    select new TimeStamp {
                                        Date = stamp.date,
                                        Details = new Data {
                                            Confirmed = stamp.new_cases ?? 0,
                                            Deaths = stamp.new_deaths ?? 0,
                                            Recovered =(from stamp2 in ((IEnumerable) timeStampsPart2).Cast<dynamic>() 
                                                        where (DateTime) stamp2.date ==  (DateTime)stamp.date 
                                                        select stamp2.recovered).FirstOrDefault() ?? 0,
                                            Vaccinated = stamp.new_vaccinations ?? 0,
                                            Tested = stamp.new_tests ?? 0
                                        }
                                    };
                foreach (TimeStamp stamp in time_records)
                {
                    reference._timeSeriesService.Create(stamp);
                }

                var region_records =from region in ((IEnumerable) regionIsolated).Cast<dynamic>() 
                                    select new Region {
                                        Name = region.attributes.Nom_Région_FR,
                                        Details = new Data {
                                            Confirmed = region.attributes.Cases ?? 0,
                                            Deaths = region.attributes.Deaths ?? 0,
                                            Recovered = region.attributes.Recoveries ?? 0, 
                                            Vaccinated = 0,
                                            Tested = 0
                                        }
                                    };
                foreach (Region record in region_records)
                {
                    System.Diagnostics.Debug.WriteLine(record);
                    var newRecord = (from _record in reference._regionsService.Get() where _record.Name == record.Name select record with {
                        Id = _record.Id
                    }).ToList();
                    if(newRecord.Count > 0) 
                        reference._regionsService.Update(newRecord[0].Id, newRecord[0]);
                    else
                        reference._regionsService.Create(record);
                }
            } 
            reference._timeStamps.InsertOne(new TrackerMarker {Date = DateTime.Now.ToString("MM/dd/yyyy")});
        };
    }
}

