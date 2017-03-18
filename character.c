#include<stdio.h>
#include<stdlib.h>

int main(void){
  system ("clear");
  int c;
  /* use system call to make terminal send all keystrokes directly to stdin */
  // system ("/bin/stty raw");
  int *out;
  while((c=getchar())!= '.') {
    char command[100];
    char output[100];
    popen(output, "stty size");
    printf("Hello");
    printf("%s", output);
    sprintf(command, "erl -noshell -s controls go \"%s\" -s init halt", output);
    system(command);
  }
  system ("/bin/stty cooked");
  system ("clear");
  system ("echo ok\n");

  // return out;
  return 0;
}
