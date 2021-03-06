module Update exposing (update)

import Keyboard.Event exposing (KeyboardEvent)
import Keyboard.Key exposing (Key(Tab))
import List exposing (reverse)
import List.Extra exposing (updateAt, getAt, removeAt, setAt)
import Model exposing (Model, Item(..), ItemPath, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Toggle path ->
            ( { model | items = toggleAt (reverse path) model.items }
            , Cmd.none
            )

        Mouse path ->
            ( { model | mouse = path }, Cmd.none )

        Keyboard path event ->
            ( handleKeyboard path event model, Cmd.none )


toggleAt : ItemPath -> List Item -> List Item
toggleAt revpath items =
    case revpath of
        [] ->
            items

        n :: [] ->
            updateAt n toggle items

        n :: ns ->
            updateAt n (toggleItem ns) items


toggle : Item -> Item
toggle (Item item) =
    Item { item | expanded = not item.expanded }


toggleItem : ItemPath -> Item -> Item
toggleItem revpath (Item item) =
    Item { item | children = toggleAt revpath item.children }


indentAt : ItemPath -> List Item -> List Item
indentAt revpath items =
    case revpath of
        [] ->
            items

        n :: [] ->
            indent n items

        n :: ns ->
            updateAt n (indentItem ns) items


indent : Int -> List Item -> List Item
indent n items =
    if n <= 0 then
        items
    else
        case getAt n items of
            Nothing ->
                items

            Just child ->
                items |> updateAt (n - 1) (addChild child) |> removeAt n


indentItem : ItemPath -> Item -> Item
indentItem revpath (Item item) =
    Item { item | children = indentAt revpath item.children }


unindentAt : ItemPath -> List Item -> List Item
unindentAt revpath items =
    case revpath of
        [] ->
            items

        n :: [] ->
            items

        n :: m :: [] ->
            unindent n m items

        n :: m :: ms ->
            updateAt n (unindentItem (m :: ms)) items


unindent : Int -> Int -> List Item -> List Item
unindent n m items =
    case getAt n items of
        Nothing ->
            items

        Just parent ->
            case removeChild m parent of
                ( Nothing, _ ) ->
                    items

                ( Just child, newParent ) ->
                    items |> insertAt (n + 1) child |> setAt n newParent


unindentItem : ItemPath -> Item -> Item
unindentItem revpath (Item item) =
    Item { item | children = unindentAt revpath item.children }


addChild : Item -> Item -> Item
addChild child (Item item) =
    Item { item | children = item.children ++ [ child ] }


removeChild : Int -> Item -> ( Maybe Item, Item )
removeChild n (Item item) =
    ( getAt n item.children
    , Item { item | children = removeAt n item.children }
    )


insertAt : Int -> a -> List a -> List a
insertAt n x xs =
    if n <= 0 then
        x :: xs
    else
        case xs of
            [] ->
                [ x ]

            y :: ys ->
                y :: insertAt (n - 1) x ys


handleKeyboard : ItemPath -> KeyboardEvent -> Model -> Model
handleKeyboard path event model =
    if event.keyCode == Tab && not event.repeat then
        if event.shiftKey then
            { model | items = unindentAt (reverse path) model.items }
        else
            { model | items = indentAt (reverse path) model.items }
    else
        model
