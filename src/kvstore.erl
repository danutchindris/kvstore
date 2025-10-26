-module(kvstore).

-export([init/0, add/3, update/3, remove/2, get/2, keys/1, get_count/1]).

-export([test_kvstore/0]).

init() ->
    M = #{},
    C = atomics:new(1, []),
    {ok, {M, C}}.

add(K, V, {M, C}) ->
    atomics:add(C, 1, 1),
    {M#{K => V}, C}.

update(K, V, {M, C}) ->
    atomics:add(C, 1, 1),
    {M#{K := V}, C}.

remove(K, {M, C}) ->
    atomics:add(C, 1, 1),
    {maps:remove(K, M), C}.

get(K, {M, C}) ->
    atomics:add(C, 1, 1),
    maps:get(K, M).

keys({M, C}) ->
    atomics:add(C, 1, 1),
    lists:sort(maps:keys(M)).

get_count({_, C}) ->
    atomics:get(C, 1).

test_kvstore() ->
    {ok, Initial_State} = init(),
    {#{passion_fruit := 100}, _} = State0 = add(passion_fruit, 100, Initial_State),
    {#{passion_fruit := 100, apple := 5}, _} = State1 = add(apple, 5, State0),
    {#{passion_fruit := 100, apple := 5, orange := 10}, _} = State2 = add(orange, 10, State1),
    [apple, orange, passion_fruit] = keys(State2),
    {#{passion_fruit := 100, orange := 10}, _} = State3 = remove(apple, State2),
    10 = get(orange, State3),
    {#{passion_fruit := 150, orange := 10}, _} = State4 = update(passion_fruit, 150, State3),
    7 = get_count(State4),
    passed.
