#include<stdio.h>
#include<stdlib.h>

int main(void){
  system ("clear");
  int c;
  /* use system call to make terminal send all keystrokes directly to stdin */
  system ("/bin/stty raw");
  while((c=getchar())!= '.') {
    char command[100];
    char output[100];
    sprintf(output, system("stty size"));
    sprintf(command, "erl -noshell -s program main %s -s init stop", output);
    printf("\r\n");

    /* type a period to break out of the loop, since CTRL-D won't work raw */
  }
  /* use system call to set terminal behaviour to more normal behaviour */
  system ("/bin/stty cooked");
  system ("clear");
  system ("echo ok\n");
  retur