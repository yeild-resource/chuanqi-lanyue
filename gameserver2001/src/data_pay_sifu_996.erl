%%---------------------------------------
%% @Module	: data_pay_sifu_996
%% @Created	: 
%% @Description	: nothing
%%---------------------------------------

-module(data_pay_sifu_996).
-export([get_items/0,get_item/1,get_item/2]).
-include("record.hrl").

%% notice: you need add the record below to record.hrl
%% -record(pay_sifu_996Cfg,{id,gamemoney,ucmoney,state}).

get_item(Key)->
	List=get_items(),
	lists:keyfind(Key,#pay_sifu_996Cfg.id,List).

get_item(Idx,Key)->
	List=get_items(),
	lists:keyfind(Key,Idx,List).

get_items()->
	[
	#pay_sifu_996Cfg{id=1,gamemoney=2000,ucmoney=10,state=1},
	#pay_sifu_996Cfg{id=2,gamemoney=6000,ucmoney=30,state=1},
	#pay_sifu_996Cfg{id=3,gamemoney=10000,ucmoney=50,state=1},
	#pay_sifu_996Cfg{id=4,gamemoney=20000,ucmoney=100,state=1},
	#pay_sifu_996Cfg{id=5,gamemoney=60000,ucmoney=300,state=1},
	#pay_sifu_996Cfg{id=6,gamemoney=100000,ucmoney=500,state=1},
	#pay_sifu_996Cfg{id=7,gamemoney=200000,ucmoney=1000,state=1},
	#pay_sifu_996Cfg{id=8,gamemoney=400000,ucmoney=2000,state=1},
	#pay_sifu_996Cfg{id=9,gamemoney=600000,ucmoney=3000,state=1}
].

