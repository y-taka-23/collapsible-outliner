module View exposing (view)

import Html exposing (div, text, Html)
import Html.Events exposing (onClick)
import Html.Attributes exposing (contenteditable)
import Model exposing (Model, Msg(..), Item(..))


view : Model -> Html Msg
view model =
    div [] (List.map viewItem model)


viewItem : Item -> Html Msg
viewItem (Item item) =
    div
        []
        [ div
            [ onClick (Toggle item.path) ]
            [ if item.expanded then
                text "-"
              else
                text "+"
            ]
        , div [ contenteditable True ] [ text item.contents ]
        , div []
            (if item.expanded then
                List.map viewItem item.children
             else
                []
            )
        ]
