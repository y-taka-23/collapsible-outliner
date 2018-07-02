module View exposing (view)

import Json.Decode exposing (Decoder, at, string, map)
import List exposing (range, length)
import List.Extra exposing (zip)
import Html exposing (div, text, i, Html, Attribute)
import Html.Events exposing (onClick, onFocus, onBlur, onInput, on)
import Html.Attributes exposing (id, class, contenteditable)
import Model exposing (Model, Msg(..), Item(..), ItemPath, defaultPath)


view : Model -> Html Msg
view model =
    div [ id "page" ]
        [ div [] <| List.map (viewItem []) (numerate model.items) ]


viewItem : ItemPath -> ( Int, Item ) -> Html Msg
viewItem parent ( n, Item item ) =
    let
        path =
            n :: parent
    in
        div
            [ class "item-container" ]
            [ div
                [ class "item-toggle-container" ]
                [ div
                    [ class "item-toggle"
                    , onClick <| Toggle path
                    ]
                    [ if item.expanded then
                        i [ class "far fa-minus-square" ] []
                      else
                        i [ class "far fa-plus-square" ] []
                    ]
                ]
            , div
                [ class "item-bullet-container" ]
                [ div
                    [ class "item-bullet" ]
                    [ if item.expanded then
                        i [ class "fas fa-angle-right" ] []
                      else
                        i [ class "fas fa-angle-double-right" ] []
                    ]
                ]
            , div [ class "item-content-container" ]
                [ div
                    [ class "item-content"
                    , onFocus <| Focus path
                    , onBlur <| Focus defaultPath
                    , onContentInput <| SetContents path
                    , contenteditable True
                    ]
                    [ text item.contents ]
                , div
                    [ class "item-children" ]
                    (if item.expanded then
                        List.map (viewItem path) (numerate item.children)
                     else
                        []
                    )
                ]
            ]


numerate : List a -> List ( Int, a )
numerate xs =
    zip (range 0 (length xs - 1)) xs


onContentInput : (String -> msg) -> Attribute msg
onContentInput tagger =
    on "input" (map tagger targetTextContent)


targetTextContent : Decoder String
targetTextContent =
    at [ "target", "textContent" ] string
