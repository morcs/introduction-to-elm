module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline as DecodePipeline


main : Html msg
main =
    view model



-- MODEL


type alias Model =
    List Card


type alias Card =
    { imgUrl : String
    , name : String
    , nonchalance : Int
    , aggression : Int
    , glamour : Int
    , speed : Int
    }


model : Model
model =
    [ { imgUrl = "https://media.giphy.com/media/qoxM1gi6i0V9e/giphy.gif", name = "Dave", nonchalance = 9, aggression = 4, glamour = 6, speed = 9 }
    , { imgUrl = "https://media.giphy.com/media/CEdVDTtkvSelO/giphy.gif", name = "Dave", nonchalance = 9, aggression = 4, glamour = 6, speed = 9 }
    , { imgUrl = "https://media.giphy.com/media/TKfywHrPHpJiE/giphy.gif", name = "Dave", nonchalance = 9, aggression = 4, glamour = 6, speed = 9 }
    , { imgUrl = "https://media.giphy.com/media/cqG5aFdTkk5ig/giphy.gif", name = "Dave", nonchalance = 9, aggression = 4, glamour = 6, speed = 9 }
    , { imgUrl = "https://media.giphy.com/media/QsTKxTfou4SSk/giphy.gif", name = "Dave", nonchalance = 9, aggression = 4, glamour = 6, speed = 9 }
    , { imgUrl = "https://media.giphy.com/media/BkhOTDvASCfwk/giphy.gif", name = "Dave", nonchalance = 9, aggression = 4, glamour = 6, speed = 9 }
    , { imgUrl = "https://media.giphy.com/media/mjvwvf7Udt8rK/giphy.gif", name = "Dave", nonchalance = 9, aggression = 4, glamour = 6, speed = 9 }
    , { imgUrl = "https://media.giphy.com/media/1UnVU7zrZr3cQ/giphy.gif", name = "Dave", nonchalance = 9, aggression = 4, glamour = 6, speed = 9 }
    , { imgUrl = "https://media.giphy.com/media/I04JymgGbnlgk/giphy.gif", name = "Dave", nonchalance = 9, aggression = 4, glamour = 6, speed = 9 }
    , { imgUrl = "https://media.giphy.com/media/VM1JL42ALn0UU/giphy.gif", name = "Dave", nonchalance = 9, aggression = 4, glamour = 6, speed = 9 }
    , { imgUrl = "https://media.giphy.com/media/RlBtYmW0BGUHS/giphy.gif", name = "Dave", nonchalance = 9, aggression = 4, glamour = 6, speed = 9 }
    , { imgUrl = "https://media.giphy.com/media/bMnnmNo087fgs/giphy.gif", name = "Dave", nonchalance = 9, aggression = 4, glamour = 6, speed = 9 }
    ]



-- VIEW


view : Model -> Html msg
view model =
    div []
        [ renderTopBar
        , main_ [ attribute "role" "main", class "container my-5 py-2" ]
            [ div
                [ class "row" ]
                (List.map renderCard model)
            ]
        ]


renderTopBar : Html msg
renderTopBar =
    div [ class "fixed-top bg-success text-white p-3" ]
        [ text "Please select a card" ]


renderCard : Card -> Html msg
renderCard card =
    div [ class "col-sm-6 col-md-4" ]
        [ div [ class "card my-2" ]
            [ div [ class "card-header" ]
                [ text card.name ]
            , div [ class "my-0 font-weight-normal" ]
                [ img [ class "img-fluid", src card.imgUrl ] []
                , table [ class "table mb-0" ]
                    [ renderStat "Nonchalance" card.nonchalance
                    , renderStat "Aggression" card.aggression
                    , renderStat "Glamour" card.glamour
                    , renderStat "Speed" card.speed
                    ]
                ]
            ]
        ]


renderStat : String -> Int -> Html msg
renderStat label value =
    tr []
        [ td [] [ text label ]
        , th [ class "text-right" ] [ text (toString value) ]
        ]
