-module(map).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

empty_map_test() ->
  [["   "], ["   "], ["   "]] = emptyMap(3, 3).

prepareRender_test() ->
  A = lists:flatten([["        "], 
    ["        "], 
    ["        "], 
    ["        "], 
    [" *      "], 
    ["        "], 
    ["        "], 
    ["        "]]),
  A = prepareRender([2], 8, 8, 5).

processInput([X], _) when X < 80 ->
  [X + 1];
processInput([_], _) ->
  [0].

processTick(State) -> processInput(State, none).

paddedLine(H, 0) -> H;
paddedLine(H, HPadding) ->
  paddedLine(H ++ " ", HPadding - 1).

drawData(Data, W, H) -> drawData(Data, W, H, [""]).
drawData([], _, 0, Output) -> Output;
drawData([], W, H, Output) ->
 drawData([], W, H - 1, Output ++ [[paddedLine("", W)]]);
drawData([H | T], W, Hi, Output) ->
  HPadding = W - length(H),
  PaddedLine = paddedLine(H, HPadding),
  drawData(T, W, Hi - 1, Output ++ [[PaddedLine]]).

emptyMap(W, H) -> drawData([], W, H, []).

prepareRender([X], W, H, Y) ->
  EmptyMap = emptyMap(W, H),
  [ExistingLine | []] = lists:nth(Y, EmptyMap),
  Part1 = lists:sublist(ExistingLine, X - 1),
  Part2 = lists:append(Part1, "*"),
  Part3 = lists:append(Part2, lists:nthtail(X, ExistingLine)),
  MapWithX = lists:sublist(EmptyMap, Y - 1) ++ [[Part3]] ++ lists:nthtail(Y, EmptyMap),
  lists:flatten(MapWithX).
  % FlattenedMap = lists:flatten(LineBreakMap),
  % drawData(FlattenedMap, W, H).

handle_call({input, Ch, W, H}, _, State) ->
  Y = 5,
  State2 = processInput(State, Ch),
  {reply, prepareRender(State2, W, H, Y), State2};
handle_call({tick, W, H}, _, State) ->
  State2 = processTick(State),
  Y = 5,
  {reply, prepareRender(State2, W, H, Y), State2}.

init([]) ->
  {ok, [1]}.

go() ->
  gen_server:start_link(?MODULE, [], []).