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


init : ( Model, Cmd Msg )
init =
    ( sampleModel, Cmd.none )
