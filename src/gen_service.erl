-module(gen_service).

-export([start/0]).
-export([stop/0]).

-export([call/3]).

%% ===================================================================
%% Public
%% ===================================================================

start() ->
    application:start(?MODULE).

stop() ->
    application:stop(?MODULE).

call(_, _, _) ->
    ok.
