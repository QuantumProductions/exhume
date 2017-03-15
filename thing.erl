-module(thing).
-compile(export_all).

eraseLine() -> 
  io:fwrite("               ____________         ____ \x1B[K\r\n").
%   Cols = os:cmd("tput cols"),
%   Val = parseRowCol(Cols),
%   eraseLine(Val).
% eraseLine(0) -> io:fwrite("\x1B[K\r\n");
% eraseLine(Columns) -> 
%   io:fwrite(" "),
%   eraseLine(Columns - 1).

parseRowCol(L) -> parseRowCol(L, "").
parseRowCol([H | T], NumberParts) ->
  case T == "\n" of
    true -> list_to_integer(lists:append(NumberParts, [H]));
    false -> parseRowCol(T, lists:append(NumberParts, [H]))
  end.

drawEmpty(0) -> ok;
drawEmpty(N) -> 
  io:fwrite("    \x1B[K\r\n"),
  drawEmpty(N - 1).

eraseScreen() ->
  io:fwrite("Hello\x1B[K\r\n"),
  % io:fwrite("\033[2J"),
  % Rows = os:cmd("tput lines"),
  % Val = parseRowCol(Rows),
  eraseScreen(22).
eraseScreen(0) -> ok;
eraseScreen(1) ->
  io:fwrite("_____\x1B[K\r\n");
eraseScreen(Rows) ->
  eraseLine(),
  eraseScreen(Rows - 1).

process(<<27>>) ->
  io:fwrite("Ch: ~w", [<<27>>]),
  exit(self(), kill);
process(Ch) ->
  os:cmd("clear"),
  drawEmpty(40),
  eraseScreen(),
  get_char().

get_char() ->
    Ch = io:get_chars("", 1),
    process(Ch).

start() ->
    io:setopts([{binary, true}]),
    get_char().
