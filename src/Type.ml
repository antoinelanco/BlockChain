type s = Valide | Fail | Pending

type transaction =
  {
    id_t: int;
    sender: int;
    recever: int;
    amount: int;
    status: s
  }

type block =
  {
    id_b: int;
    timestamp: int;
    previousHash: string;
    hash: string;
    nonce: int;
    data: transaction
  }

let status_to_string = function
  | Valide -> "Valide"
  | Fail -> "Fail"
  | Pending -> "Pending"
