-ifndef(__record_hrl_).

-define(__record_hrl_, 1).

-record(achievementCfg,{id,type,param,param1,num,title,award,pro}).

-record(activitiesOrderCfg,{id,type,row,parenttype,iconpath,order,iconselectedpath}).

-record(arenaCfg,{id,startrank,endrank,points,itemid,intervalrank}).

-record(arena_robotCfg,{id,startrank,endrank,name,career,module,property,coefficient,initialfightingcapacity}).

-record(arenaTopCfg,{rank,award_item,title}).

-record(boxCfg,{id,content}).

-record(bossInfoCfg,{bossid,refreshtime,dropitem,order}).

-record(bossRefreshCfg,{id,notice,time}).

-record(broadcastCfg,{id,weekdays,yeardays,starttime,interval,times,textid}).

-record(buffCfg,{id,type,flag,name,effect1,effect2,isdiffforattack,acc,imme,duration,interval,power,powerpercent,attackpowerpercent,isremovedead}).

-record(clientSystemStringsCfg,{code,value,displaytype,channeltype}).

-record(consumptionDescriptionCfg,{consumptioncode,consumptiondescription}).

-record(copy_infoCfg,{id,gate_x,gate_y,free_cd,buy_price,boss_id,draw_lucky_price,copy_buff_price,lucky_items,ex_exp,ex_reputation,attack_boss_id,needitem,entertype,nextcopy,isshowcountdown,isremainmonstercnt,totaltime,iscreatenew}).

-record(createRoleCfg,{id,career,sex,bodyid,weaponid,skillid}).

-record(currencyDescriptionCfg,{code,description}).

-record(curseCfg,{curse,add_drop_rate,add_curse_rate}).

-record(digitAjustCfg,{id,value,description,value2}).

-record(downloadCfg,{id,awarditems,mailtitle,lv,award}).

-record(equipAdvancePropertyCfg,{equipmentlevel,propertynum,advancequality,propertyindex0,propertyindex1,propertyindex2,propertyindex3,hp,mp,ad,ap,dow,pd,md,hit,miss,crit}).

-record(equipAdvancePropertyQualityCfg,{propertyquality,propertypercent,weight}).

-record(equipAdvancePropIdRateCfg,{id,advance_type,money_num,money_type,prop_hp_weight,prop_mp_weight,prop_hit_weight,prop_miss_weight,prop_md_weight,prop_ma_weight,prop_pa_weight,prop_pd_weight,prop_dow_weight}).

-record(equipAdvancePropValueCfg,{value_id,value}).

-record(equipAdvanceValueIdRateCfg,{id,prop,value1,value1_weight,value2,value2_weight,value3,value3_weight,value4,value4_weight}).

-record(equipComposeCfg,{id,item_id_and_num}).

-record(equipEnvoyCopyCfg,{id,money,moneytype,reward}).

-record(equipmentCfg,{id,place,quality,hp,mp,phy_attack_bottom,phy_attack_top,phy_defence_bottom,phy_defence_top,magic_attack_bottom,magic_attack_top,dow_attack_bottom,dow_attack_top,magic_defence_bottom,magic_defence_top,dodge,hit,aspeed,luck,sword,insurance,crit,gemhp,iscanupgrade,nextupgradeid,processvalue,needprocessvalue,addprocessvalue,upgrademinvalue,fujia}).

-record(equipPromoteCfg,{level,materials_list_num,currency_list_num,equipment_property_promotion}).

-record(equipRandCfg,{level,num,rand_list}).

-record(equip_exchangeCfg,{id,cost}).

-record(equip_suitCfg,{id,name,equip_list,two,three,four,five,six,seven,eight,nine,ten,sex}).

-record(escortCfg,{id,awardexp,awardcoin,weight,rubrate,startnpc,endnpc,name,namecolor,speed}).

-record(everydayCfg,{id,fnum,score,desc,info}).

-record(everydayRewardCfg,{id,score,reward}).

-record(exchangeCfg,{id,type,newitem,olditem,costcoin,costgold,ratio,broadcast,maxtimeperday,period,minlevel,describle,sendtoclient,explain}).

-record(exchange_wordCfg,{id,require_item,exchange_item}).

