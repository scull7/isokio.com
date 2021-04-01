module Font exposing (..)

import Html exposing
  ( Html
  , div
  , h2
  , text
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


update _ model = model


-- VIEW


view : Model -> Html msg
view model =
  div []
    [ h2 [] [ text "Font Explorer" ]
    ]
