module Routing exposing (..)

import Url
import Url.Parser exposing (Parser, parse, map, oneOf, s, top)


-- MODEL


type Route
  = Home
  | FontExplorer
  | NotFound


routeParser : Parser (Route -> a) a
routeParser =
  oneOf
    [ map Home top
    , map FontExplorer (s "font-explorer")
    ]


route : Url.Url -> Route
route url =
  Maybe.withDefault NotFound (parse routeParser url)
