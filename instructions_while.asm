afc r0 0
store 402 r0
load r0 402
store 400 r0
afc r0 10
store 402 r0
load r0 402
store 401 r0
load r0 400
store 402 r0
afc r0 10
store 403 r0
load r0 403
load r1 402
inf r0 r0 r1
store 402 r0
load r1 402
jmpc 39 r1 -> on saut bien après le jmp 8
afc r0 2
store 402 r0
afc r0 2
store 403 r0
load r0 403
load r1 402
add r0 r0 r1
store 402 r0
load r0 402
store 400 r0
load r0 400
store 402 r0
afc r0 1
store 403 r0
load r0 403
load r1 402
add r0 r0 r1
store 402 r0
load r0 402
store 400 r0
jmp 8 -> on saute bien à la ligne load r0 400 marquant le début de while(b<10)




//
void main(){
  int b;
  int a;
  b = 0;
  a = 10;
  while(b<10){
    b=2+2;
    b=b+1;
  }
}


