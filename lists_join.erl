-module(lists_join).
-export([join/2]).

join([Head | Tail], Sep) ->
    join_list_sep(Tail, Sep, [Head]);
join([], _Sep) ->
    [].

join_list_sep([Head | Tail], Sep, Acc) ->
    join_list_sep(Tail, Sep, [Head, Sep | Acc]);
join_list_sep([], _Sep, Acc) ->
  lists:reverse(Acc).
