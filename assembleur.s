afc r0 10
store 1 r0
load r0 1
store 0 r0
load r0 0
store 1 r0
afc r0 9
store 2 r0
load r0 2
load r1 1
equ r0 r0 r1
store 1 r0
load r1 1
jmpc 33 r1
load r0 0
store 1 r0
afc r0 3
store 2 r0
load r0 2
load r1 1
equ r0 r0 r1
store 1 r0
load r1 1
jmpc 29 r1
afc r0 50
store 1 r0
load r0 1
store 0 r0
jmp 33
afc r0 31
store 1 r0
load r0 1
store 0 r0
