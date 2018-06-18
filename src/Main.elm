module Main exposing (main)

import Html exposing (program)
import Model exposing (Model, Msg, init)
import Update exposing (update)
import View exposing (view)
import Subscription exposing (subscriptions)


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