-record(fairylandDataCfg,{mapdataid,npcid,needgold,needitemid,needitemnum,refreshtime,monsterid,tier,monsterlist,npcx,npcy,mapnpcid}).

-record(fightingCapacityCfg,{career,parameters}).

-record(forgeCfg,{id,limitlevel}).

-record(furyCfg,{id,minlevel,property,required_fury,max_fury}).

-record(gemCfg,{id,upgraded,treasure,num,composelevel,inlaylevel,specialmaterials,specialmoney}).

-record(gem_exchangeCfg,{index_id,shop_id,gem_data_id,gem_name,coin_cost,smelt_value_cost,flag,show_order,bind}).

-record(gem_holeCfg,{id,require_item,item_quantity,require_gold,is_open}).

-record(gem_smeltCfg,{id,value,name}).

-record(gem_vipCfg,{viplevel,discount}).

-record(ghostCopyCfg,{npcid,args}).

-record(giftCfg,{id,award}).

-record(growth_fundCfg,{id,level,gold,bind}).

-record(guaiwu_gongchengCfg,{id,refresh_monster_queue,birth_x,birth_y,target_x,target_y}).

-record(helpCfg,{id}).

-record(huangchengCfg,{id,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems,point_a,point_b}).

-record(huangchengintegralCfg,{id,award_items}).

-record(huangchengnewCfg,{id,keyvalue,award_items,leader_items,everyday_items}).

-record(huangcheng_jiangjunCfg,{id,jiangjun_pos,monster_id}).

-record(huiyaoshi_smeltCfg,{id,value}).

-record(illwealthactiveCfg,{id,comeoutday,comeouttime,comeoutpos,itemdetail1,item_num}).

-record(impact_level_awardCfg,{id,level,num,awarditems}).

-record(inviteCfg,{id,value,moneytype,money,itemlist,resid}).

-record(itemCfg,{id,type,detailtype,ifuse,name,sex,level,bind,overlaycnt,buytype,buyprice,selltype,sellprice,time,uselevel,usecareer,usetype,param1,param2,param3,param4,param5,quality,islog,cansale,equipment,cantotal,saletype}).

-record(killingIsLandAwardCfg,{scorerankstart,scorerankend,awarditemid,awarditemcount,participationitemid}).

-record(leagueBattleCfg,{id,level,offending_league_boss_position,defending_league_boss_position,offending_league_born_position,defending_league_born_position,energy_position_list,monster_list,map,awardcoin,awarditem1,time,fightmapid,bidtime,fighttime,clientime,victoryleagueexp,lostleagueexp}).

-record(leagueBossBuffCfg,{level,required_pills,buff_id_list,boss_id,boss_born_position,battle_boss_id}).

-record(leagueBossLevelCfg,{level,exp}).

-record(leagueCampfireCfg,{id,monster_id,map_data_id,exp_factor,exp,interval,league_exp}).

-record(leagueEscortCfg,{id,monster_data_id,position,required_fund,required_treasure,success_item_prize,success_fund_prize,robbed_returned_league_fund,rob_required,rob_success_prize,can_be_robbed,success_league_exp}).

-record(leagueShopCfg,{leaguelv,score,userlimit,scorelimit,shoplv,items}).

-record(leagueLevelUpgradeCfg,{league_level,required_items,hp,mp,attack,magic_attack,dao_attack,defence,magic_defence,hp_per,mp_per,attack_per,magic_attack_per,dao_attack_per,defence_per,magic_defence_per,max_member,signin_league_exp,copy_league_exp}).

-record(levelActivityCfg,{level,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems,awardexp,awardcoin}).

-record(loginNoticeCfg,{id,title,content,date,signature}).

-record(loginPrizeCfg,{days,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems}).

-record(luckupgradeCfg,{id,uprate,keeprate,downrate,can,killrate}).

-record(lunhuidaoCfg,{id,timelist,monsterlist,refreshtimer,totaltime}).

-record(luxury_signinCfg,{id,items}).

-record(magic_dragon_copyCfg,{id,monsterid,monsternum,x,y,cx,cy}).

