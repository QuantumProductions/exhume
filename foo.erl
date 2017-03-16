-module(foo).
-compile(export_all).

drawData([H | T]) ->
  ok.
drawData([H | T], W, H, Output) ->
  ok.

main() ->
  drawData(["_____________-------------_________","           XXX         "],25, 90, "").