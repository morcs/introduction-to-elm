module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


model =
    [ "https://media.giphy.com/media/qoxM1gi6i0V9e/giphy.gif"
    , "https://media.giphy.com/media/CEdVDTtkvSelO/giphy.gif"
    , "https://media.giphy.com/media/TKfywHrPHpJiE/giphy.gif"
    , "https://media.giphy.com/media/cqG5aFdTkk5ig/giphy.gif"
    , "https://media.giphy.com/media/QsTKxTfou4SSk/giphy.gif"
    , "https://media.giphy.com/media/BkhOTDvASCfwk/giphy.gif"
    , "https://media.giphy.com/media/mjvwvf7Udt8rK/giphy.gif"
    , "https://media.giphy.com/media/1UnVU7zrZr3cQ/giphy.gif"
    , "https://media.giphy.com/media/I04JymgGbnlgk/giphy.gif"
    , "https://media.giphy.com/media/VM1JL42ALn0UU/giphy.gif"
    , "https://media.giphy.com/media/RlBtYmW0BGUHS/giphy.gif"
    , "https://media.giphy.com/media/bMnnmNo087fgs/giphy.gif"
    ]


renderCat url =
    div [ class "cat" ]
        [ a []
            [ img [ src url ] []
            ]
        ]


main : Html msg
main =
    div []
        (List.map renderCat model)
