-module(program).
-export([main/1, test/0]).

paddedLine(H, 0) -> H ++ "\r\n";
paddedLine(H, HPadding) ->
  % io:fwrite("Padding line ~p / ~p", [H, HPadding]),
  paddedLine(H ++ " ", HPadding - 1).

drawData(Data, W, H) -> drawData(Data, W, H, "").
drawData([], _, 0, Output) -> io:fwrite(Output);
drawData([], W, H, Output) ->
 drawData([], W, H - 1, Output ++ paddedLine("", W));
drawData([H | T], W, Hi, Output) ->
  HPadding = W - length(H),
  % io:fwrite("Extra needed ~p", [HPadding]),
  io:fwrite("Extra needed ~p", [H]),
  % io:fwrite("Extra needed ~p", [W]),
  io:fwrite("Height: ~p", [Hi]),
  PaddedLine = paddedLine(H, HPadding),
  drawData(T, W, Hi - 1, Output ++ PaddedLine).

render(W, H) ->
  SampleData = ["_____________-------------_________","           XXX         "],
  drawData(SampleData, W, H).
  
updateState(_) -> ok.
% return state for calling render

process(<<27>>, _, _) ->
  io:fwrite("Ch: ~w", [<<27>>]),
  exit(self(), kill);
process(Ch, W, H) ->
  updateState(Ch),
  render(W, H),
  get_char(W, H).

get_char(W, H) ->
  Ch = io:get_chars("Hoodlum ", 1),
  process(Ch, W, H).

main([H | [T]]) ->
  Width = list_to_integer(T),
  Height = list_to_integer(H),
  io:setopts([{binary, true}]),
  get_char(Width, Height).

test() ->
  main(["25", "90"]).