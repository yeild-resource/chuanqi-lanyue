%%  coding: latin-1
%%------------------------------------------------------------
%%
%% Implementation stub file
%% 
%% Target: CosEventComm_PushSupplier
%% Source: /net/isildur/ldisk/daily_build/18_prebuild_master-opu_o.2015-06-23_20/otp_src_18/lib/cosEvent/src/CosEventComm.idl
%% IC vsn: 4.4
%% 
%% This file is automatically generated. DO NOT EDIT IT.
%%
%%------------------------------------------------------------

-module('CosEventComm_PushSupplier').
-ic_compiled("4_4").


%% Interface functions
-export([disconnect_push_supplier/1, disconnect_push_supplier/2]).

%% Type identification function
-export([typeID/0]).

%% Used to start server
-export([oe_create/0, oe_create_link/0, oe_create/1]).
-export([oe_create_link/1, oe_create/2, oe_create_link/2]).

%% TypeCode Functions and inheritance
-export([oe_tc/1, oe_is_a/1, oe_get_interface/0]).

%% gen server export stuff
-behaviour(gen_server).
-export([init/1, terminate/2, handle_call/3]).
-export([handle_cast/2, handle_info/2, code_change/3]).

-include_lib("orber/include/corba.hrl").


%%------------------------------------------------------------
%%
%% Object interface functions.
%%
%%------------------------------------------------------------



%%%% Operation: disconnect_push_supplier
%% 
%%   Returns: RetVal
%%
disconnect_push_supplier(OE_THIS) ->
    corba:call(OE_THIS, disconnect_push_supplier, [], ?MODULE).

disconnect_push_supplier(OE_THIS, OE_Options) ->
    corba:call(OE_THIS, disconnect_push_supplier, [], ?MODULE, OE_Options).

%%------------------------------------------------------------
%%
%% Inherited Interfaces
%%
%%------------------------------------------------------------
oe_is_a("IDL:omg.org/CosEventComm/PushSupplier:1.0") -> true;
oe_is_a(_) -> false.

%%------------------------------------------------------------
%%
%% Interface TypeCode
%%
%%------------------------------------------------------------
oe_tc(disconnect_push_supplier) -> 
	{tk_void,[],[]};
oe_tc(_) -> undefined.

oe_get_interface() -> 
	[{"disconnect_push_supplier", oe_tc(disconnect_push_supplier)}].




%%------------------------------------------------------------
%%
%% Object server implementation.
%%
%%------------------------------------------------------------


%%------------------------------------------------------------
%%
%% Function for fetching the interface type ID.
%%
%%------------------------------------------------------------

typeID() ->
    "IDL:omg.org/CosEventComm/PushSupplier:1.0".


%%------------------------------------------------------------
%%
%% Object creation functions.
%%
%%------------------------------------------------------------

oe_create() ->
    corba:create(?MODULE, "IDL:omg.org/CosEventComm/PushSupplier:1.0").

oe_create_link() ->
    corba:create_link(?MODULE, "IDL:omg.org/CosEventComm/PushSupplier:1.0").

oe_create(Env) ->
    corba:create(?MODULE, "IDL:omg.org/CosEventComm/PushSupplier:1.0", Env).

oe_create_link(Env) ->
    corba:create_link(?MODULE, "IDL:omg.org/CosEventComm/PushSupplier:1.0", Env).

oe_create(Env, RegName) ->
    corba:create(?MODULE, "IDL:omg.org/CosEventComm/PushSupplier:1.0", Env, RegName).

oe_create_link(Env, RegName) ->
    corba:create_link(?MODULE, "IDL:omg.org/CosEventComm/PushSupplier:1.0", Env, RegName).

%%------------------------------------------------------------
%%
%% Init & terminate functions.
%%
%%------------------------------------------------------------

init(Env) ->
%% Call to implementation init
    corba:handle_init('CosEventComm_PushSupplier_impl', Env).

terminate(Reason, State) ->
    corba:handle_terminate('CosEventComm_PushSupplier_impl', Reason, State).


%%%% Operation: disconnect_push_supplier
%% 
%%   Returns: RetVal
%%
handle_call({_, OE_Context, disconnect_push_supplier, []}, _, OE_State) ->
  corba:handle_call('CosEventComm_PushSupplier_impl', disconnect_push_supplier, [], OE_State, OE_Context, false, false);



%%%% Standard gen_server call handle
%%
handle_call(stop, _, State) ->
    {stop, normal, ok, State};

handle_call(_, _, State) ->
    {reply, catch corba:raise(#'BAD_OPERATION'{minor=1163001857, completion_status='COMPLETED_NO'}), State}.


%%%% Standard gen_server cast handle
%%
handle_cast(stop, State) ->
    {stop, normal, State};

handle_cast(_, State) ->
    {noreply, State}.


%%%% Standard gen_server handles
%%
handle_info(_, State) ->
    {noreply, State}.


code_change(OldVsn, State, Extra) ->
    corba:handle_code_change('CosEventComm_PushSupplier_impl', OldVsn, State, Extra).

