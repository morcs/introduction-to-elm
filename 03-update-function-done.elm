module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Html.beginnerProgram { model = Loading, update = update, view = view }


type Model
    = Loading
    | Ok (List { imgUrl : String, name : String, nonchalance : Int, aggression : Int, glamour : Int, speed : Int })
    | Error String


cards =
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


type Msg
    = TestLoading
    | TestSuccess
    | TestError String


update msg model =
    case msg of
        TestLoading ->
            Loading

        TestSuccess ->
            Ok cards

        TestError msg ->
            Error msg



--main = view (Ok gifUrls)
--main = view (Error "Could not load images")
--main = view Loading


renderStat label value =
    tr []
        [ td [] [ text label ]
        , th [ class "text-right" ] [ text (toString value) ]
        ]


renderCat card =
    div [ class "col-sm-6" ]
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


view model =
    div [ class "container" ]
        [ div [ class "btn-group" ]
            [ button [ class "btn btn-secondary", onClick TestLoading ] [ text "Loading" ]
            , button [ class "btn btn-secondary", onClick TestSuccess ] [ text "Success" ]
            , button [ class "btn btn-secondary", onClick (TestError "My error message") ] [ text "Error" ]
            ]
        , case model of
            Loading ->
                div []
                    [ text "Loading..."
                    , img [ src "https://morcs.com/introduction-to-elm/loading.gif" ] []
                    ]

            Ok images ->
                div [ class "row" ]
                    (List.map renderCat images)

            Error msg ->
                div [] [ text ("Error: " ++ msg) ]
        ]
