-module(gs_client_erl).

-export([call/2]).
-export([cast/2]).
-export([parse_conf/1]).

-define(TIMEOUT, 5000).

%% ===================================================================
%% Public
%% ===================================================================

parse_conf(Config) ->
    Config.

call({Mod, Fun, Args}, Config) ->
    Node = conf(node, Config, node()),
    Timeout = conf(node, Config, ?TIMEOUT),
    Mod1 = maybe_delegate(Mod, Config),
    case rpc:call(Node, Mod1, Fun, Args, Timeout) of
        {badrpc, Reason} ->
            {error, Reason};
        Res ->
            {ok, Res}
    end.

cast({Mod, Fun, Args}, Config) ->
    Node = conf(node, Config, node()),
    true = rpc:cast(Node, Mod, Fun, Args),
    ok.

%% ===================================================================
%% Private
%% ===================================================================

conf(Key, Config, Default) ->
    case lists:keyfind(Key, 1, Config) of
        {Key, Val} ->
            Val;
        false ->
            Default
    end.

maybe_delegate(Mod, Config) ->
    conf(delegate, Config, Mod).
