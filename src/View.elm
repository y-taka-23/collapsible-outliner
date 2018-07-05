module View exposing (view)

import List exposing (range, length)
import List.Extra exposing (zip)
import Html exposing (div, text, i, Html, Attribute)
import Html.Events as Events
import Html.Attributes exposing (id, class, contenteditable, style)
import Model exposing (Model, Msg(..), Item(..), ItemPath, defaultPath)


view : Model -> Html Msg
view model =
    div [ id "page" ]
        [ div [] <| List.map (viewItem model.mouse []) (numerate model.items) ]


viewItem : ItemPath -> ItemPath -> ( Int, Item ) -> Html Msg
viewItem mouse parent ( n, Item item ) =
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
                    , Events.onMouseEnter <| Mouse path
                    , Events.onMouseLeave <| Mouse defaultPath
                    ]
                    [ i
                        [ class
                            (if item.expanded then
                                "far fa-minus-square"
                             else
                                "far fa-plus-square"
                            )
                        , toggleStyle mouse path item.children
                        , Events.onClick <| Toggle path
                        ]
                        []
                    ]
                ]
            , div
                [ class "item-bullet-container" ]
                [ div
                    [ class "item-bullet"
                    , Events.onMouseEnter <| Mouse path
                    , Events.onMouseLeave <| Mouse defaultPath
                    ]
                    [ if item.expanded then
                        i [ class "fas fa-angle-right" ] []
                      else
                        i [ class "fas fa-angle-double-right" ] []
                    ]
                ]
            , div [ class "item-content-container" ]
                [ div
                    [ class "item-content"
                    , Events.onFocus <| Focus path
                    , Events.onBlur <| Focus defaultPath
                    , Events.onMouseEnter <| Mouse path
                    , Events.onMouseLeave <| Mouse defaultPath
                    , contenteditable True
                    ]
                    [ text item.contents ]
                , div
                    [ class "item-children" ]
                    (if item.expanded then
                        List.map (viewItem mouse path) (numerate item.children)
                     else
                        []
                    )
                ]
            ]


toggleStyle : ItemPath -> ItemPath -> List Item -> Attribute msg
toggleStyle mouse path children =
    if mouse == path && length children > 0 then
        style []
    else
        style [ ( "visibility", "hidden" ) ]


numerate : List a -> List ( Int, a )
numerate xs =
    zip (range 0 (length xs - 1)) xs
