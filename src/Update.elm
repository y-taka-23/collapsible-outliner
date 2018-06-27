module Update exposing (update)

import List exposing (reverse)
import List.Extra exposing (updateAt, getAt, removeAt)
import Model exposing (Model, Item(..), ItemPath, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Toggle path ->
            ( toggleAt (reverse path) model, Cmd.none )

        Indent path ->
            ( indentAt (reverse path) model, Cmd.none )


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


addChild : Item -> Item -> Item
addChild child (Item item) =
    Item { item | children = child :: item.children }