-record(mapCfg,{id,type,activehighcopyid,name,file,bornx,borny,maxplayer,minlevel,maxlevel,entertimes,mapname,homemapid,major,partof,worldx,worldy,level,ringreach,jishafanwei,extension,killmail,monsterareas,automoveports,acturemaincityid,bosstype,levelnum,guaji,huodong,likai,shortcutsshow,fenxian,fanwei,mapdrop,needitem,taskpanel,addpk,isshowmainmenu}).

-record(masteriesCfg,{id,row,properties,previous_required_clicks,required_points,limit,name,desc}).

-record(militaryExploitsCfg,{id,award}).

-record(mineralCfg,{id,name,itemid,weight,broadcast,flag,count,tepy,onex,twox,rate}).

-record(moNiGongChengCfg,{id,starttime,totaltime,tipid1,tipid2,tipid3}).

-record(monsterPropertyCfg,{id,name,level,head,speed,hp,phy_attack_bottom,phy_attack_top,phy_defence_bottom,phy_defence_top,magic_attack_bottom,magic_attack_top,dow_attack_bottom,dow_attack_top,magic_defence_bottom,magic_defence_top,dodge,hit,patrol_radius,watch_radius,follow_radius,active,detect_hide,skillid,exp,drop_rule,is_can_tempt,is_can_push_move,expdecay,markstandon,monster_type,colorr,colorg,colorb,scale,face,coloropen,arms}).

-record(monsterDoorCfg,{id,map_data_id,x,y,block_regions}).

-record(monsterdropCfg,{id,num,item}).

-record(monsterSiegeCfg,{id,monsters,x,y,mapid}).

-record(newActivityCfg,{id,mapid,queryid,name,type,copy_type,level,freenum,buynum,buy_price,num,awarditem,timelist,pretime,closeentertime,totaltime,date,args}).

-record(newbie_copyCfg,{map_data_id,career_drop_item_list}).

-record(newRuleTipsCfg,{id}).

-record(newHandGuideCfg,{id,title,preid,nextid,guidetype,triggertype,triggerid,uimaintag,arrow,uitagtype,param1,param2,arrowtext,animation,animationposx,animationposy,maxlevel,uiberthtype,guide,ismust,isclearui,clicktype,isskip1,isskip2,delay,offset}).

-record(npcCfg,{id,name,dir,function,smalltype,sell,map,posx,posy}).

-record(npcCopyCfg,{npcid,args}).

-record(npc_transferCfg,{id,srcmapid, desmapid,des_x,des_y,biaozhi,requirelevel,requiregold}).

-record(offLineExpCfg,{id,rale}).

-record(onlineActivityCfg,{time,awarditems}).

-record(paihangbangCfg,{id,name,awarditems}).

-record(payCfg,{id,gamemoney,ucmoney,state}).

-record(payiosCfg,{id,gamemoney,ucmoney,state,name,appid}).

-record(paysingleCfg,{id,gold,items}).

-record(paytodayCfg,{id,gold,items}).

-record(paytotalCfg,{id,gold,items}).

-record(pay_sifuCfg,{id,gamemoney,ucmoney,state}).

-record(pay_sifu_996Cfg,{id,gamemoney,ucmoney,state}).

-record(pay_sifu_yfCfg,{id,gamemoney,ucmoney,state}).

-record(petPropertyCfg,{id,level,speed,hp,phy_attack_bottom,phy_attack_top,phy_defence_bottom,phy_defence_top,magic_attack_bottom,magic_attack_top,dow_attack_bottom,dow_attack_top,magic_defence_bottom,magic_defence_top,dodge,hit,patrol_radius,watch_radius,follow_radius,active,detect_hide,exp,drop_rule,upgrade_secs,unlock_modelid,property}).

-record(petModleCfg,{id,name,body_id,level,head,skillid,crit,cost_item,item_id,quantity,activate_id,describe}).

-record(petLevelCfg,{playerlevel,summon_animal_level,upgrade_animal_maxlevel}).

-record(playerdropCfg,{id,rate,bagnum,equiprate,equipnum}).

-record(playerExpCfg,{level,exp,easyexp,snatchexp,mhqxexp}).

-record(playerPropertyCfg,{id,level,career,hp,mp,speed,attack_speed,phy_attack_bottom,phy_attack_top,phy_defence_bottom,phy_defence_top,magic_attack_bottom,magic_attack_top,dow_attack_bottom,dow_attack_top,magic_defence_bottom,magic_defence_top,dodge,hit,crit}).

