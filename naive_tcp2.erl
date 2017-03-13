-module(naive_tcp2).
-compile(export_all).
 
go() ->
  go(8094).
go(Port) ->
  Pid = spawn_link(fun() ->
  {ok, Listen} = gen_tcp:listen(Port, [binary, {active, false}]),
  spawn(fun() -> acceptor(Listen) end),
    timer:sleep(infinity)
  end),
  {ok, Pid}.
 
acceptor(ListenSocket) ->
  {ok, Socket} = gen_tcp:accept(ListenSocket),
  spawn(fun() -> acceptor(ListenSocket) end),
  handle(Socket).
 
format(Socket) ->
  format(26, Socket).
format(0, Socket) -> gen_tcp:send(Socket, "\r\n");
format(N, Socket) -> 
  gen_tcp:send(Socket, integer_to_list(N)),
  gen_tcp:send(Socket, "        |                |                                                      "),
  format(N - 1, Socket).

handle(Socket) ->
  inet:setopts(Socket, [{active, once}]),
  receive
    {tcp, Socket, <<"quit", _/binary>>} ->
      gen_tcp:close(Socket);
    {tcp, Socket, Bin} ->
      % gen_tcp:send(Socket, Bin)
      % Msg = binary:bin_to_list(Bin),
      format(Socket)
  end,
  handle(Socket).
