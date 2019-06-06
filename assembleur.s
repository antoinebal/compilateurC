afc r0 0
store 6 r0
load r0 6
store 0 r0
afc r0 1
store 6 r0
load r0 6
store 1 r0
load r0 0
store 6 r0
afc r0 0
store 7 r0
load r0 7
load r1 6
equ r0 r0 r1
afc r1 0
equ r0 r0 r1
store 6 r0
load r1 6
jmpc 25 r1
afc r0 4
store 6 r0
load r0 6
store 5 r0
jmp 29
afc r0 5
store 6 r0
load r0 6
store 5 r0
load r0 0
store 6 r0
afc r0 4
store 7 r0
load r1 7
load r0 6
inf r0 r0 r1
store 6 r0
load r1 6
jmpc 84 r1
load r0 0
store 6 r0
afc r0 1
store 7 r0
load r0 7
load r1 6
add r0 r0 r1
store 6 r0
load r0 6
store 0 r0
load r0 1
store 6 r0
afc r0 2
store 7 r0
load r0 7
load r1 6
mul r0 r0 r1
store 6 r0
load r0 6
store 1 r0
load r0 0
store 6 r0
afc r0 3
store 7 r0
load r0 7
load r1 6
equ r0 r0 r1
store 6 r0
load r1 6
jmpc 83 r1
afc r0 6
store 6 r0
load r0 6
store 4 r0
load r0 4
store 6 r0
afc r0 3
store 7 r0
load r0 7
load r1 6
div r0 r0 r1
store 6 r0
load r0 6
store 3 r0
jmp 29
