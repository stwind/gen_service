-module(gs_client_eh).

-export([call/2]).
-export([cast/2]).
-export([init/1]).

-define(TIMEOUT, 30000).

%% ===================================================================
%% Public
%% ===================================================================

init(Config) ->
    Service = y:kf(service, Config),
    Timeout = y:kf(timeout, Config, ?TIMEOUT),
    {Service, Timeout}.

call({Mod, Fun, Args}, {Service, Timeout}) ->
    ehrpc:call(Service, Mod, Fun, Args, Timeout).

cast({Mod, Fun, Args}, {Service, Timeout}) ->
    ehrpc:cast(Service, Mod, Fun, Args, Timeout).

%% ===================================================================
%% Private
%% ===================================================================
