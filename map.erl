-module(map).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

empty_map_test() ->
  false = true.

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

emptyMap(W, H) -> drawData([], W, H).

prepareRender([X], W, H) ->
  EmptyMap = emptyMap(W, H),
  Y = 5,
  ExistingLine = lists:sublist(EmptyMap, Y),
  LineWithX = lists:sublist(ExistingLine, X - 1) ++ ["*"] ++ lists:nthtail(X, ExistingLine),
  MapWithX = lists:sublist(EmptyMap, Y - 1) ++ LineWithX ++ lists:nthtail(Y, EmptyMap),
  LineBreakMap = lists_join:join(MapWithX, ["\r\n"]),
  FlattenedMap = lists:flatten(LineBreakMap),
  drawData(FlattenedMap, W, H).

handle_call({input, Ch, W, H}, _, State) ->
  State2 = processInput(State, Ch),
  {reply, prepareRender(State2, W, H), State2};
handle_call({tick, W, H}, _, State) ->
  State2 = processTick(State),
  {reply, prepareRender(State2, W, H), State2}.

init([]) ->
  {ok, [1]}.

go() ->
  gen_server:start_link(?MODULE, [], []).