function shuffle(array) {
    var m = array.length, t, i;
  
    // While there remain elements to shuffle…
    while (m) {
  
      // Pick a remaining element…
      i = Math.floor(Math.random() * m--);
  
      // And swap it with the current element.
      t = array[m];
      array[m] = array[i];
      array[i] = t;
    }
  
    return array;
}

exports.handler = (event, context, callback) => {
    
    const repository = 
        [ { imgUrl: "https://media.giphy.com/media/qoxM1gi6i0V9e/giphy.gif", name: "David", nonchalance: 8, aggression: 4, glamour: 8, speed: 10 }
        , { imgUrl: "https://media.giphy.com/media/CEdVDTtkvSelO/giphy.gif", name: "Mike", nonchalance: 10, aggression: 2, glamour: 9, speed: 7 }
        , { imgUrl: "https://media.giphy.com/media/TKfywHrPHpJiE/giphy.gif", name: "Helen", nonchalance: 7, aggression: 10, glamour: 6, speed: 4 }
        , { imgUrl: "https://media.giphy.com/media/cqG5aFdTkk5ig/giphy.gif", name: "Malcolm", nonchalance: 8, aggression: 4, glamour: 6, speed: 4 }
        , { imgUrl: "https://media.giphy.com/media/QsTKxTfou4SSk/giphy.gif", name: "The Joneses", nonchalance: 8, aggression: 6, glamour: 4, speed: 5 }
        , { imgUrl: "https://media.giphy.com/media/BkhOTDvASCfwk/giphy.gif", name: "David & Bill", nonchalance: 9, aggression: 1, glamour: 7, speed: 3 }
        , { imgUrl: "https://media.giphy.com/media/mjvwvf7Udt8rK/giphy.gif", name: "Charlotte", nonchalance: 5, aggression: 9, glamour: 4, speed: 8 }
        , { imgUrl: "https://media.giphy.com/media/1UnVU7zrZr3cQ/giphy.gif", name: "Michael", nonchalance: 8, aggression: 7, glamour: 8, speed: 5 }
        , { imgUrl: "https://media.giphy.com/media/I04JymgGbnlgk/giphy.gif", name: "Susan & Diane", nonchalance: 4, aggression: 5, glamour: 6, speed: 5 }
        , { imgUrl: "https://media.giphy.com/media/VM1JL42ALn0UU/giphy.gif", name: "Grace", nonchalance: 6, aggression: 2, glamour: 10, speed: 6 }
        , { imgUrl: "https://media.giphy.com/media/RlBtYmW0BGUHS/giphy.gif", name: "Geoff", nonchalance: 7, aggression: 2, glamour: 9, speed: 5 }
        , { imgUrl: "https://media.giphy.com/media/bMnnmNo087fgs/giphy.gif", name: "Brian", nonchalance: 10, aggression: 1, glamour: 3, speed: 5 }
        ];

    const shuffled = shuffle(repository);
    const result = shuffled.slice(0, 6);

    const shouldReturnError = Math.random() < 0.1;

    const headers = {
        "Access-Control-Allow-Origin" : "*" // Required for CORS support to work
    }; 

    const response = 
        shouldReturnError 
          ? { "statusCode": 500
            , "headers": headers
            , "body": "This test service returns an error 10% of the time to allow testing of the error page, reload to try again!"
            }
          : { "statusCode": 200
            , "headers": headers
            , "body": JSON.stringify(result)
            };
          ;

    callback(null, response);
};