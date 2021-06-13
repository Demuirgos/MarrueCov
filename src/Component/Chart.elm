module Component.Chart exposing (view)

import Html exposing (Html, button, div, text)
import Model.StampType exposing(Stamp)

import Axis
import Color exposing (Color)
import Path exposing (Path)
import Scale exposing (ContinuousScale, OrdinalScale)
import Scale.Color
import Shape
import Statistics
import Time
import TypedSvg exposing (g, svg, text_)
import TypedSvg.Attributes exposing (class, dy, fill, fontFamily, stroke, textAnchor, transform, viewBox)
import TypedSvg.Attributes.InPx exposing (fontSize, height, strokeWidth, x, y)
import TypedSvg.Core exposing (Svg, text)
import TypedSvg.Types exposing (AnchorAlignment(..), Paint(..), Transform(..), em)

type alias Stamps = List Stamp
type alias Record =
    { day : Int
    , confirmed : Int
    , deaths : Int
    , recovered : Int
    , tested : Int
    , vaccinated : Int
    }
    

w : Float
w =
    900


h : Float
h =
    450


padding : Float
padding =
    60


series : List { label : String, accessor : Record -> Int }
series =
    [ { label = "deaths"
      , accessor = .deaths
      }
    , { label = "recovered"
      , accessor = .recovered
      }
    , { label = "tested"
      , accessor = .tested
      }
    , { label = "vaccinated"
      , accessor = .vaccinated
      }
    ]


accessors : List (Record -> Int)
accessors =
    List.map .accessor series


values : Record -> List Float
values i =
    List.map (\a -> toFloat <| a i) accessors


colorScale : OrdinalScale String Color
colorScale =
    List.map .label series
        |> Scale.ordinal Scale.Color.category10


color : String -> Color
color =
    Scale.convert colorScale >> Maybe.withDefault Color.black


view : Stamps -> Svg msg
view model =
    let
        records = 
          model
          |> List.map \stmp -> Record stmp.date stmp.details.confirmed stmp.details.deaths stmp.details.recovered stmp.details.tested stmp.details.vaccinated
        last =
            List.reverse model
                |> List.head
                |> Maybe.withDefault (Record 12 0 0 0 0 0 )

        first =
            List.head model
                |> Maybe.withDefault (Record 1 0 0 0 0 0 )

        xScale : ContinuousScale Float
        xScale =
            model
                |> List.map (.day >> toFloat)
                |> Statistics.extent
                |> Maybe.withDefault ( 1, 12 )
                |> Scale.linear ( 0, w - 2 * padding )

        yScale : ContinuousScale Float
        yScale =
            model
                |> List.map (values >> List.maximum >> Maybe.withDefault 0)
                |> List.maximum
                |> Maybe.withDefault 0
                |> (\b -> ( 0, b ))
                |> Scale.linear ( h - 2 * padding, 0 )
                |> Scale.nice 4

        lineGenerator : ( Int, Int ) -> Maybe ( Float, Float )
        lineGenerator ( x, y ) =
            Just ( Scale.convert xScale (toFloat x), Scale.convert yScale (toFloat y) )

        line : (Record -> Int) -> Path
        line accessor =
            List.map (\i -> ( .day i, accessor i )) model
                |> List.map lineGenerator
                |> Shape.line Shape.monotoneInXCurve
    in
    svg [ viewBox 0 0 w h ]
        [ g [ transform [ Translate (padding - 1) (h - padding) ] ]
            [ Axis.bottom [ Axis.tickCount 10 ] xScale ]
        , g [ transform [ Translate (padding - 1) padding ] ]
            [ Axis.left [ Axis.ticks (values first) ] yScale
            , text_ [ fontFamily [ "sans-serif" ], fontSize 10, x 5, y 5 ] [ text "Occurences" ]
            ]
        , g [ transform [ Translate padding padding ], class [ "series" ] ]
            (List.map
                (\{ accessor, label } ->
                    Path.element (line accessor)
                        [ stroke <| Paint <| color label
                        , strokeWidth 3
                        , fill PaintNone
                        ]
                )
                series
            )
        , g [ fontFamily [ "sans-serif" ], fontSize 10 ]
            (List.map
                (\{ accessor, label } ->
                    g
                        [ transform
                            [ Translate (w - padding + 10) (padding + Scale.convert yScale (toFloat (accessor last)))
                            ]
                        ]
                        [ text_ [ fill (Paint (color label)) ] [ text label ] ]
                )
                series
            )
        , g [ transform [ Translate (w - padding) (padding + 20) ] ]
            [ text_ [ fontFamily [ "sans-serif" ], fontSize 20, textAnchor AnchorEnd ] [ text "Violent Crime in the US" ]
            , text_ [ fontFamily [ "sans-serif" ], fontSize 10, textAnchor AnchorEnd, dy (em 1) ] [ text "Source: fbi.gov" ]
            ]
        ]