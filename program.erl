-module(program).
-export([main/1]).

main(Args) ->
    format(Args).

format(Args) ->
  format(Args, 26).
format(_Args, 0) -> io:format("\r\n");
format(Args, N) -> 
  io:format(integer_to_list(N)),
  io:format("        |                |                                                      "),
  format(Args, N - 1).


