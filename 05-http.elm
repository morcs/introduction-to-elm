module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http exposing (..)
import Json.Decode
import Json.Decode.Pipeline


main =
    Html.program { init = init, update = update, view = view, subscriptions = always Sub.none }


init =
    ( Loading, Http.send Loaded (Http.get "https://l9axnk5c93.execute-api.us-east-1.amazonaws.com/dev" decodeResponse) )


decodeResponse =
    Json.Decode.list decodeCard


type alias Card =
    { imgUrl : String, name : String, nonchalance : Int, aggression : Int, glamour : Int, speed : Int }


type Model
    = Loading
    | Ok (List Card) (Maybe Card)
    | Error String


type Msg
    = Select Card
    | Loaded (Result Http.Error (List Card))


update msg model =
    case msg of
        Select card ->
            case model of
                Ok cards _ ->
                    ( Ok cards (Just card), Cmd.none )

                _ ->
                    ( model, Cmd.none )

        Loaded (Result.Ok cards) ->
            ( Ok cards Nothing, Cmd.none )

        Loaded (Result.Err err) ->
            case err of
                BadStatus { body } ->
                    ( Error body, Cmd.none )

                _ ->
                    ( Error "Unknown error", Cmd.none )


renderStat label value =
    tr []
        [ td [] [ text label ]
        , th [ class "text-right" ] [ text (toString value) ]
        ]


renderCard card =
    div [ class "card my-2", onClick (Select card) ]
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


view model =
    case model of
        Loading ->
            div [ class "alert alert-success" ]
                [ text "Loading..." ]

        Ok cards selected ->
          div []
           [
            renderTopBar selected
           ,main_ [ attribute "role" "main", class "container my-5 py-2" ]
                  [ 
                   div
                     [ class "row" ]
                     (List.map (\c -> div [ class "col-sm-6 clickable" ] [ renderCard c ]) cards)
                  ]
           ]

        Error msg ->
            div [ class "alert alert-danger" ]
                [ text ("Error: " ++ msg) ]


decodeCard : Json.Decode.Decoder Card
decodeCard =
    Json.Decode.Pipeline.decode Card
        |> Json.Decode.Pipeline.required "imgUrl" Json.Decode.string
        |> Json.Decode.Pipeline.required "name" Json.Decode.string
        |> Json.Decode.Pipeline.required "nonchalance" Json.Decode.int
        |> Json.Decode.Pipeline.required "aggression" Json.Decode.int
        |> Json.Decode.Pipeline.required "glamour" Json.Decode.int
        |> Json.Decode.Pipeline.required "speed" Json.Decode.int
