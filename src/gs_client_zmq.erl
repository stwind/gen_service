-module(gs_client_zmq).

-export([call/2]).
-export([cast/2]).
-export([parse_conf/1]).

-define(TIMEOUT, 5000).

%% ===================================================================
%% Public
%% ===================================================================

parse_conf(Config) ->
    Config.

call({Mod, Fun, Args}, _Config) ->
    zerpc:call(Mod, Fun, Args).

cast({Mod, Fun, Args}, _Config) ->
    zerpc:cast(Mod, Fun, Args).

%% ===================================================================
%% Private
%% ===================================================================
