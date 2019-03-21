type s = Valide | Fail | Pending

type transaction =
  {
    id: int;
    sender: int;
    recever: int;
    amount: int;
    status: s
  }

type block =
  {
    id : int;
    timestamp: int;
    previousHash: int;
    hash: int;
    nonce: int;
    data: transaction
  }
