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
  (Loading, Http.send Loaded (Http.get "https://l9axnk5c93.execute-api.us-east-1.amazonaws.com/dev" decodeResponse))


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
            (model, Cmd.none)
        Loaded (Result.Ok cards) ->
            (Ok cards Nothing, Cmd.none)
        Loaded (Result.Err err) ->
            (Error (toString err), Cmd.none)



--main = view (Ok gifUrls)
--main = view (Error "Could not load images")
--main = view Loading


renderStat label value =
    tr []
        [ td [] [ text label ]
        , th [ class "text-right" ] [ text (toString value) ]
        ]


renderCard card =
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
                , button [ onClick (Select card) ] [ text "Select" ]
                ]
            ]
        ]


renderSelectedCard selected =
    div [ class "jumbotron" ]
        (case selected of
            Nothing ->
                []

            Just card ->
                [ renderCard card ]
        )


view model =
    div [ class "container" ]
        [ case model of
            Loading ->
                div []
                    [ text "Loading..."
                    , img [ src "https://morcs.com/introduction-to-elm/loading.gif" ] []
                    ]

            Ok cards selected ->
                div []
                    [ renderSelectedCard selected
                    , div
                        [ class "row" ]
                        (List.map renderCard cards)
                    ]

            Error msg ->
                div [] [ text ("Error: " ++ msg) ]
        ]

decodeCard : Json.Decode.Decoder Card
decodeCard =
    Json.Decode.Pipeline.decode Card
        |> Json.Decode.Pipeline.required "imgUrl" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "name" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "nonchalance" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "aggression" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "glamour" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "speed" (Json.Decode.int)
