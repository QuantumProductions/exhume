-module(thing).
-compile(export_all).

eraseLine() -> 
  Cols = os:cmd("tput cols"),
  eraseLine(Columns).
eraseLine(0) -> ok;
eraseLine(Columns) -> 
  io:fwrite(" "),
  eraseLine(Columns - 1).

eraseScreen() ->
  {ok, Rows} = io:rows(), 
  eraseScreen(Rows).
eraseScreen(0) -> ok;
eraseScreen(Rows) ->
  eraseLine(),
  eraseScreen(Rows - 1).

process(<<27>>) t->
  io:fwrite("Ch: ~w", [<<27>>]),
  exit(self(), kill);
process(Ch) ->
  eraseScreen(),
  io:fwrite("Ch: ~w", [Ch]),
  get_char().

get_char() ->
    Ch = io:get_chars("p: ", 1),
    process(Ch).

start() ->
    io:setopts([{binary, true}]),
    get_char().
