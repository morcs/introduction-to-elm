module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main =
    table [ class "table" ]
        [ renderRow "Elm" 10
        , renderRow "React" 9
        ]


renderRow : String -> Int -> Html msg
renderRow name score =
    tr []
        [ th [ scope "row" ] [ text name ]
        , td [] [ text (toString score) ]
        ]
