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
    [ { imgUrl = "https://media.giphy.com/media/QsTKxTfou4SSk/giphy.gif", name = "The Joneses", nonchalance = 8, aggression = 6, glamour = 4, speed = 5 }
    , { imgUrl = "https://media.giphy.com/media/mjvwvf7Udt8rK/giphy.gif", name = "Charlotte", nonchalance = 5, aggression = 9, glamour = 4, speed = 8 }
    , { imgUrl = "https://media.giphy.com/media/qoxM1gi6i0V9e/giphy.gif", name = "David", nonchalance = 8, aggression = 4, glamour = 8, speed = 10 }
    , { imgUrl = "https://media.giphy.com/media/CEdVDTtkvSelO/giphy.gif", name = "Mike", nonchalance = 10, aggression = 2, glamour = 9, speed = 7 }
    , { imgUrl = "https://media.giphy.com/media/TKfywHrPHpJiE/giphy.gif", name = "Helen", nonchalance = 7, aggression = 10, glamour = 6, speed = 4 }
    , { imgUrl = "https://media.giphy.com/media/BkhOTDvASCfwk/giphy.gif", name = "David & Bill", nonchalance = 9, aggression = 1, glamour = 7, speed = 3 }
    ]



-- VIEW


view : Model -> Html msg
view model =
    main_ [ attribute "role" "main", class "container my-5 py-2" ]
        [ div
            [ class "row" ]
            (List.map renderCard model)
        ]


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
        [ th [] [ text label ]
        , td [ class "text-right" ] [ text (toString value) ]
        ]
