module View exposing (view)

import Html exposing (div, text, Html)
import Model exposing (Model, Msg)


view : Model -> Html Msg
view model =
    div [] [ text "Hello, Elm!" ]
