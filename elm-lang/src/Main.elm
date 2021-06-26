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
  let
      page = route url
  in
  ( Model key page, Cmd.none )


-- UPDATE


type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url
  | FontMsg Font.Msg


route : Url.Url -> Page
route url =
  case Routing.route url of
    Routing.Home ->
      Home

    Routing.NotFound ->
      NotFound

    Routing.FontExplorer ->
      FontExplorer Font.init



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case ( msg, model.page ) of
    ( LinkClicked urlRequest, _ ) ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    ( UrlChanged url, _ ) ->
      ( { model | page = route url }, Cmd.none )

    ( FontMsg subMsg, FontExplorer subModel ) ->
      Font.update subMsg subModel |> updateWith FontExplorer FontMsg model

    (_, _ ) ->
      -- Disregard messages that arrived for the wrong page.
      ( model, Cmd.none )


updateWith : (a -> Page) -> (b -> Msg) -> Model -> (a, Cmd b) -> ( Model, Cmd Msg )
updateWith toPage toMsg model (subModel, subCmd) =
  ( { model | page = toPage subModel }
  , Cmd.map toMsg subCmd
  )



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
      , viewPage model
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


viewPage : Model -> Html Msg
viewPage model =
  case model.page of
    Home ->
      div [] [ text "Welcome Home" ]

    NotFound ->
      div [] [ text "This is not the page you are looking for" ]

    FontExplorer m ->
      Font.view FontMsg m


{-| A non-breaking space. elm-html doesn't support escape sequences
like `text "&nbsp"`, so use this string instead.
-}
nbsp : String
nbsp =
      " "
