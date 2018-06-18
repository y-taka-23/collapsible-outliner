module Model exposing (Model, Msg(..), init)


type alias Model =
    String


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    ( "Hello, Elm!", Cmd.none )
