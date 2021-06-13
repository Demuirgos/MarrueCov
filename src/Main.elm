module Main exposing (..)

import Model.MoroccoData exposing (..)
import Model.RegionsData exposing (..)

import Bulma.CDN exposing (..)
import Bulma.Modifiers exposing (..)
import Bulma.Modifiers.Typography exposing (textCentered)
import Bulma.Form exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Components exposing (..)
import Bulma.Columns as Columns exposing (..)
import Bulma.Layout exposing (..)

import Component.Chart as Chart
import Component.Map as Map
import Component.Overview as Overview
import Component.Table as Table
import Component.Compact as Compact
import Component.Navigation as Navigation 


import Browser
import Html exposing (..)
import Html.Attributes exposing (..)

import Http

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

type alias Record 
  = { Global : Morocco
    , Region : String
    } 

type Model
  = Failure
  | Loading
  | Success Record


init : () -> (Model, Cmd Msg)
init _ =
  ( Loading
  , Http.get
      { url = "http://localhost:8000/Country"
      , expect = Http.expectJson GotGif decodeMorocco
      }
  )

type Msg
  = GotData (Result Http.Error Morocco)
    | SetRegion (String)

region name 
  = 
    List.filter (\rep -> rep.Name == name)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotData result ->
      case result of
        Ok model ->
          (Success model, Cmd.none)

        Err _ ->
          (Failure, Cmd.none)
    SetRegion region -> 
      (Success { model | Region = region})
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
    let
        
    in 
    case model of
        Failure ->
          text "I was unable to load your book."
        Loading ->
          text "Loading..."

        Success model ->
          main_ []
          [ stylesheet
          , Navigation.view
          , Overview.view (model.details) {- a changer -}
          , section NotSpaced []
            [ container []
              [ menu []
                [ menuLabel [] [ text "Regions : " ]
                , menuList  [] 
                  (List.map \region -> menuListItem False [ onClick (SetRegion region.Name)] [ text region.Name ] regions)
                ]
              , columns columnsModifiers []
                [ column columnModifiers [] 
                    [ 
                      card []
                      [ cardHeader []
                        [ cardTitle [] 
                          [ text "Spacial Data"
                          ]
                        ] 
                      ,cardImage   [] [
                        Map.view model.Region
                      ]
                      , cardContent [] [
                        Table.view model.regions
                      ]
                      ]
                    ]
                , column columnModifiers [] 
                    [ 
                      card []
                      [ cardHeader []
                        [ cardTitle [] 
                          [ text "Temporal Data"
                          ]
                        ] 
                      ,cardImage   [] [
                        Compact.view model.details
                      ]
                      , cardContent [] [
                        Chart.view model.evolution
                      ]
                      ]
                    ]
                ]
              ]
            ]
          ]