type s = Valide | Fail | Pending

type transaction =
  {
    sender: int;
    receiver: int;
    amount: int;
    status: s
  }

type block =
  {
    id_b: int;
    timestamp: float;
    previousHash: string;
    hash: string;
    nonce: int;
    data: transaction
  }

type blockChain = block list

let status_to_string = function
  | Valide -> "Valide"
  | Fail -> "Fail"
  | Pending -> "Pending"