-record(quanmin_bossCfg,{id,require_item,exchange_item}).

-record(rageCfg,{id,comitem,nedditem,fury,furyvalue}).

-record(random_nameCfg,{type,name}).

-record(random_world_bossCfg,{id,map_data_id,monster_id,time}).

-record(regionCfg,{id,type,x,y,width,height, npc_type_id,monster_type_id, count_min, count_max, refresh_mode, interval,to_map_id, to_map_cx, to_map_cy,region_flag,file,map_id}).

-record(res_buttonCfg,{id,name,ispvr,path,normal,select,disable}).

-record(res_scale9spriteCfg,{id,name,ispvr,path,texrect,capinsets,namekey}).

-record(res_spriteCfg,{id,name,ispvr,path,namekey}).

-record(res_uibuttonCfg,{id,name,path,zorder,normal,select,disable,isscale9}).

-record(res_uicheckboxCfg,{id,name,path,zorder,background,selectbackground,disablebackground,foreground,selectforeground}).

-record(res_uiimageviewCfg,{id,name,path,zorder,isscale9}).

-record(res_uitextbuttonCfg,{id,name,path,zorder,normal,select,disable,isscale9}).

-record(res_uiwidgetCfg,{id,name,path,zorder}).

-record(richerCfg,{id,treasure,weights,coin}).

-record(role_static_modelCfg,{id,path}).

-record(rushMisssionCfg,{id,monsterid,suggestlevel,waittime,fighttime,pos,mapid,mapposx,mapposy,bossdropitems,layerreward,layerrewarditemlist,firstreward,uimonsterid}).

-record(rushMisssionResetTimesCfg,{id,freetimes,buytimes,treasure}).

-record(searchBossInfoCfg,{npcid,args}).

-record(sensitive_words_listCfg,{id,string}).

-record(serverarenaCfg,{level,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems,awardexp,awardcoin,day}).

-record(serverfightCfg,{level,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems,awardexp,awardcoin,day}).

-record(serverlevelCfg,{level,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems,awardexp,awardcoin,day}).

-record(serverrushCfg,{level,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems,awardexp,awardcoin,day}).

-record(serverTextCfg,{id,strtext}).

-record(serverUpCfg,{id,level,awarditems}).

-record(seveninfoCfg,{id}).

-record(sevenStarsCfg,{id,type,lv,reiki,phy_attack_bottom,phy_attack_top,phy_defence_bottom,phy_defence_top,magic_attack_bottom,magic_attack_top,dow_attack_bottom,dow_attack_top,magic_defence_bottom,magic_defence_top,dodge,hit,aspeed,luck,hp,mp,color}).

-record(seven_days_cheerCfg,{id,day,type,param,award_item,coin,yuanbao,exp}).

-record(seven_days_cheer_awardCfg,{id,progress,award_item,coin,yuanbao,box}).

-record(shopCfg,{id,itemid,itemname,item_type,price_type,price,sellprice,flag,show_order,bind,smelt_value_cost}).

-record(shoplimitedTimeDiscountCfg,{id,itemid,itemname,price_type,price,sellprice,flag,show_order,bind,allquota,onequota,starttime,endtime}).

-record(shopPackExchangeGoldCfg,{gold,packs,isbind}).

-record(shopPackExchangeItemCfg,{id,num,packs,isbind}).

-record(shopPackLimitCfg,{id,period,serverlimit,userlimit,isbind,itemid,content,price,name,introduction}).

-record(shop_996Cfg,{id,itemid,itemname,item_type,price_type,price,sellprice,flag,show_order,bind,smelt_value_cost}).

-record(shop_yfCfg,{id,itemid,itemname,item_type,price_type,price,sellprice,flag,show_order,bind,smelt_value_cost}).

-record(signInCfg,{id,awarditems,days}).

-record(skillCfg,{id,type,nextid,studyexpend,requiredskillpoints,studylevel,preid,level,theirprofession,name,sort,passitive,launchtime,cdtime,targettype,rangetype,range,maxtarget,damagetype,power,powerpercent,distance,costtype,cost,buffids,odds,param,scale}).

