%%---------------------------------------
%% @Module	: data_pay
%% @Created	: 
%% @Description	: nothing
%%---------------------------------------

-module(data_pay).
-export([get_items/0,get_item/1,get_item/2]).
-include("record.hrl").

%% notice: you need add the record below to record.hrl
%% -record(payCfg,{id,gamemoney,ucmoney,state}).

get_item(Key)->
	List=get_items(),
	lists:keyfind(Key,#payCfg.id,List).

get_item(Idx,Key)->
	List=get_items(),
	lists:keyfind(Key,Idx,List).

get_items()->
	[
	#payCfg{id=1,gamemoney=1,ucmoney=1,state=1},
	#payCfg{id=2,gamemoney=100,ucmoney=10,state=1},
	#payCfg{id=3,gamemoney=300,ucmoney=30,state=1},
	#payCfg{id=4,gamemoney=500,ucmoney=50,state=1},
	#payCfg{id=5,gamemoney=1000,ucmoney=100,state=1},
	#payCfg{id=6,gamemoney=5000,ucmoney=500,state=1},
	#payCfg{id=7,gamemoney=10000,ucmoney=1000,state=1},
	#payCfg{id=8,gamemoney=20000,ucmoney=2000,state=1},
	#payCfg{id=9,gamemoney=50000,ucmoney=5000,state=1}
].

