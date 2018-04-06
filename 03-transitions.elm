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



--main = view (Ok gifUrls)
--main = view (Error "Could not load images")
--main = view Loading


renderCat url =
    div [ class "col-sm-6" ]
        [ div [ class "card my-2" ]
            [ div [ class "card-header" ]
                [ text "Brian" ]
            , div [ class "my-0 font-weight-normal" ]
                [ img [ class "img-fluid", src url ] [] 
                , table [ class "table mb-0" ]
                     [ tr []
                          [ th [] [ text "Nonchalance" ]
                          , td [ class "text-right" ] [ text "7" ]
                          ]
                     , tr []
                          [ th [] [ text "Aggression" ]
                          , td [ class "text-right" ] [ text "7" ]
                          ]                     
                     , tr []
                          [ th [] [ text "Glamour" ]
                          , td [ class "text-right" ] [ text "7" ]
                          ]                     
                     , tr []
                          [ th [] [ text "Speed" ]
                          , td [ class "text-right" ] [ text "7" ]
                          ]                     
                     ]
                ]
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
                div [ class "row" ]
                    (List.map renderCat images)

            Error msg ->
                div [] [ text ("Error: " ++ msg) ]
        ]
