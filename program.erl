-module(program).
-export([main/1]).

printFirst(Arg) when is_atom(Arg) ->
  io:format("Atom\n");
printFirst(Arg) when is_number(Arg) ->
  io:format("Number\n");
printFirst(_) ->
  io:format("Who knows!?").

main([H | Args]) ->
    io:format("Args: ~p\n", [Args]),
    printFirst(H).