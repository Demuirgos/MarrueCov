module Component.Table exposing (..)

import Bulma.CDN exposing (..)
import Bulma.Modifiers exposing (..)
import Bulma.Modifiers.Typography exposing (textCentered)
import Bulma.Form exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Components exposing (..)
import Bulma.Columns as Columns exposing (..)
import Bulma.Layout exposing (..)

import Html exposing (..)
import Model.RegionType exposing(Region)
import Model.DataType exposing(Data)

type alias Regions = List Region
view : Regions -> Html Msg
view model =
  let 
    total 
      = List.foldr (\x a -> {
        confirmed = x.confirmed + a.confirmed
      , recovered = x.recovered + a.recovered
      , deaths    = x.deaths + a.deaths
      , tested    = x.tested + a.tested
      , vaccinated= x.vaccinated + a.vaccinated
      } ) (Data 0 0 0 0 0 0) model
  in
  table tableModifiers []
    [ tableHead [] 
    [ tableRow False []
      [ tableCellHead [] [ text "Region"]
      , tableCellHead [] [ text "Confirmed"]
      , tableCellHead [] [ text "Recovered"]
      , tableCellHead [] [ text "Deaths"]
      , tableCellHead [] [ text "Tested"]
      , tableCellHead [] [ text "Vaccinated"]
      ]
    ]
    , tableBody [] (List.map \region -> tableRow True  []
      [ tableCell [] [ region.name ]
      , tableCell [] [ region.confirmed ]
      , tableCell [] [ region.recovered  ]
      , tableCell [] [ region.deaths ]
      , tableCell [] [ region.tested ]
      , tableCell [] [ region.vaaccinated ]
      ])
    , tableFoot []
      [ tableRow False []
        [ tableCellHead [] [ text "total"]
        , tableCellHead [] [ total.confirmed]
        , tableCellHead [] [ total.recovered]
        , tableCellHead [] [ total.deaths]
        , tableCellHead [] [ total.tested]
        , tableCellHead [] [ total.vaccinated]
        ]
      ]
    ]