let createBlock id time previous nonce data =

  let hash = 10;
  {
    id = id;
    timestamp = time;
    previousHash = previous;
    hash = hash;
    data=data;
    nonce = nonce
  }
