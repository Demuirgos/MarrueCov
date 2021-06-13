module Model.DataType exposing (..)

import Json.Decode as Deserializer
import Json.Encode as Serializer 
import Json.Decode.Pipeline exposing (required, optional, hardcoded)

type alias Data = {
        confirmed   : Int,
        deaths      : Int,
        recovered   : Int,
        vaccinated  : Int,
        tested      : Int
    } 

decodeData : Deserializer.Decoder Data
decodeData =
    decode Data
        |> required "confirmed" (Deserializer.int)
        |> required "deaths" (Deserializer.int)
        |> required "recovered" (Deserializer.int)
        |> required "vaccinated" (Deserializer.int)
        |> required "tested" (Deserializer.int)

encodeData : Data -> Serializer.Value
encodeData record =
    Serializer.object
        [ ("confirmed",  Serializer.int <| record.confirmed)
        , ("deaths",  Serializer.int <| record.deaths)
        , ("recovered",  Serializer.int <| record.recovered)
        , ("vaccinated",  Serializer.int <| record.vaccinated)
        , ("tested",  Serializer.int <| record.tested)
        ]