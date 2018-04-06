module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (..)
import Html.Events exposing (..)


main =
    Html.beginnerProgram { model = Loading, update = update, view = view }


type Model
    = Loading
    | Ok (List String)
    | Error String


gifUrls =
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


type Msg
    = TestLoading
    | TestSuccess
    | TestError String


update msg model =
    case msg of
        TestLoading ->
            Loading

        TestSuccess ->
            Ok gifUrls

        TestError msg ->
            Error msg



renderCat url =
    div [ class "cat" ]
        [ a []
            [ img [ src url ] []
            ]
        ]


view model =
    div [ class "container" ]
        [ div [ class "btn-group", role "group", ariaLabel "Test transitions" ]
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
                div []
                    (List.map renderCat images)

            Error msg ->
                div [] [ text ("Error: " ++ msg) ]
        ]
