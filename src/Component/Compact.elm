module Component.Chart exposing (..)

import Bulma.CDN exposing (..)
import Bulma.Modifiers exposing (..)
import Bulma.Modifiers.Typography exposing (textCentered)
import Bulma.Form exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Components exposing (..)
import Bulma.Columns as Columns exposing (..)
import Bulma.Layout exposing (..)

import Html exposing (..)
import Model.Datatype exposing(Stamp)

view : Data -> Html Msg
view model =
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
          [ p [] [ text "Recovered" ] 
          ]
        , messageBody []
          [ model.recovered
          ]
        ]
      ]
    , column columnModifiers [] 
      [ message myMessageModifiers []
        [ messageHeader []
          [ p [] [ text "Death" ] 
          ]
        , messageBody []
          [ model.deaths
          ]
        ]
      ]
    , column columnModifiers [] 
      [ message myMessageModifiers []
        [ messageHeader []
          [ p [] [ text "vaccinated" ] 
          ]
        , messageBody []
          [ model.vaccinated
          ]
        ]
      ]
    ]