module Model.MoroccoData exposing (..)
import Model.DataType exposing (..)
import Model.RegionType exposing (..)
import Model.StampType exposing (..)

import Json.Decode as Deserializer
import Json.Encode as Serializer exposing (..)
import Json.Decode.Pipeline exposing (required, optional, hardcoded)
type alias Morocco =
    { name : String
    , regions : List Region
    , evolution : List Stamp
    , details : Data
    }

decodeMorocco : Deserializer.Decoder Morocco
decodeMorocco =
    Deserializer.Pipeline.decode Morocco
        |> Deserializer.Pipeline.required "name" (Deserializer.string)
        |> Deserializer.Pipeline.required "regions" (Deserializer.list decodeRegion)
        |> Deserializer.Pipeline.required "evolution" (Deserializer.list decodeStamp)
        |> Deserializer.Pipeline.required "details" (decodeData)

encodeMorocco : Morocco -> Serializer.Value
encodeMorocco record =
    Serializer.object
        [ ("name",  Serializer.string <| record.name)
        , ("regions",  Serializer.list <| List.map encodeRegion <| record.regions)
        , ("evolution",  Serializer.list <| List.map encodeStamp <| record.evolution)
        , ("details",  encodeData <| record.details)
        ]
