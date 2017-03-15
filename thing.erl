-module(thing).
-compile(export_all).

eraseLine() -> 
  Cols = os:cmd("tput cols"),
  eraseLine(parseRowCol(Cols)).
eraseLine(0) -> ok;
eraseLine(Columns) -> 
  io:fwrite("X"),
  eraseLine(Columns - 1).

parseRowCol(L) -> parseRowCol(L, "").
parseRowCol([H | T], NumberParts) ->
  case T == "\n" of
    true -> list_to_integer(lists:append(NumberParts, [H]));
    false -> parseRowCol(T, lists:append(NumberParts, [H]))
  end.

eraseScreen() ->
  Rows = os:cmd("tput lines"),
  Val = parseRowCol(Rows),
  eraseScreen(Val).
eraseScreen(0) -> ok;
eraseScreen(Rows) ->
  eraseLine(),
  eraseScreen(Rows - 1).

process(<<27>>) ->
  io:fwrite("Ch: ~w", [<<27>>]),
  exit(self(), kill);
process(Ch) ->
  eraseScreen(),
  get_char().

get_char() ->
    Ch = io:get_chars("", 1),
    process(Ch).

start() ->
    io:setopts([{binary, true}]),
    get_char().
