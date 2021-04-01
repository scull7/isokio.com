module Routing exposing (..)

import Url.Parser exposing (Parser, map, oneOf, s, top)


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
