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


exception Mauvais_registre of string
exception Instruction_inconnue
	    
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
  |"r16" -> 16
  | r -> raise (Mauvais_registre r)
;;


let interpreteur nomFichier =
  let instructions = from_file nomFichier in

  (* pc : instruction pointer (int)
     registres : int array
     memoire : int array 
     retourne un tuple (registres , memoire)
   *)
  let rec interp pc registres memoire =
    (* on examine l'instructions pointée par pc 
    attention à ne faire que quand pc encore dans instructions sinon stop*)
    if pc >= (List.length instructions)
    then (registres , memoire)
    else 
      let instruction = (List.nth instructions pc) in
      match List.hd instruction with
      |"add" ->
	(* add Ra Rb Rc *)
	let numRa = numRegistre (List.nth instruction 1) in
	let numRb = numRegistre (List.nth instruction 2) in
	let numRc = numRegistre (List.nth instruction 3) in
	registres.(numRa) <- (registres.(numRb) + registres.(numRc));
	interp (pc+1) registres memoire
      (* ICI : mettre dans les bonnes cases du tableau *)
      |"mul" ->
	(* mul Ra Rb Rc *)
	let numRa = numRegistre (List.nth instruction 1) in
	let numRb = numRegistre (List.nth instruction 2) in
	let numRc = numRegistre (List.nth instruction 3) in
	registres.(numRa) <- (registres.(numRb) * registres.(numRc));
	interp (pc+1) registres memoire
      |"sou" ->
	(* sou Ra Rb Rc *)
	let numRa = numRegistre (List.nth instruction 1) in
	let numRb = numRegistre (List.nth instruction 2) in
	let numRc = numRegistre (List.nth instruction 3) in
	registres.(numRa) <- (registres.(numRb) - registres.(numRc));
	interp (pc+1) registres memoire
      |"div" ->
	(* div Ra Rb Rc *)
	let numRa = numRegistre (List.nth instruction 1) in
	let numRb = numRegistre (List.nth instruction 2) in
	let numRc = numRegistre (List.nth instruction 3) in
	registres.(numRa) <- (registres.(numRb) / registres.(numRc));
	interp (pc+1) registres memoire
      (* cop Ra Rb *)
      |"cop" ->
	let numRa = numRegistre (List.nth instruction 1) in
	let numRb = numRegistre (List.nth instruction 2) in
	registres.(numRa) <- registres.(numRb);
	interp (pc+1) registres memoire
      (* afc Ra j *)
      |"afc" ->
	let numRa = numRegistre (List.nth instruction 1) in
	let j = int_of_string (List.nth instruction 2) in
	registres.(numRa) <- j;
	interp (pc+1) registres memoire
      (* load Ra @j *)
      |"load" ->
	let numRa = numRegistre (List.nth instruction 1) in
	let adrJ = int_of_string (List.nth instruction 2) in
	registres.(numRa) <- memoire.(adrJ);
	interp (pc+1) registres memoire
      (* store @i Rb *)
      |"store" ->
	let adrI = int_of_string (List.nth instruction 1) in
	let numRb = numRegistre (List.nth instruction 2) in
	memoire.(adrI) <- registres.(numRb);
	interp (pc+1) registres memoire
      (* equ Ra Rb Rc *)
      |"equ" ->
	let numRa = numRegistre (List.nth instruction 1) in
	let numRb = numRegistre (List.nth instruction 2) in
	let numRc = numRegistre (List.nth instruction 3) in
	let cond = registres.(numRb) = registres.(numRc) in
	(match cond with
	 |true ->
	   registres.(numRa) <- 1;
	   interp (pc+1) registres memoire
	 |false ->
	   registres.(numRa) <- 0;
	   interp (pc+1) registres memoire)
      (* inf Ra Rb Rc *)
      |"inf" ->
	let numRa = numRegistre (List.nth instruction 1) in
	let numRb = numRegistre (List.nth instruction 2) in
	let numRc = numRegistre (List.nth instruction 3) in
	let cond = registres.(numRb) < registres.(numRc) in
	(match cond with
	 |true ->
	   registres.(numRa) <- 1;
	   interp (pc+1) registres memoire
	 |false ->
	   registres.(numRa) <- 0;
	   interp (pc+1) registres memoire)
      (* infe Ra Rb Rc *)
      |"infe" ->
	let numRa = numRegistre (List.nth instruction 1) in
	let numRb = numRegistre (List.nth instruction 2) in
	let numRc = numRegistre (List.nth instruction 3) in
	let cond = registres.(numRb) <= registres.(numRc) in
	(match cond with
	 |true ->
	   registres.(numRa) <- 1;
	   interp (pc+1) registres memoire
	 |false ->
	   registres.(numRa) <- 0;
	   interp (pc+1) registres memoire)
      (* sup Ra Rb Rc *)
      |"sup" ->
	let numRa = numRegistre (List.nth instruction 1) in
	let numRb = numRegistre (List.nth instruction 2) in
	let numRc = numRegistre (List.nth instruction 3) in
	let cond = registres.(numRb) > registres.(numRc) in
	(match cond with
	 |true ->
	   registres.(numRa) <- 1;
	   interp (pc+1) registres memoire
	 |false ->
	   registres.(numRa) <- 0;
	   interp (pc+1) registres memoire)
      (* supe Ra Rb Rc *)
      |"supe" ->
	let numRa = numRegistre (List.nth instruction 1) in
	let numRb = numRegistre (List.nth instruction 2) in
	let numRc = numRegistre (List.nth instruction 3) in
	let cond = registres.(numRb) >= registres.(numRc) in
	(match cond with
	 |true ->
	   registres.(numRa) <- 1;
	   interp (pc+1) registres memoire
	 |false ->
	   registres.(numRa) <- 0;
	   interp (pc+1) registres memoire)
      (* jmp @i *)
      |"jmp" ->
	let adrI = int_of_string (List.nth instruction 1) in
	(* on met pc à adrI *)
	interp adrI registres memoire
      (* jmpc @i Rb *)
      |"jmpc" ->
	let adrI = int_of_string (List.nth instruction 1) in
	let numRb = numRegistre (List.nth instruction 2) in
	if registres.(numRb) = 0
	then interp adrI registres memoire (* on saute *)
	else interp (pc+1) registres memoire (* on ne saute pas *)
      | _ -> raise Instruction_inconnue
		   
  in
  
  (* on initialise les registres et la mémoire *)
  let reg = Array.make 16 0 in
  let mem = Array.make 256 0 in
  
  interp 0 reg mem;;
  



