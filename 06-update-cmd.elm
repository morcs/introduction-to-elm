module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline as DecodePipeline


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }



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


init : ( Model, Cmd Msg )
init =
    ( Loading
    , sendApiRequest
    )



-- UPDATE


type Msg
    = Select (List Card) Card
    | Loaded (Result Http.Error (List Card))
    | GetNewCards


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Select cards card ->
            ( CardList cards (Just card)
            , Cmd.none
            )

        Loaded (Result.Ok cards) ->
            ( CardList cards Nothing
            , Cmd.none
            )

        Loaded (Result.Err (BadStatus { body })) ->
            ( Error body
            , Cmd.none
            )

        Loaded (Result.Err _) ->
            ( Error "Unknown error"
            , Cmd.none
            )

        GetNewCards ->
            ( model
            , sendApiRequest
            )



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
                        (List.map (renderCard cards) cards)
                    , p []
                        [ button [ onClick GetNewCards ] [ text "Get new cards" ] ]
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


renderCard : List Card -> Card -> Html Msg
renderCard cards card =
    div [ class "col-sm-6 col-md-4" ]
        [ div [ class "card my-2 clickable", onClick (Select cards card) ]
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


renderStat : String -> Int -> Html Msg
renderStat label value =
    tr []
        [ td [] [ text label ]
        , th [ class "text-right" ] [ text (toString value) ]
        ]



-- HTTP


sendApiRequest : Cmd Msg
sendApiRequest =
    Http.get "https://l9axnk5c93.execute-api.us-east-1.amazonaws.com/dev" decodeResponse
        |> Http.send Loaded


decodeResponse : Decode.Decoder (List Card)
decodeResponse =
    Decode.list decodeCard


decodeCard : Decode.Decoder Card
decodeCard =
    DecodePipeline.decode Card
        |> DecodePipeline.required "imgUrl" Decode.string
        |> DecodePipeline.required "name" Decode.string
        |> DecodePipeline.required "nonchalance" Decode.int
        |> DecodePipeline.required "aggression" Decode.int
        |> DecodePipeline.required "glamour" Decode.int
        |> DecodePipeline.required "speed" Decode.int
