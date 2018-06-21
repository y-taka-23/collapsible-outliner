module Model exposing (Model, Msg(..), Item(..), ItemPath, init)


type alias Model =
    List Item


type Item
    = Item
        { contents : String
        , expanded : Bool
        , children : List Item
        }


type alias ItemPath =
    List Int


sampleModel : Model
sampleModel =
    [ Item
        { contents = "1. Good morning"
        , expanded = True
        , children = []
        }
    , Item
        { contents = "2. Good afternoon"
        , expanded = True
        , children =
            [ Item { contents = "2-1. Hey", expanded = True, children = [] }
            , Item { contents = "2-2. Wow", expanded = True, children = [] }
            , Item { contents = "2-3. Yeah", expanded = True, children = [] }
            ]
        }
    , Item
        { contents = "3. Good evening"
        , expanded = True
        , children = []
        }
    ]


type Msg
    = Toggle ItemPath


init : ( Model, Cmd Msg )
init =
    ( sampleModel, Cmd.none )
