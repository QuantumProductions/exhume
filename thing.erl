-module(thing).
-compile(export_all).

get_char() ->
    Ch = io:get_chars("p: ", 1),
    io:fwrite("Ch: ~w", [Ch]).

start() ->
    io:setopts([{binary, true}]),
    get_char().
