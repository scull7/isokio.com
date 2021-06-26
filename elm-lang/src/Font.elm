module Font exposing (..)

import Html exposing
  ( Html
  , div
  , form
  , h2
  , label
  , p
  , section
  , text
  )
import Html.Attributes exposing
  ( for
  )

-- MODEL

type alias Model =
  { counter : Int
  }



init : Model
init =
  { counter = 0
  }


-- UPDATE


type Msg
  = Init


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Init ->
      ( model, Cmd.none )


-- VIEW


view : (Msg -> msg) -> Model -> Html msg
view toMsg model =
  div []
    [ h2 [] [ text "Font Explorer" ]
    , section []
      [ viewForm model
      ]
    ]


viewForm : Model -> Html msg
viewForm model =
  form []
    [ viewTextEntry "text_one" "Text One"
    , viewTextEntry "text_two" "Text Two"
    , viewTextEntry "text_three" "Text Three"
    ]


viewTextEntry : String -> String -> Html msg
viewTextEntry id labelText =
  p []
    [ label [ for id ] [ text labelText ]
    ]
