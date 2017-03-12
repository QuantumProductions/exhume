#include<stdio.h>
#include<stdlib.h>

int main(void){
  int c;
  /* use system call to make terminal send all keystrokes directly to stdin */
  system ("/bin/stty raw");
  while((c=getchar())!= '.') {
    char command[100];
    sprintf(command, "erl -noshell -run program main %c -s erlang halt", c);
    system(command);
    printf("\n");

    /* type a period to break out of the loop, since CTRL-D won't work raw */
  }
  /* use system call to set terminal behaviour to more normal behaviour */
  system ("/bin/stty cooked");
  system ("clear");
  system ("echo ok\n");
  return 0;
}
