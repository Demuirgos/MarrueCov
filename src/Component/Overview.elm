module Component.Overview exposing (..)

import Bulma.CDN exposing (..)
import Bulma.Modifiers exposing (..)
import Bulma.Modifiers.Typography exposing (textCentered)
import Bulma.Form exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Components exposing (..)
import Bulma.Columns as Columns exposing (..)
import Bulma.Layout exposing (..)

import Html exposing (..)
import Model.DataType exposing(Stamp)

view : (Data, String) -> Html Msg
view model title =
    message myMessageModifiers []
    [ messageHeader []
      [ p [] [ text title ] 
      ]
    , messageBody []
      [ 
        div [] 
        [ 
          columns columnsModifiers []
          [ column columnModifiers [] 
            [ message myMessageModifiers []
              [ messageHeader []
                [ p [] [ text "Cases" ] 
                ]
              , messageBody []
                [ model.confirmed
                ]
              ]
            ]
          , column columnModifiers [] 
            [ message myMessageModifiers []
              [ messageHeader []
                [ p [] [ text "Tested" ] 
                ]
              , messageBody []
                [ model.tested
                ]
              ]
            ]
          , column columnModifiers [] 
            [ message myMessageModifiers []
              [ messageHeader []
                [ p [] [ text "Recovered" ] 
                ]
              , messageBody []
                [ model.recovered
                ]
              ]
            ]
          ]
        ]
        div [] 
        [ 
          columns columnsModifiers []
          [ column columnModifiers [] 
            [ message myMessageModifiers []
              [ messageHeader []
                [ p [] [ text "Deaths" ] 
                ]
              , messageBody []
                [ model.deaths
                ]
              ]
            ]
          , column columnModifiers [] 
            [ message myMessageModifiers []
              [ messageHeader []
                [ p [] [ text "Vaccinated" ] 
                ]
              , messageBody []
                [ model.vaccinated
                ]
              ]
            ]
          , column columnModifiers [] 
            [ message myMessageModifiers []
              [ messageHeader []
                [ p [] [ text "Population" ] 
                ]
              , messageBody []
                [ text "36.47 million"
                ]
              ]
            ]
          ]
        ]
        ]
      ]
    ]