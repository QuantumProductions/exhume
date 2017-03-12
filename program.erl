-module(program).
-export([main/1]).

main(Args) ->
    io:format("Args: ~p\n\n", [Args]).

