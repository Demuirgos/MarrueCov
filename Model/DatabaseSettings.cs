using System;
using System.Collections.Generic;
using System.Linq;

namespace Api.Models
{
    public class DatabaseSettings : IDatabaseSettings
    {
        public string RegionsCollectionName { get; set; }
        public string TimeSeriesCollectionName { get; set; }
        public string TimeStampsCollectionName { get; set; }
        public string ConnectionString { get; set; }
        public string DatabaseName { get; set; }
    }

    public interface IDatabaseSettings
    {
        string RegionsCollectionName { get; set; }
        string TimeSeriesCollectionName { get; set; }
        string TimeStampsCollectionName { get; set; }
        string ConnectionString { get; set; }
        string DatabaseName { get; set; }
    }
}