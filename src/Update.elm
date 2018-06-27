module Update exposing (update)

import List exposing (reverse)
import List.Extra exposing (updateAt)
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
