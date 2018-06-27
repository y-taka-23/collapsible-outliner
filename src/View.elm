module View exposing (view)

import List exposing (range, length)
import List.Extra exposing (zip)
import Html exposing (div, text, Html)
import Html.Events exposing (onClick)
import Html.Attributes exposing (contenteditable)
import Model exposing (Model, Msg(..), Item(..), ItemPath)


view : Model -> Html Msg
view model =
    div [] <| List.map (viewItem []) (numerate model)


viewItem : ItemPath -> ( Int, Item ) -> Html Msg
viewItem parent ( n, Item item ) =
    let
        path =
            n :: parent
    in
        div
            []
            [ div
                [ onClick <| Toggle path ]
                [ if item.expanded then
                    text "-"
                  else
                    text "+"
                ]
            , div [ onClick <| Indent path ] [ text ">>" ]
            , div
                [ contenteditable True ]
                [ text <| toString path ++ item.contents ]
            , div []
                (if item.expanded then
                    List.map (viewItem path) (numerate item.children)
                 else
                    []
                )
            ]


numerate : List a -> List ( Int, a )
numerate xs =
    zip (range 0 (length xs - 1)) xs
