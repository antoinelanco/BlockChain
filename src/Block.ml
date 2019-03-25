open Digestif
open Type
open Transaction
open Printf
open Unix

let print_block b =

  Printf.printf
    "{
  id_block: %d
  timestamp: %f
  previousHash: %s
  hash: %s
  nonce: %d
  data: %s
}" b.id_b b.timestamp b.previousHash b.hash b.nonce (print_transaction b.data)






let hash_block b =
  let s = Printf.sprintf "%d%f%s%d%s" b.id_b b.timestamp b.previousHash b.nonce (transaction_to_string b.data) in
  Digestif.SHA512.digest_bytes (Bytes.of_string s) |> Digestif.SHA512.to_hex

let rec find_nonce id time previous data diff nonce =
  let s = Printf.sprintf "%d%f%s%d%s" id time previous nonce (transaction_to_string data) in
  let hash = Digestif.SHA512.digest_bytes (Bytes.of_string s) |> Digestif.SHA512.to_hex in

  let zero = String.make diff '0' in
  let sub = String.sub hash 0 diff in
  if String.equal sub zero
  then nonce
  else find_nonce id time previous data diff (nonce+1)



let createBlock id previous data diff =

  let time = Unix.time () in
  let nonce = find_nonce id time previous data diff 0 in

  let s = Printf.sprintf "%d%f%s%d%s" id time previous nonce (transaction_to_string data) in
  let hash = Digestif.SHA512.digest_bytes (Bytes.of_string s) |> Digestif.SHA512.to_hex in


  {
    id_b = id;
    timestamp = time;
    previousHash = previous;
    hash = hash;
    data = data;
    nonce = nonce
  }


let rec check_hash = function
  | [] -> false
  | [gen] -> gen.id_b == 0 && gen.previousHash = "0"
  | h::t -> if h.previousHash = (List.hd t).hash && hash_block h = h.hash
    then check_hash t
    else false



let rec check_right chain id v s =
  match chain with
  | [] -> false
  | h::t ->
    if h.data.receiver == id
    then
      if h.data.sender == id
      then check_right t id v s
      else let v1 = v + h.data.amount in if v1 >= s then true else check_right t id v1 s
    else
      if h.data.sender == id
      then let v1 = v - h.data.amount in if v1 >= s then true else check_right t id v1 s
      else check_right t id v s

let add_block chain s r a =

  assert(check_hash chain);
  assert(check_right chain s 0 a);

  let f = List.hd chain in
  let id = f.id_b + 1 in
  let prev = f.hash in
  let t = {sender = s; receiver = r; amount = a; status = Valide} in
  let b = createBlock id prev t 3 in

  let () = print_block b in
  b :: chain



let rec get_amount chain id v =
  match chain with
  | [] -> v
  | h::t ->
    if h.data.receiver == id
    then
      if h.data.sender == id
      then get_amount t id v
      else let v1 = v + h.data.amount in get_amount t id v1
    else
      if h.data.sender == id
      then let v1 = v - h.data.amount in get_amount t id v1
      else get_amount t id v
