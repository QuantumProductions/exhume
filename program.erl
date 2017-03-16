-module(program).
-export([main/1]).

printFirst(Arg) when is_atom(Arg) ->
  io:format("Atom\n");
printFirst(Arg) when is_number(Arg) ->
  io:format("Number\n");
printFirst(Arg) ->
  io:format("Argument: ~p", [Arg]),
  io:format("Who knows!?").

main([H | [T]]) ->
    % io:format("Args: ~p\n", [Args]),
    printFirst(H),
    printFirst(T),
    io:setopts([{binary, true}]),
    get_char().

process(<<27>>) ->
  io:fwrite("Ch: ~w", [<<27>>]),
  exit(self(), kill);
process(Ch) ->
  io:fwrite("Ch: ~w", [Ch]),
  get_char().

get_char() ->
    Ch = io:get_chars("p: ", 1),
    process(Ch).