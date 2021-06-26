module Nav exposing (view)

{-
  ## Top Level Navigation for the website.
-}

import Html exposing
  ( Html
  , a
  , li
  , nav
  , text
  , ul
  )

import Html.Attributes exposing
  ( href
  )


-- MODEL


type alias NavLink =
  { location : String
  , display : String
  }


navLinks : List NavLink
navLinks =
  [ { location = "/", display = "Home" }
  , { location = "/font-explorer", display = "Font Explorer" }
  ]


-- VIEW


view : Html msg
view =
  nav []
    [ ul [] ( List.map viewLink navLinks )
    ]


viewLink : NavLink -> Html msg
viewLink link =
  li []
    [ a [ href link.location ] [ text link.display ]
    ]
