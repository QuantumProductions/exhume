#include<stdio.h>
#include<stdlib.h>

int main(void){
  system ("clear");
  int c;
  int *out;
  system ("/bin/stty raw");
  FILE *fp;
  // while((c=getchar())!= 27) {
    char path[1035];
    fp = popen("stty size", "r");

    while (fgets(path, sizeof(path)-1, fp) != NULL) {
      printf("%s", path);
      char command[100];
      sprintf(command, "erl -noshell -run controls go %s -s init stop", path);
      system(command);
    }
    system("clear");
    printf("\r\n");
  // }
  system ("/bin/stty cooked");
  system ("clear");
  system ("echo ok\n");

  // return out;
  return 0;
}
