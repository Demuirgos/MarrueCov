module Component.Map exposing (..)
import Html exposing (Html, button, div, text)

import Model.Region exposing(Stamp)
import Model.RegionsData exposing (..)

import Maps exposing (..)
import Maps.Geo exposing (..)
import Maps.Map exposing (..)
import Maps.Marker exposing (..)
import Maps.Convert exposing (..)

import Html.Styled as Html
import Html.Styled.Event exposing (onClick)
import Maps


type alias Regions = List Region
type MyMsg = Click | MapsMsg Maps.Msg
type alias Marker = Maybe {
  Name : String
, LatLng : Flaot * Float
}

view msg model region=
  let
    morocco =
      bounds
          { northEast = latLng 34.6820 1.9002
          , southWest = latLng 29.2302 10.2276
          }
    let pointer = 
      model
      |> viewBounds morocco
    let tack map = 
      case region of 
        Just name -> 
          regions
          |> List.filter \region -> region.Name = name
          |> List.map \region -> region.LatLng
          |> List.map (uncurry Maps.Geo.latLng)
        None -> 
          []
    let mark map = 
        map
        |> updateMarkers (\markers -> List.map Marker.create attractions ++ markers)
  in
  Html.div
    []
    [ Maps.view (pointer.map |> tack |> mark) |> Maps.mapView MapsMsg
    , Html.button [ onClick Click ] [ Html.text "Go here!" ]
    ]