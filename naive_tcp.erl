-module(naive_tcp).
-compile(export_all).
 
go() ->
  Text = "hello",
  {ok, Socket} = gen_tcp:connect({127,0,0,1}, 8094, []),
  send(Socket, Text, true).
 
format() ->
  format(26).
format(0) -> io:format("\r\n");
format(N) -> 
  io:format(integer_to_list(N)),
  io:format("        |                |                                                      "),
  format(N - 1).

send(Socket, Msg, Repeat) ->
  if Repeat =:= true ->
    inet:setopts(Socket, []),
    gen_tcp:send(Socket, Msg);
    true -> ""
  end,
  

  receive
    {tcp, Socket, <<"quit", _/binary>>} ->
      gen_tcp:close(Socket);
    {tcp, _, Res} ->      
      gen_tcp:close(Socket),
      io:format(Res ++ "\r\n")
  after 10000 ->
    if Repeat =:= true ->
      send(Socket, Msg, false)
    end
  end,
  if Repeat =:= true ->
    send(Socket, Msg, false);
    true -> ""
  end,
  c:flush().
