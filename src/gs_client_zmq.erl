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
    case zerpc:call(Pool, Mod, Fun, Args) of
        {error, {server, _, _, Reason, _}} ->
            {error, Reason};
        Other ->
            Other
    end.

cast({Mod, Fun, Args}, Pool) ->
    zerpc:cast(Pool, Mod, Fun, Args).

%% ===================================================================
%% Private
%% ===================================================================
