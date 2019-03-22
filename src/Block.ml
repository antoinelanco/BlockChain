open Digestif
open Type
open Transaction
open Printf


let rec find_nonce id time previous data diff nonce =
  let s = Printf.sprintf "%d%d%s%d%s" id time previous nonce (transaction_to_string data) in
  let hash = Digestif.SHA512.digest_bytes (Bytes.of_string s) |> Digestif.SHA512.to_hex in

  let zero = String.make diff '0' in
  let sub = String.sub hash 0 diff in
  if String.equal sub zero
  then nonce
  else find_nonce id time previous data diff (nonce+1)



let createBlock id time previous data diff =

  let nonce = find_nonce id time previous data diff 0 in

  let s = Printf.sprintf "%d%d%s%d%s" id time previous nonce (transaction_to_string data) in
  let hash = Digestif.SHA512.digest_bytes (Bytes.of_string s) |> Digestif.SHA512.to_hex in


  {
    id_b = id;
    timestamp = time;
    previousHash = previous;
    hash = hash;
    data = data;
    nonce = nonce
  }


let print_block b =

  Printf.printf
"{
  id_block: %d
  timestamp: %d
  previousHash: %s
  hash: %s
  nonce: %d
  data: %s
}" b.id_b b.timestamp b.previousHash b.hash b.nonce (print_transaction b.data)
