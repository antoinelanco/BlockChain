open Printer
open Type
open Block


let t = {sender = 0; receiver = 1; amount = 1000; status = Valide}
let gen = createBlock 0 "0" t 3
let () = print_block gen
let () = print_string "\n"


let bc = [gen]

let bc = add_block bc 1 2 100
let bc = add_block bc 1 2 100
let bc = add_block bc 1 2 100
let bc = add_block bc 1 2 100
let () = Printf.printf "%d\n" (get_amount bc 1 0)
let () = Printf.printf "%d\n" (get_amount bc 2 0)