-record(soundCfg,{id,title,type,targetid,preload,delaytime,loop,group,filepath,param1,param2,param3,param4}).

-record(strength_allCfg,{id,properties}).

-record(strength_costCfg,{level,itemid,value,fit_value,str_exchange_down,cost,strength_rate,item_rate_list}).

-record(stringsCfg,{id}).

-record(systemStringsCfg,{code,value,displaytype,channeltype,range,times}).

-record(taskCfg,{id,title,type,detailtype,loopcnt,previd,nextid,min_level,max_level,useitemid,career,startnpc,endnpc,awardexp,awardcoin,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems,target,targetpos,completelevel}).

-record(tipsCfg,{id}).

-record(titleCfg,{id,type,name,description,icon,roleheadicon,hp,mp,attack,magic_attack,dao_attack,defence,magic_defence,hp_per,mp_per,attack_per,magic_attack_per,dao_attack_per,defence_per,magic_defence_per,effective_seconds}).

-record(total_chargeCfg,{id,yuanbao,awarditems,awarditemszhanshi,awarditemsfashi,awarditemsdaoshi}).

-record(total_charge_activityCfg,{id,yuanbao,awarditems,awarditemszhanshi,awarditemsfashi,awarditemsdaoshi}).

-record(towerDefenseAwardCfg,{id,spiritnum,awardexp,awardcoin}).

-record(towerDefenseCopyCfg,{id,monsterid,monsternum,waittime,x,y,cx,cy}).

-record(towerDefenseNpcCfg,{id,upgradeneedspirit,nextid,recoverneedgold,career,weapon,coat,x,y}).

-record(trapCfg,{id,dx,dy,damagetype,power,powerpercent,attackpowerpercent,interval,duration}).

-record(ucVipCfg,{index,title,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems}).

-record(undergroundPalaceCfg,{layer,bossid,bossx,bossy}).

-record(undergroundPalaceAwardCfg,{damagerankstart,damagerankend,damageitemid,damageitemcount,layeritemid,participationitemid}).

-record(vipCfg,{money,viplevel,title,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems,richertimes,hp,arena,extracopycd,minetime,richertime,gonggao,drinktime,luckyminetime,russmissionresettimes,huntingtime,chumofanpai,molongcopy,jiangjunfencopy,nimocopy,mailaward}).

-record(vipbuyCfg,{level,vipneed,itemid_hp,hp_num,itemid_mp,mp_num}).

-record(vipeachpayCfg,{money,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems}).

-record(vipEveryDayCfg,{viplevel,itemdataid}).

-record(vipEveryDayPayCfg,{id,limit,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems}).

-record(vipfirstpayCfg,{id,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems}).

-record(viptotalpayCfg,{money,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems}).

-record(vip_996Cfg,{money,viplevel,title,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems,richertimes,hp,arena,extracopycd,minetime,richertime,gonggao,drinktime,luckyminetime,russmissionresettimes,huntingtime,chumofanpai,molongcopy,jiangjunfencopy,nimocopy,mailaward}).

-record(vip_yfCfg,{money,viplevel,title,awarditems,zhanshiawarditems,daoshiawarditems,fashiawarditems,richertimes,hp,arena,extracopycd,minetime,richertime,gonggao,drinktime,luckyminetime,russmissionresettimes,huntingtime,chumofanpai,molongcopy,jiangjunfencopy,nimocopy,mailaward}).

-record(virtualPlayerCfg,{id,monsterlist,zhanshiskilllist,fashiskilllist,daoshiskill}).

-record(wakuangdropCfg,{id,probability,dropnum}).

-record(warofcityCfg,{id,name,awardcoin,awarditem1,awarditem2,awarditem3,awarditem4,time,attackernpcid,reliveposattacker,defendernpcid,reliveposdefender,fightmapid,bidtime,fighttime}).

-record(warofcitybuffCfg,{id,time,gold,add,buffid}).

-record(wheelCfg,{days,award,times}).

-record(wildbossCfg,{bossid,map_id,interval,start_time,end_time,x,y,cx,cy,max_count,min_count,awarditem,notice,go_map_id,go_x,go_y}).

-record(wingCfg,{id,lv,value,odds}).

-record(xinhuangchengCfg,{id,x,y,cx,xy}).



-endif.
