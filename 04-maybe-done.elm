module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Html.beginnerProgram { model = model, update = update, view = view }



-- MODEL


type Model
    = Loading
    | CardList (List Card) (Maybe Card)
    | Error String


type alias Card =
    { imgUrl : String
    , name : String
    , nonchalance : Int
    , aggression : Int
    , glamour : Int
    , speed : Int
    }


testCards : List Card
testCards =
    [ { imgUrl = "https://media.giphy.com/media/QsTKxTfou4SSk/giphy.gif", name = "The Joneses", nonchalance = 8, aggression = 6, glamour = 4, speed = 5 }
    , { imgUrl = "https://media.giphy.com/media/mjvwvf7Udt8rK/giphy.gif", name = "Charlotte", nonchalance = 5, aggression = 9, glamour = 4, speed = 8 }
    , { imgUrl = "https://media.giphy.com/media/qoxM1gi6i0V9e/giphy.gif", name = "David", nonchalance = 8, aggression = 4, glamour = 8, speed = 10 }
    , { imgUrl = "https://media.giphy.com/media/CEdVDTtkvSelO/giphy.gif", name = "Mike", nonchalance = 10, aggression = 2, glamour = 9, speed = 7 }
    , { imgUrl = "https://media.giphy.com/media/TKfywHrPHpJiE/giphy.gif", name = "Helen", nonchalance = 7, aggression = 10, glamour = 6, speed = 4 }
    , { imgUrl = "https://media.giphy.com/media/BkhOTDvASCfwk/giphy.gif", name = "David & Bill", nonchalance = 9, aggression = 1, glamour = 7, speed = 3 }
    ]


model : Model
model =
    CardList testCards Nothing



-- UPDATE


type Msg
    = TestLoading
    | TestSuccess
    | TestError String
    | Select Card


update : Msg -> Model -> Model
update msg model =
    case msg of
        TestLoading ->
            Loading

        TestSuccess ->
            CardList testCards Nothing

        TestError msg ->
            Error msg

        Select card ->
            CardList testCards (Just card)



-- VIEW


view : Model -> Html Msg
view model =
    case model of
        Loading ->
            div [ class "alert alert-success" ]
                [ text "Loading..." ]

        CardList cards selected ->
            div []
                [ renderTopBar selected
                , main_ [ attribute "role" "main", class "container my-5 py-2" ]
                    [ div
                        [ class "row" ]
                        (List.map renderCard cards)
                    ]
                ]

        Error msg ->
            div [ class "alert alert-danger" ]
                [ text ("Error: " ++ msg) ]


renderTopBar : Maybe Card -> Html Msg
renderTopBar selected =
    case selected of
        Nothing ->
            div [ class "fixed-top bg-success text-white p-3" ]
                [ text "Please select a card" ]

        Just card ->
            div [ class "fixed-top bg-primary text-white p-3" ]
                [ text "Selected: "
                , strong [] [ text card.name ]
                ]


renderCard : Card -> Html Msg
renderCard card =
    div [ class "col-sm-6 col-md-4" ]
        [ div [ class "card my-2 clickable", onClick (Select card) ]
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
