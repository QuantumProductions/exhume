-module(thing).
-compile(export_all).

process(<<27>>) ->
  io:fwrite("Ch: ~w", [<<27>>]),
  exit(self(), kill);
process(Ch) ->
  io:fwrite("Ch: ~w", [Ch]),
  get_char().

get_char() ->
    Ch = io:get_chars("p: ", 1),
    process(Ch).

start() ->
    io:setopts([{binary, true}]),
    get_char().
