module Subscription exposing (subscriptions)

import Keyboard exposing (KeyCode, downs)
import Model exposing (Model, Msg(..))


subscriptions : Model -> Sub Msg
subscriptions model =
    downs <| handleKey model


handleKey : Model -> KeyCode -> Msg
handleKey model code =
    case code of
        39 ->
            Indent model.focus

        _ ->
            NoOp
