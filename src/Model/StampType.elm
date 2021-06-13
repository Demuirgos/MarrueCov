module Model.StampType exposing (..)
import Model.DataType exposing(..)

import Json.Decode as Deserializer
import Json.Encode as Serializer exposing (..)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
type alias Stamp =
    { id : String
    , date : String
    , details : Data
    }


decodeStamp : Deserializer.Decoder Stamp
decodeStamp =
    decode Stamp
        |> required "id" (Deserializer.string)
        |> required "date" (Deserializer.string)
        |> required "details" (decodeData)

encodeStamp : Stamp -> Serializer.Value
encodeStamp record =
    Serializer.object
        [ ("id",  Serializer.string <| record.id)
        , ("date",  Serializer.string <| record.date)
        , ("details",  encodeData <| record.details)
        ]
