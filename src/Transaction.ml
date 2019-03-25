open Type
open Printf


let transaction_to_string data = Printf.sprintf "%d%d%d%s" data.sender
    data.receiver data.amount (status_to_string data.status)

let print_transaction data =
  Printf.sprintf
    "
  {
    sender: %d
    receiver: %d
    amount: %d
    status: %s
  }" data.sender data.receiver data.amount (status_to_string data.status)
