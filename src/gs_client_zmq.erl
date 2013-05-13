-module(gs_client_zmq).

-export([call/2]).
-export([cast/2]).
-export([parse_conf/1]).

-define(TIMEOUT, 5000).

%% ===================================================================
%% Public
%% ===================================================================

parse_conf(Config) ->
    y:kf(pool, Config).

call({Mod, Fun, Args}, Pool) ->
    zerpc:call(Pool, Mod, Fun, Args).

cast({Mod, Fun, Args}, Pool) ->
    zerpc:cast(Pool, Mod, Fun, Args).

%% ===================================================================
%% Private
%% ===================================================================
