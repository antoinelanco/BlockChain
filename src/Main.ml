open Printer
open Type
open Block

let a = Valide
let t = {id_t = 10; sender = 10; recever = 20; amount = 10; status = a}
let b = createBlock 1 10. "0" t 4  
let () = print_block b
let () = print_string "\n"
