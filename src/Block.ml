open Digestif


let createBlock id time previous nonce data =

  let hash = 10 in
  {
    id = id;
    timestamp = time;
    previousHash = previous;
    hash = hash;
    data = data;
    nonce = nonce
  }
