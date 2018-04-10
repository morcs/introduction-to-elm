module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http exposing (..)
import Json.Decode
import Json.Decode.Pipeline


main =
    Html.program { init = init, update = update, view = view, subscriptions = always Sub.none }



-- MODEL


type Model
    = Loading
    | CardList (List Card) (Maybe Card)
    | Error String


type alias Card =
    { imgUrl : String, name : String, nonchalance : Int, aggression : Int, glamour : Int, speed : Int }


init =
    ( Loading, sendApiRequest )



-- UPDATE


type Msg
    = Select Card
    | Loaded (Result Http.Error (List Card))
    | GetNewCards


update msg model =
    case msg of
        Select card ->
            case model of
                CardList cards _ ->
                    ( CardList cards (Just card), Cmd.none )

                _ ->
                    ( model, Cmd.none )

        Loaded (Result.Ok cards) ->
            ( CardList cards Nothing, Cmd.none )

        Loaded (Result.Err err) ->
            case err of
                BadStatus { body } ->
                    ( Error body, Cmd.none )

                _ ->
                    ( Error "Unknown error", Cmd.none )
        
        GetNewCards ->
            (model, sendApiRequest)



-- VIEW


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
                    , p [] 
                        [ button [ onClick GetNewCards ] [ text "Get new cards" ] ]
                    ]
                ]

        Error msg ->
            div [ class "alert alert-danger" ]
                [ text ("Error: " ++ msg) ]


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


renderCard card =
    div [ class "col-sm-6" ]
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


renderStat label value =
    tr []
        [ td [] [ text label ]
        , th [ class "text-right" ] [ text (toString value) ]
        ]



-- HTTP


sendApiRequest =
    Http.get "https://l9axnk5c93.execute-api.us-east-1.amazonaws.com/dev" decodeResponse
        |> Http.send Loaded


decodeResponse =
    Json.Decode.list decodeCard


decodeCard : Json.Decode.Decoder Card
decodeCard =
    Json.Decode.Pipeline.decode Card
        |> Json.Decode.Pipeline.required "imgUrl" Json.Decode.string
        |> Json.Decode.Pipeline.required "name" Json.Decode.string
        |> Json.Decode.Pipeline.required "nonchalance" Json.Decode.int
        |> Json.Decode.Pipeline.required "aggression" Json.Decode.int
        |> Json.Decode.Pipeline.required "glamour" Json.Decode.int
        |> Json.Decode.Pipeline.required "speed" Json.Decode.int
