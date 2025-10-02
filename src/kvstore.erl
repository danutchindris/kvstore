-module(kvstore).

-export([init/0, add/3, update/3, remove/2, get/2, keys/1]).

init() ->
    #{}.

add(K, V, #{} = S) ->
    S#{K => V}.

update(K, V, S) ->
    S#{K := V}.

remove(K, S) ->
    maps:remove(K, S).

get(K, S) ->
    maps:get(K, S).

keys(S) ->
    lists:sort(maps:keys(S)).
