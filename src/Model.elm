module Model exposing (Model, Msg(..), Item(..), ItemPath, init, defaultPath)


type alias Model =
    { items : List Item
    , focus : ItemPath
    , mouse : ItemPath
    }


type Item
    = Item
        { contents : String
        , expanded : Bool
        , children : List Item
        }


type alias ItemPath =
    List Int


defaultPath : ItemPath
defaultPath =
    []


sampleItems : List Item
sampleItems =
    [ Item
        { contents = "Good morning"
        , expanded = True
        , children = []
        }
    , Item
        { contents = "Good afternoon"
        , expanded = True
        , children =
            [ Item
                { contents = "Hey"
                , expanded = True
                , children = []
                }
            , Item
                { contents = "Wow"
                , expanded = True
                , children = []
                }
            , Item
                { contents = "Yeah"
                , expanded = True
                , children = []
                }
            ]
        }
    , Item
        { contents = "Good evening"
        , expanded = True
        , children = []
        }
    ]


type Msg
    = Toggle ItemPath
    | Indent ItemPath
    | Unindent ItemPath
    | Focus ItemPath
    | Mouse ItemPath
    | SetContents ItemPath String


init : ( Model, Cmd Msg )
init =
    ( { items = sampleItems, focus = defaultPath, mouse = defaultPath }
    , Cmd.none
    )
