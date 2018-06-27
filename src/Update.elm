module Update exposing (update)

import List exposing (reverse)
import List.Extra exposing (updateAt, getAt, removeAt)
import Model exposing (Model, Item(..), ItemPath, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Toggle path ->
            case reverse path of
                [] ->
                    ( model, Cmd.none )

                n :: ns ->
                    ( toggleNth n ns model, Cmd.none )

        Indent path ->
            ( indentAt (reverse path) model, Cmd.none )


toggleNth : Int -> ItemPath -> List Item -> List Item
toggleNth n revpath items =
    updateAt n (toggle revpath) items


toggle : ItemPath -> Item -> Item
toggle revpath (Item item) =
    case revpath of
        [] ->
            Item { item | expanded = not item.expanded }

        n :: ns ->
            Item { item | children = toggleNth n ns item.children }


indentAt : ItemPath -> List Item -> List Item
indentAt revpath items =
    case revpath of
        [] ->
            items

        n :: [] ->
            if n <= 0 then
                items
            else
                case getAt n items of
                    Nothing ->
                        items

                    Just child ->
                        items |> updateAt (n - 1) (addChild child) |> removeAt n

        n :: ns ->
            updateAt n (indent ns) items


indent : ItemPath -> Item -> Item
indent revpath (Item item) =
    Item { item | children = indentAt revpath item.children }


addChild : Item -> Item -> Item
addChild child (Item item) =
    Item { item | children = child :: item.children }
