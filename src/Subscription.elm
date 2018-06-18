module Subscription exposing (subscriptions)

import Model exposing (Model, Msg)


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
