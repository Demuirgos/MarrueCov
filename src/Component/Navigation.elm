module Component.Map exposing (..)

import Bulma.CDN exposing (..)
import Bulma.Modifiers exposing (..)
import Bulma.Modifiers.Typography exposing (textCentered)
import Bulma.Form exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Components exposing (..)
import Bulma.Columns as Columns exposing (..)
import Bulma.Layout exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)

import Model.Region exposing(Stamp)

type alias Regions = List Region
view : Html Msg
view =
    navbar navbarModifiers []
    [ navbarBrand []
    ( navbarBurger False []
        [ span [] []
        , span [] []
        , span [] []
        ]
    )
    [ navbarItem False []
        [ img [ src "https://bulma.io/images/bulma-logo.png" ] []
        ]
    ]
    ]