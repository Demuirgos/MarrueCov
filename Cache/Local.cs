using System;
using System.Collections.Generic;
using System.Linq;
using MarrueCov.Models;

namespace MarrueCov.Locals
{
    public class Geography
    {
        public string Name { get; set; }
        public Location Coordinates { get; set; }
    }

    public static class Geographic
    {
        public static List<Geography> Regions => new List<Geography>(){
            new Geography { Name =  "Casablanca-Settat" ,
                            Coordinates = new Location{
                                latitude = 33.5992, longitude =  -7.6200}},
            new Geography { Name =  "Fès-Meknès"        , 
                            Coordinates = new Location{
                                latitude = 34.0433, longitude =  -5.0033}},
            new Geography { Name =  "Oriental"          , 
                            Coordinates = new Location{
                                latitude = 34.6867, longitude =  -1.9114}},
            new Geography { Name =  "Tanger-Tétouan-Al Hoceïma", 
                            Coordinates = new Location{
                                latitude = 35.5667, longitude =  -5.3667}},
            new Geography { Name =  "Rabat-Salé-Kénitra", 
                            Coordinates = new Location{
                                latitude = 33.9234, longitude =  -6.9076}},
            new Geography { Name =  "Marrakech-Safi"    , 
                            Coordinates = new Location{
                                latitude = 32.2833, longitude =  -9.2333}},
            new Geography { Name =  "Casablanca-Settat" ,  
                            Coordinates = new Location{
                                latitude = 33.2333, longitude =  -8.5000}},
            new Geography { Name =  "Souss-Massa"       , 
                            Coordinates = new Location{
                                latitude = 30.3342, longitude =  -9.4972}},
            new Geography { Name =  "Fès-Meknès"        , 
                            Coordinates = new Location{
                                latitude = 34.2144, longitude =  -4.0088}},
            new Geography { Name =  "Guelmim-Oued Noun" , 
                            Coordinates = new Location{
                                latitude = 28.9833, longitude =  -10.0667}},
            new Geography { Name =  "Béni Mellal-Khénifra", 
                            Coordinates = new Location{
                                latitude = 32.9300, longitude =  -5.6600}},
            new Geography { Name =  "Drâa-Tafilalet"    , 
                            Coordinates = new Location{
                                latitude = 31.9319, longitude =  -4.4244}}
        };
    }
}