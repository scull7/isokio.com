module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing
  ( Html
  , a
  , div
  , h1
  , header
  , text
  )
import Html.Attributes exposing
  ( alt
  , class
  , href
  , id
  )
import Html.Events exposing (onClick)
import Url

import Font
import Nav
import Routing


-- MAIN


main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }


-- MODEL


type alias Model =
  { key : Nav.Key
  , page : Page
  }


type Page
  = Home
  | FontExplorer(Font.Model)
  | NotFound


init : () -> Url.Url -> Nav.Key -> (Model, Cmd Msg )
init flags url key =
  ( Model key Home, Cmd.none )


-- UPDATE


type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    UrlChanged url ->
      ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


-- VIEW


view : Model -> Browser.Document Msg
view model =
  { title = "ISOKIO"
  , body =
      [ viewHeader model
      ]
  }


viewHeader : Model -> Html msg
viewHeader model =
  header []
    [ viewBrand
    , Nav.view
    ]


viewBrand : Html msg
viewBrand =
  h1 []
    [ a [ href "#" ]
      [ text "ISOKIO.com"
      ]
    ]


{-| A non-breaking space. elm-html doesn't support escape sequences
like `text "&nbsp"`, so use this string instead.
-}
nbsp : String
nbsp =
      " "
