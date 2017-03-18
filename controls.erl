-module(controls).
-compile(export_all).

process(<<27>>, _, _, _) ->
  io:fwrite("Ch: ~w", [<<27>>]),
  exit(self(), kill);
process(Ch, MapPid, W, H) ->
  Map = s:s(MapPid, {input, Ch, W, H}),
  io:fwrite(Map),
  get_char(MapPid, W, H).

get_char(MapPid, W, H) ->
  Ch = io:get_chars("", 1),
  process(Ch, MapPid, W, H).

handle_call(get_char, _, {MapPid, Width, Height}) ->
  get_char(MapPid, Width, Height);
handle_call(get_char, _, State) ->
  {noreply, State}.
  
update(MapPid, Width, Height) ->
  Map = s:s(MapPid, {tick, Width, Height}),
  io:fwrite(Map),
  timer:apply_after(1000, ?MODULE, update, [MapPid, Width, Height]).

init({Width, Height}) -> 
  io:setopts([{binary, true}]),
  {ok, MapPid}  = map:go(),
  {ok, _Tref} = timer:apply_after(1000, ?MODULE, update, [MapPid, Width, Height]),
  {ok, {MapPid, Width, Height}}.

go([H | [T]]) ->
  Width = list_to_integer(T),
  Height = list_to_integer(H),
  {ok, Pid} = gen_server:start_link(?MODULE, {Width, Height}, []),
  s:s(Pid, get_char).
  
