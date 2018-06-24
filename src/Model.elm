module Model exposing (Model, Msg(..), Item(..), ItemPath, init)


type alias Model =
    List Item


type Item
    = Item
        { path : ItemPath
        , contents : String
        , expanded : Bool
        , children : List Item
        }


type alias ItemPath =
    List Int


sampleModel : Model
sampleModel =
    [ Item
        { path = [ 0 ]
        , contents = "1. Good morning"
        , expanded = True
        , children = []
        }
    , Item
        { path = [ 1 ]
        , contents = "2. Good afternoon"
        , expanded = True
        , children =
            [ Item
                { path = [ 1, 0 ]
                , contents = "2-1. Hey"
                , expanded = True
                , children = []
                }
            , Item
                { path = [ 1, 1 ]
                , contents = "2-2. Wow"
                , expanded = True
                , children = []
                }
            , Item
                { path = [ 1, 2 ]
                , contents = "2-3. Yeah"
                , expanded = True
                , children = []
                }
            ]
        }
    , Item
        { path = [ 2 ]
        , contents = "3. Good evening"
        , expanded = True
        , children = []
        }
    ]


type Msg
    = Toggle ItemPath


init : ( Model, Cmd Msg )
init =
    ( sampleModel, Cmd.none )