let instructions = from_file "assembleur.s";;


  

let printInstructions instructions =
  let printInstruction instruction no = 
    match instruction with
    |[] -> Printf.printf "\n"
    |[x] -> Printf.printf "@%d :  %s \n" no x
    |[x ; y] -> Printf.printf "@%d :  %s %s \n" no x y
    |[x ; y ; z] -> Printf.printf "@%d :  %s %s %s \n" no x y z
    |[x ; y ; z ; a] -> Printf.printf "@%d :  %s %s %s %s \n" no x y z a
    | _ -> raise Instruction_inconnue
  in

  let rec piIn insts no = 
    match insts with
    |[] -> Printf.printf "\n"
    |instruction::reste -> printInstruction instruction no;
			   piIn reste (no+1)
  in
  Printf.printf "****INSTRUCTIONS****\n";
  piIn instructions 0
;;

  
  
  
let printRegistres registres =
  let taille = Array.length registres in
  let rec prIn i =
    let cond = i >= taille in
    match cond with
    |true ->
      Printf.printf "\n"
    |false ->
      Printf.printf "r%d = %d\n" i registres.(i);
      prIn (i+1)
  in
  Printf.printf "*****REGISTRES*****\n";
  prIn 0;;
  
let printMemoire memoire =
  let taille = Array.length memoire in
  let rec pmIn i =
    let cond = i >= taille in
    match cond with
    |true ->
      Printf.printf "\n"
    |false ->
      Printf.printf "@%d : %d\n" i memoire.(i);
      pmIn (i+1)
  in
  (Printf.printf "******MEMOIRE******\n");
  pmIn 0;; 
  
  
  
  
  printInstructions (from_file "assembleur.s");
  match interpreteur "assembleur.s" with
  |(registres , memoire) ->
    printRegistres registres;
    printMemoire memoire;
    
