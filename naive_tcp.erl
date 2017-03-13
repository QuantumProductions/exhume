-module(naive_tcp).
-compile(export_all).
 
go() ->
  Text = "hello",
  {ok, Socket} = gen_tcp:connect({127,0,0,1}, 8094, []),
  send(Socket, Text).
 
format() ->
  format(26).
format(0) -> io:format("\r\n");
format(N) -> 
  io:format(integer_to_list(N)),
  io:format("        |                |                                                      "),
  format(N - 1).


send(Socket, Msg) ->
  inet:setopts(Socket, [{active, once}]),
  gen_tcp:send(Socket, Msg),
  receive
    {tcp, Socket, <<"quit", _/binary>>} ->
      gen_tcp:close(Socket);
    {tcp, _, Res} ->      
      gen_tcp:close(Socket),
      io:format(Res ++ "\r\n")
  end.
