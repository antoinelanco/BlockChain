open Type
open Printf


let transaction_to_string data = Printf.sprintf "%d%d%d%d%s" data.id_t data.sender
    data.recever data.amount (status_to_string data.status)

let print_transaction data =
  Printf.sprintf
    "
  {
    id_transaction: %d
    sender: %d
    recever: %d
    amount: %d
    status: %s
  }" data.id_t data.sender data.recever data.amount (status_to_string data.status)
