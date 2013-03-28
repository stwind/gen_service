-module(gen_service).

-export([call/3]).
-export([cast/3]).

-type service() :: atom().
-type method() :: atom().
-type args() :: [term()].

%% ===================================================================
%% Public
%% ===================================================================

-spec call(service(), method(), args()) -> {ok, term()} | {error, term()}.
call(Service, Fun, Args) ->
    do(call, Service, Fun, Args).

-spec cast(service(), method(), args()) -> ok.
cast(Service, Fun, Args) ->
    do(cast, Service, Fun, Args).

%% ===================================================================
%% Private
%% ===================================================================

do(Method, Service, Fun, Args) ->
    case gen_service_conf:get_handler(Service) of
        {ok, Handler, Config} ->
            Handler:Method({Service, Fun, Args}, Config);
        {error, not_found} ->
            {error, {unknown_service, Service}}
    end.
