(* convertit le fichier assembleur en une liste d'instructions
   dont chaque élément est de la forme String list *)
let from_file path =
  let infile = open_in path in
  (* Read all lines until end of file. *)
  let rec loop instructions =
    try
      let line = input_line infile in
      let instructions2 =
        (* Ignore empty lines *)
        if line = "" then instructions

        (* The first character of a line determines its content : v or e.
         * Lines not starting with v or e are ignored. *)
        else 
          let instruction = String.split_on_char ' ' line in
            instructions@[instruction]
      in                 
        loop instructions2        
    with End_of_file -> instructions
  in

  let final_instructions = loop [] in

    close_in infile ;
    final_instructions;;


exception Mauvais_registre
(* retourne le numéro de registre d'un registre *)
let numRegistre registre =
  match registre with
  |"r0" -> 0
  |"r1" -> 1
  |"r2" -> 2
  |"r3" -> 3
  |"r4" -> 4
  |"r5" -> 5
  |"r6" -> 6
  |"r7" -> 7
  |"r8" -> 8
  |"r9" -> 9
  |"r10" -> 10
  |"r11" -> 11
  |"r12" -> 12
  |"r13" -> 13
  |"r14" -> 14
  |"r15" -> 15
  |"r15" -> 16
  | _ -> raise Mauvais_registre
;;


let interpreteur nomFichier =
  let instructions = from_file nom_fichier in

  (* pc : instruction pointer (int)
     registres : int array
     memoire : int array 
     retourne un tuple (registres ; memoire)
  *)
  let rec interp pc registres memoire =
    (* on examine l'instructions pointée par pc 
    attention à ne faire que quand pc encore dans instructions sinon stop*)
    let instruction = (List.nth instructions pc
    match List.hd instruction with
    |"add" ->
      let numRa = numRegistre List.nth instruction 1 in
      let numRb = numRegistre List.nth instruction 2 in
      let numRc = numRegistre List.nth instruction 3 in
      (* ICI : mettre dans les bonnes cases du tableau *)
    |"mul" ->
    |"sou" ->
    |"div" ->
    |"cop" ->
    |"afc" ->
    |"load" ->
    |"store" ->
    |"equ" ->
    |"inf" ->
    |"infe" ->
    |"sup" ->
    |"supe" ->
    |"jmp" ->
    |"jmpc" ->
    | _ -> 

  in

  (* on initialise les registres et la mémoire *)
  let reg = Array.make 16 0 in
  let mem = Array.make 256 0 in

  interp 0 reg mem;;











let instructions = from_file "assembleur.s";;

let printInstr instr = 
  match instr with
    |[] -> Printf.printf "empty \n"
    |[x] -> Printf.printf "%s \n" x
    |[x ; y] -> Printf.printf "%s %s \n" x y
    |[x ; y ; z] -> Printf.printf "%s %s %s \n" x y z
    |[x ; y ; z ; a] -> Printf.printf "%s %s %s %s \n" x y z a
    | _ -> Printf.printf "wut \n"
;;


List.iter printInstr instructions;
