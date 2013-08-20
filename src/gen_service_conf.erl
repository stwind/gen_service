-module(gen_service_conf).

-export([start/1]).
-export([get_handler/1]).
-export([add_service/2]).

-define(SERVICES, services).
-define(DEFAULT_FORMAT, json).

%% ===================================================================
%% Public
%% ===================================================================

start(Services) ->
    ets:new(?SERVICES, [public, named_table, {read_concurrency, true}]),
    [add_service(Name, [{format, format()} | Config]) || {Name, Config} <- Services].

get_handler(Name) ->
    case ets:lookup(?SERVICES, Name) of
        [{Name, Handler, Config}] ->
            {ok, Handler, Config};
        [] ->
            {error, not_found}
    end.

add_service(Name, Config) ->
    Handler = handler(proplists:get_value(type, Config)),
    Config1 = Handler:init(Config),
    ets:insert(?SERVICES, {Name, Handler, Config1}).

%% ===================================================================
%% Private
%% ===================================================================

handler(Type) ->
    list_to_atom("gs_client_" ++ atom_to_list(Type)).

format() ->
    case application:get_env(gen_service, format) of
        {ok, Format} ->
            Format;
        undefined ->
            ?DEFAULT_FORMAT
    end.
