-module(gs_client_zmq).

-export([call/2]).
-export([cast/2]).
-export([parse_conf/1]).

-define(TIMEOUT, 30000).

%% ===================================================================
%% Public
%% ===================================================================

parse_conf(Config) ->
    Pool = y:kf(pool, Config),
    Timeout = y:kf(timeout, Config, ?TIMEOUT),
    {Pool, Timeout}.

call({Mod, Fun, Args}, {Pool, Timeout}) ->
    zerpc:call(Pool, Mod, Fun, Args, Timeout).

cast({Mod, Fun, Args}, {Pool, Timeout}) ->
    zerpc:cast(Pool, Mod, Fun, Args, Timeout).

%% ===================================================================
%% Private
%% ===================================================================
