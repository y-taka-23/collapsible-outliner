module Update exposing (update)

import List.Extra exposing (updateAt)
import Model exposing (Model, Item(..), ItemPath, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Toggle path ->
            case path of
                [] ->
                    ( model, Cmd.none )

                n :: ns ->
                    ( toggleNth n ns model, Cmd.none )


toggleNth : Int -> ItemPath -> List Item -> List Item
toggleNth n path items =
    updateAt n (toggle path) items


toggle : ItemPath -> Item -> Item
toggle path (Item item) =
    case path of
        [] ->
            Item { item | expanded = not item.expanded }

        n :: ns ->
            Item { item | children = toggleNth n ns item.children }
