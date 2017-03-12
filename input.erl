-module(input).
-compile(export_all).

read() ->
  {ok, [X]} = io:fread("input : ", "~d"),
  io:format(os:cmd(clear)),
  printNumber(X),
  read().

printNumber(N) ->
  printNumber(N, 26).
printNumber(_, 0) -> io:format("\n");
printNumber(N, RA) -> 
  printColumn(N),
  printNumber(N, RA - 1).

printColumn(N) ->
 printColumn(N, 80).
printColumn(_, 0) -> io:format("\n"); 
printColumn(N, RA) ->
  io:format("~p", [N]),
  printColumn(N, RA - 1).
