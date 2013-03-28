-module(gen_service_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    gen_service_conf:start(services()),
    gen_service_sup:start_link().

stop(_State) ->
    ok.

%% ===================================================================
%% private
%% ===================================================================

services() ->
    case application:get_env(gen_service, services) of
        undefined ->
            [];
        {ok, Services} ->
            Services
    end.
