module Model.RegionType exposing (..)
import Model.DataType exposing (..)


import Json.Decode as Deserializer
import Json.Encode as Serializer exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
type alias Region =
    { id : String
    , name : String
    , details : Data
    }

decodeRegion : Deserializer.Decoder Region
decodeRegion =
    decode Region
        |> required "id" (Deserializer.string)
        |> required "name" (Deserializer.string)
        |> required "details" (decodeData)

encodeRegion : Region -> Serializer.Value
encodeRegion record =
    Serializer.object
        [ ("id",  Serializer.string <| record.id)
        , ("name",  Serializer.string <| record.name)
        , ("details",  encodeData <| record.details)
        ]
