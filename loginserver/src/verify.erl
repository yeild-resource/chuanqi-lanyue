-module(verify).

-include("userDefine.hrl").
-include("platformDefine.hrl").
-include("common_include/logger.hrl").

-compile(export_all).

check_special(Acc, IP) ->
  case special_limits:get_special_acc(Acc) of
    false -> {?Login_LS_Result_Fail_Unsupport, Acc};
    _ ->
      case special_limits:get_special_ip(IP) of
        false -> {?Login_LS_Result_Fail_Unsupport, Acc};
        _ -> {?Verify_Result_Ok, Acc}
      end
  end.

%% check(?PLATFORM_LOCAL_IOS, Params) ->
%% 	[Account, _IP, Password | _ ] = Params,
%% 	case platformLocalIos:verifyRequest(Account, Password) of
%% 		success -> 
%% 			{?Verify_Result_Ok, Account};
%% 		_ -> 
%% 			{?Login_LS_Result_Fail_Forbidden, Account}
%% 	end;

check(?PLATFORM_TEST, Params) ->
  [Account, IP, _Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, DeviceIMEI | _] = Params,
  % BinarySign = erlang:iolist_to_binary(Sign),
  _GeneratedSign = erlang:iolist_to_binary(md5:encrypt(Account ++ DeviceIMEI ++ "sk``IIKKssss11189djglk%$&90qlkjl)31")),
%%   case GeneratedSign of
%%     _BinarySign ->
      case platformTest:isTestSupport() of
        true ->
          case verifyTest(Account, IP) of
            success ->
              {?Verify_Result_Ok, Account};
            _ ->
              {?Login_LS_Result_Fail_Forbidden, Account}
          end;
        false ->
          check_special(Account, IP)
      end;
%%     _ ->
%%       {?Login_LS_Result_Fail_Forbidden, Account}
%%   end;

check(?PLATFORM_UC, Params) ->
  [Account, IP, Code | _] = Params,
  ?DEBUG(verify, "check platform uc Account=~p,IP=~p,Code=~p", [Account, IP, Code]),
  case platformUC:isUCSupport() of
    yes ->
      case verifyUC(Code) of
        {success, State_code, Data_ucid, Data_nickName2} ->
          ?DEBUG(verify, "check platform uc ok!state code:~p,ucid:~p,name:~p", [State_code, Data_ucid, Data_nickName2]),
          {?Verify_Result_Ok, Data_ucid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_V5, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformV5:isV5Support() of
    yes ->
      case verifyV5(UserCode, Token) of
        {true, V5_UserCode} ->
          ?DEBUG(verify, "check platform v5 ok!state V5_UserCode:~p", [V5_UserCode]),
          {?Verify_Result_Ok, UserCode};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_V5_2B, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformV5_2B:isV5Support() of
    yes ->
      case verifyV5_2B(UserCode, Token) of
        {true, V5_UserCode} ->
          ?DEBUG(verify, "check platform v5 ok!state V5_UserCode:~p", [V5_UserCode]),
          {?Verify_Result_Ok, UserCode};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_91, Params) ->
  [UIN, IP, SID | _] = Params,
  ?DEBUG(verify, "check platform 91 UIN=~p,IP=~p,SID=~p", [UIN, IP, SID]),
  case platform91:is91Support() of
    yes ->
      case verify91(UIN, SID) of
        success ->
          ?DEBUG(verify, "check platform 91 ok!", []),
          {?Verify_Result_Ok, UIN};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_baidu, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformDK:isDKSupport() of
    yes ->
      case verifyDK(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DK ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_dangle, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformDL:isDLSupport() of
    yes ->
      case verifyDL(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;
check(?PLATFORM_360, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platform360:isQHSupport() of
    yes ->
      case verifyQH(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform QH ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_AppChina, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformAppChina:isAppChinaSupport() of
    yes ->
      case verifyAppChina(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_millet, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformMI:isMISupport() of
    yes ->
      case verifyMI(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_peasecod, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformWDJ:isWDJSupport() of
    yes ->
      case verifyWDJ(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_lenovo, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformLenovo:isLenovoSupport() of
    yes ->
      case verifyLenovo(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_Gionee, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformGionee:isGioneeSupport() of
    yes ->
      case verifyGionee(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_anzhi, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformAnzhi:isAnzhiSupport() of
    yes ->
      case verifyAnzhi(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_37, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platform37:is37Support() of
    yes ->
      case verify37(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_OPPO, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformOppo:isOppoSupport() of
    yes ->
      case verifyOppo(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_Kingsoft, Params) ->
  [UserCode, IP, Token] = Params,
  %% Account:userCode code:token
  case platformKingsoft:isKingsoftSupport() of
    yes ->
      case verifyKingsoft(UserCode, IP, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_QQ, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformQQ:isQQSupport() of
    yes ->
      case verifyQQ(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_201, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platform201:is201Support() of
    yes ->
      case verify201(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_91ios, Params) ->
  [UIN, IP, SID | _] = Params,
  ?DEBUG(verify, "check platform 91 ios UIN=~p,IP=~p,SID=~p", [UIN, IP, SID]),
  case platform91ios:is91Support() of
    yes ->
      case verify91ios(UIN, SID) of
        success ->
          ?DEBUG(verify, "check platform 91 ok!", []),
          {?Verify_Result_Ok, UIN};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_ppios, Params) ->
  ?DEBUG(verify, "check platform pp ios Params=~p", [Params]),
  [Post_data | _] = Params,
  ?DEBUG(verify, "check platform pp ios Post_data=~p", [Post_data]),
  case platformppios:isppSupport() of
    yes ->
      case verifyppios(Post_data) of
        {success, UIN} ->
          ?DEBUG(verify, "check platform 91 ok!", []),
          {?Verify_Result_Ok, UIN};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_itoolios, Params) ->
  ?DEBUG(verify, "check platform itools ios Params=~p", [Params]),
  [UserID, _IP, Session | _] = Params,
  ?DEBUG(verify, "check platform itools ios UserID=~p Session ~p", [UserID, Session]),
  case platformitoolios:isppSupport() of
    yes ->
      case verifyitoolsios(UserID, Session) of
        {success, UIN} ->
          ?DEBUG(verify, "check platform itools ios ok!", []),
          {?Verify_Result_Ok, UIN};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_vtc, Params) ->
  ?DEBUG(verify, "check platform vtc ios Params=~p", [Params]),
  [Post_data | _] = Params,
  ?DEBUG(verify, "check platform vtc ios Post_data=~p", [Post_data]),
  case platformvtcios:isvtcSupport() of
    yes ->
      case verifyvtcios(Post_data) of
        {success, UIN} ->
          ?DEBUG(verify, "check platform vtc ok!", []),
          {?Verify_Result_Ok, UIN};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_dangleios, Params) ->
  [UserCode, _IP, Token | _] = Params,
  %% Account:userCode code:token
  case platformDLios:isDLSupport() of
    yes ->
      case verifyDLios(UserCode, Token) of
        {true, Uid} ->
          ?DEBUG(verify, "check platform DL ios  ok!state DK_UserCode:~p", [Uid]),
          {?Verify_Result_Ok, Uid};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PlatformID_IOS_KY, Params) ->
  [Token | _] = Params,
  ?DEBUG(verify, "check platform ky ios Token=~p", [Token]),
  case platformklios:isKYSupport() of
    yes ->
      case verifykyios(Token) of
        {true, UIN} ->
          ?DEBUG(verify, "check platform ky ios ok!", []),
          {?Verify_Result_Ok, UIN};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_tbtios, Params) ->
  [_UserID, _IP, SessionKey | _] = Params,
  ?DEBUG(verify, "check platform tbt ios Token=~p", [SessionKey]),
  case platformtbtios:isTBTSupport() of
    yes ->
      case verifytbtios(SessionKey) of
        {true, UIN} ->
          ?DEBUG(verify, "check platform tbt ios ok!", []),
          {?Verify_Result_Ok, UIN};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_aisi, Params) ->
  [_UserID, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform aisi Token=~p", [Token]),
  case platformaisi:isaisiSupport() of
    yes ->
      case verifyaisi(Token) of
        {success, UserName} ->
          ?DEBUG(verify, "check platform aisi ok!", []),
          {?Verify_Result_Ok, UserName};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_hmios, Params) ->
  [UserID, _IP | _] = Params,
  ?DEBUG(verify, "check platform hm ios UserID=~p", [UserID]),
  case platformthmios:isHMSupport() of
    yes ->
      case verifyhmios(UserID) of
        {true, UserID} ->
          ?DEBUG(verify, "check platform hm ios ok!", []),
          {?Verify_Result_Ok, UserID};
        _ -> {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ -> {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_weiyou, Params) ->
  [OpenId, _IP, OpenKey | _] = Params,
  ?DEBUG(verify, "check platform weiyou OpenId = ~p  OpenKey = ~p", [OpenId, OpenKey]),
  case platformWeiyou:isWeiyouSupport() of
    yes ->
      case verifyweiyou(OpenId, OpenKey) of
        success ->
          ?DEBUG(verify, "check platform weiyou ok!", []),
          {?Verify_Result_Ok, OpenId};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% xy平台
check(?PLATFORM_xy, Params) ->
  [Uid, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform xy Uid = ~p  Token = ~p", [Uid, Token]),
  case platformXY:isppSupport() of
    yes ->
      case verifyxy(Uid, Token) of
        success ->
          ?DEBUG(verify, "check platform xy ok!", []),
          {?Verify_Result_Ok, Uid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% 水煮平台
check(?PLATFORM_shuizhu, Params) ->
  [Sid, _IP | _] = Params,
  ?DEBUG(verify, "check platform shuizhu Sid = ~p ", [Sid]),
  case platformShuizhu:isppSupport() of
    yes ->
      case verifyshuizhu(Sid) of
        {success, Suid} ->
          ?DEBUG(verify, "check platform shuizhu ok suid!", []),
          {?Verify_Result_Ok, Suid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% 越南平台
check(?PLATFORM_vtcid, Params) ->
  [Uid, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform VTCid Uid= ~p, Token=~p", [Uid, Token]),
  case platformVTCid:isppSupport() of
    yes ->
      case verifyVTCid(Uid, Token) of
        success ->
          ?DEBUG(verify, "check platform VTCid ok!", []),
          {?Verify_Result_Ok, Uid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% 爱贝平台
check(?PLATFORM_aibei, Params) ->
  [Uid, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform AiBei Uid= ~p, Token=~p", [Uid, Token]),
  case platformAiBei:isppSupport() of
    yes ->
      case verifyAiBei(Uid, Token) of
        success ->
          ?DEBUG(verify, "check platform AiBei ok!", []),
          {?Verify_Result_Ok, Uid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% 搜狗平台
check(?PLATFORM_sogou, Params) ->
  [Uid, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform Sogou Uid= ~p, Token=~p", [Uid, Token]),
  case platformSogou:isppSupport() of
    yes ->
      case verifySogou(Uid, Token) of
        success ->
          ?DEBUG(verify, "check platform Sogou ok!", []),
          {?Verify_Result_Ok, Uid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% N多平台
check(?PLATFORM_nduo, Params) ->
  [Uid, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform Nduo Uid= ~p, Token=~p", [Uid, Token]),
  case platformNduo:isppSupport() of
    yes ->
      case verifyNduo(Uid, Token) of
        success ->
          ?DEBUG(verify, "check platform Nduo ok!", []),
          {?Verify_Result_Ok, Uid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% 宜游平台
check(?PLATFORM_yiyou, Params) ->
  [Uid, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform Yiyou Uid= ~p, Token=~p", [Uid, Token]),
  case platformYiyou:isppSupport() of
    yes ->
      case verifyYiyou(Uid, Token) of
        success ->
          ?DEBUG(verify, "check platform Yiyou ok!", []),
          {?Verify_Result_Ok, Uid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% 手盟平台
check(?PLATFORM_shoumeng, Params) ->
  [Uid, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform Shoumeng Uid= ~p, Token=~p", [Uid, Token]),
  case platformShoumeng:isppSupport() of
    yes ->
      case verifyShoumeng(Uid, Token) of
        success ->
          ?DEBUG(verify, "check platform Shoumeng ok!", []),
          {?Verify_Result_Ok, Uid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;
%% 开心平台
check(?PLATFORM_KX, Params) ->
  [Uid, IP, Token, ServerID | _] = Params,
  ?DEBUG(verify, "check platform kx Uid= ~p, Token=~p", [Uid, Token]),
  case platformKX:isppSupport() of
    yes ->
      case verifyKX(Uid, IP, Token, ServerID) of
        {success, UserID} ->
          ?DEBUG(verify, "check platform kx ok!", []),
          {?Verify_Result_Ok, UserID};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% 开心ios平台
check(?PLATFORM_IOS_KX, Params) ->
  [Uid, IP, Token, ServerID | _] = Params,
  ?DEBUG(verify, "check platform kxios Uid= ~p, Token=~p", [Uid, Token]),
  case platformKX:isppSupport() of
    yes ->
      case verifyKXios(Uid, IP, Token, ServerID) of
        {success, UserID} ->
          ?DEBUG(verify, "check platform kx ok!", []),
          {?Verify_Result_Ok, UserID};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_FAST_LOGIN, Params) ->
  [Uid | _] = Params,
  ?DEBUG(verify, "check platform fastlogin Uid= ~p", [Uid]),
  case platformfastLogin:isFastLoginSupport() of
    yes ->
      case verifyFastLogin(Uid) of
        {success, Uid} ->
          ?DEBUG(verify, "check platform fast login ok!", []),
          {?Verify_Result_Ok, Uid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% 华为平台
check(?PLATFORM_huawei, Params) ->
  [Uid, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform huawei Uid= ~p, Token=~p", [Uid, Token]),
  case platformHuaWei:isSupport() of
    yes ->
      case verifyhuawei(Uid, Token) of
        {success, UserID} ->
          ?DEBUG(verify, "check platform huawei ok!", []),
          {?Verify_Result_Ok, UserID};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% 微游汇平台
check(?PLATFORM_weiuu, Params) ->
  [Uid, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform weiuu Uid= ~p, Token=~p", [Uid, Token]),
  case platformWeiuu:isSupport() of
    yes ->
      case verifyweiuu(Uid, Token) of
        {success, UserID} ->
          ?DEBUG(verify, "check platform weiuu ok!", []),
          {?Verify_Result_Ok, UserID};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% 微游汇ios平台
check(?PLATFORM_weiuu_iso, Params) ->
  [Uid, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform weiuu ios Uid= ~p, Token=~p", [Uid, Token]),
  case platformWeiuuios:isSupport() of
    yes ->
      case verifyweiuuios(Uid, Token) of
        {success, UserID} ->
          ?DEBUG(verify, "check platform weiuu ios ok!", []),
          {?Verify_Result_Ok, UserID};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% 木蚂蚁平台
check(?PLATFORM_mumayi, Params) ->
  [Uid, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform mumayi Uid= ~p, Token=~p", [Uid, Token]),
  case platformMumayi:isSupport() of
    yes ->
      case verifymumayi(Uid, Token) of
        success ->
          ?DEBUG(verify, "check platform mumayi ok!", []),
          {?Verify_Result_Ok, Uid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%% 机峰平台
check(?PLATFORM_jifeng, Params) ->
  [Uid, _IP, Token | _] = Params,
  ?DEBUG(verify, "check platform jifeng Uid= ~p, Token=~p", [Uid, Token]),
  case platformJifeng:isSupport() of
    yes ->
      case verifyjifeng(Uid, Token) of
        success ->
          ?DEBUG(verify, "check platform jifeng ok!", []),
          {?Verify_Result_Ok, Uid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

%%光宇游戏平台， 后来修改为接gameCenter
check(?PLATFORM_GUANGYU, Params) ->
  [PlayerId, _IP, Signature, PublicUrl, BundleId, Salt, Timestamp, DeviceIMEI | _] = Params,
  case platformGuangyu:isGuangyuSupport() of
    1 ->
      VerifyGuangyuResult = verifyGuangyu(PlayerId, Signature, PublicUrl, BundleId, Salt, Timestamp, DeviceIMEI),
      case VerifyGuangyuResult of %%光宇的账号ID从服务器账号返回取，不认客户端传的那个
        {success, Uid} ->
          {?Verify_Result_Ok, Uid};
        {failed, ErrorCode} ->
          {ErrorCode, 0};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    _ ->
      {?Login_LS_Result_Fail_Unsupport, 0}
  end;

check(?PLATFORM_GUANGYU_ANDROID, Params) ->
  [Uid, _IP, Token | _] = Params,
  case platformGuangyu:verify(Uid, Token) of
    {success, UserId} ->
      {?Verify_Result_Ok, UserId};
    {failed, ErrorCode} ->
      {ErrorCode, 0};
    _ ->
      {?Login_LS_Result_Fail_UserNameOrPassword, 0}
  end;

check(?PLATFORM_GUANGYU_IOS, Params) ->
  [Uid, _Ip, Token | _] = Params,
  case platformGuangyu:verify(Uid, Token) of
    {success, UserId} ->
      {?Verify_Result_Ok, UserId};
    {failed, ErrorCode} ->
      {ErrorCode, 0};
    _ ->
      {?Login_LS_Result_Fail_UserNameOrPassword, 0}
  end;

%% check( ?PLATFORM_IOS_ASYX, Params) ->
%% 	[_Uid, _Ip, Sid | _ ] = Params,
%% 	case platformAiShangYouXi:verifyRequest(Sid) of
%% 		{success, UserId, _UserName, _Sid} ->
%% 			{?Verify_Result_Ok, UserId};
%% 		{error, ErrorCode} ->
%% 			{ErrorCode, 0};
%% 		_ ->
%% 			{?Login_LS_Result_Fail_UserNameOrPassword, 0}
%% 	end;

check(?PLATFORM_DY, Params) ->
    [Account, IP, _Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    ?DEBUG(verify, "check platform DY Account=~p,IP=~p", [Account, IP]),

    {?PLATFORM_DY, PlatformSpecificStringList} = get(platformSpecific),
    LoginTime = lists:nth(1, PlatformSpecificStringList),
    case platformDY:isDYSupport() of
        yes ->
            case platformDY:verifyRequestDY(Account, LoginTime) of
                {success, State_code, Data_Account} ->
                    ?DEBUG(verify, "check platform DY ok!state code:~p, Data_Account:~p", [State_code, Data_Account]),
                    {?Verify_Result_Ok, Data_Account};
                _ ->
                    {?Login_LS_Result_Fail_UserNameOrPassword, 0}
            end;
        _ ->
            {?Login_LS_Result_Fail_Unsupport, 0}
    end;

check(?PLATFORM_SIFU_996, Params) ->
    [Account, _IP, _Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    {?PLATFORM_SIFU_996, PlatformSpecificStringList} = get(platformSpecific),
    LoginTime = lists:nth(1, PlatformSpecificStringList),
    case platformDY:verifyRequestDY(Account, LoginTime) of
        {success, _State_code, Data_Account} ->
            {?Verify_Result_Ok, Data_Account};
        _ ->
            {?Login_LS_Result_Fail_UserNameOrPassword, 0}
    end;

check(?PLATFORM_SIFU_YUFENG, Params) ->
    [Account, _IP, _Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    {?PLATFORM_SIFU_YUFENG, PlatformSpecificStringList} = get(platformSpecific),
    LoginTime = lists:nth(1, PlatformSpecificStringList),
    case platformDY:verifyRequestDY(Account, LoginTime) of
        {success, _State_code, Data_Account} ->
            {?Verify_Result_Ok, Data_Account};
        _ ->
            {?Login_LS_Result_Fail_UserNameOrPassword, 0}
    end;

check(?PLATFORM_VIVO, Params) ->
    [Account, IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    ?DEBUG(verify, "check platform VIVO Account=~p,IP=~p", [Account, IP]),
   case platformVivo:verify(Sign) of
       {success, Uid} ->
           ?DEBUG(verify, "check platform VIVO ok! Uid:~p", [Uid]),
           {?Verify_Result_Ok, Uid};
       _ ->
           {?Login_LS_Result_Fail_UserNameOrPassword, 0}
   end;

check(?PLATFORM_CoolPad, Params) ->
    [Account, IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    ?DEBUG(verify, "check platform CoolPad Account=~p,IP=~p", [Account, IP]),

    case platformCoolPad:isSupport() of
        yes ->
            case platformCoolPad:verify(Sign) of
                {true, Uid} ->
                    ?DEBUG(verify, "check platform CoolPad ok! Uid:~p", [Uid]),
                    {?Verify_Result_Ok, Uid};
                _ ->
                    {?Login_LS_Result_Fail_UserNameOrPassword, 0}
            end;
        _ ->
            {?Login_LS_Result_Fail_Unsupport, 0}
    end;

check(?PLATFORM_MeiZu, Params) ->
    [Uid, IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    ?DEBUG(verify, "check platform MeiZu Uid=~p,IP=~p, Sign: ~p", [Uid, IP, Sign]),

    case platformMeiZu:isSupport() of
        yes ->
            case platformMeiZu:verify(Uid, Sign) of
                {true, Uid} ->
                    ?DEBUG(verify, "check platform MeiZu ok! Uid:~p", [Uid]),
                    {?Verify_Result_Ok, Uid};
                _ ->
                    {?Login_LS_Result_Fail_UserNameOrPassword, 0}
            end;
        _ ->
            {?Login_LS_Result_Fail_Unsupport, 0}
    end;

%% TT
check(?PLATFORM_TT, Params) ->
  [Uid, _IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
  case platformTT:verify(Uid, Sign) of
    {true, Uid} ->
      {?Verify_Result_Ok, Uid};
    _ ->
      {?Login_LS_Result_Fail_UserNameOrPassword, 0}
  end;

%% 好盟
check(?PLATFORM_Haomeng, Params) ->
  [Uid, _IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
  case platformHaomeng:verify(Uid, Sign) of
    {true, Uid} ->
      {?Verify_Result_Ok, Uid};
    _ ->
      {?Login_LS_Result_Fail_UserNameOrPassword, 0}
  end;

%% 虫虫
check(?PLATFORM_CC, Params) ->
    [Uid, _IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    case platformCC:verify(Sign) of
        true  ->
            {?Verify_Result_Ok, Uid};
        _ ->
            {?Login_LS_Result_Fail_UserNameOrPassword, 0}
    end;

%% 果盘
check(?PLATFORM_GuoPan, Params) ->
    [Uid, _IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    case platformGuopan:verify(Uid, Sign) of
        true  ->
            {?Verify_Result_Ok, Uid};
        _ ->
            {?Login_LS_Result_Fail_UserNameOrPassword, 0}
    end;

%% 说玩
check(?PLATFORM_ShuoWan, Params) ->
    [Uid, _IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    {?PLATFORM_ShuoWan, PlatformSpecificStringList} = get(platformSpecific),
    UserName = lists:nth(1, PlatformSpecificStringList),
    case platformShuowan:verify(UserName, Uid, Sign) of
        true  ->
            {?Verify_Result_Ok, UserName};
        _ ->
            {?Login_LS_Result_Fail_UserNameOrPassword, 0}
    end;

%% 乐游
check(?PLATFORM_LeYou, Params) ->
    [_Uid, _IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    {?PLATFORM_LeYou, PlatformSpecificStringList} = get(platformSpecific),
    UserName = lists:nth(1, PlatformSpecificStringList),
    case platformLeyou:verify(UserName, Sign) of
        true  ->
            {?Verify_Result_Ok, UserName};
        _ ->
            {?Login_LS_Result_Fail_UserNameOrPassword, 0}
    end;

%% 朋友玩
check(?PLATFORM_PengYouWan, Params) ->
    [Uid, _IP, _Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    {?PLATFORM_PengYouWan, PlatformSpecificStringList} = get(platformSpecific),
    Tid = lists:nth(1, PlatformSpecificStringList),
    case platformPengyouwan:verify(Tid, Uid) of
        true  ->
            {?Verify_Result_Ok, Uid};
        _ ->
            {?Login_LS_Result_Fail_UserNameOrPassword, 0}
    end;

%% 爱游戏
check(?PLATFORM_AiYouXi, Params) ->
    [Uid, _IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    case platformAiyouxi:verify(Sign) of
        true  ->
            {?Verify_Result_Ok, Uid};
        _ ->
            {?Login_LS_Result_Fail_UserNameOrPassword, 0}
    end;

%% 996
check(?PLATFORM_SIFU_996_FangYou, Params) ->
    [Uid, _IP, _Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
    {?PLATFORM_SIFU_996_FangYou, PlatformSpecificStringList} = get(platformSpecific),
    Username = lists:nth(1, PlatformSpecificStringList),
    case platformFangYou996:verify(Username, Uid) of
        true  ->
            {?Verify_Result_Ok, Username};
        _ ->
            {?Login_LS_Result_Fail_UserNameOrPassword, 0}
    end;

check(?PLATFORM_SIFU_JINZHU, Params) ->
  [Uid, _IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
  case platformGame:verify(Uid, Sign, ?PLATFORM_SIFU_JINZHU) of
    true  ->
      {?Verify_Result_Ok, Uid};
    _ ->
      {?Login_LS_Result_Fail_UserNameOrPassword, 0}
  end;

check(?PLATFORM_SIFU_195, Params) ->
  [Uid, _IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
  case platformSifu195:verify(Uid, Sign) of
    true  ->
      {?Verify_Result_Ok, Uid};
    _ ->
      {?Login_LS_Result_Fail_UserNameOrPassword, 0}
  end;

%% ceshi
check(?PLATFORM_SIFU_195_1, Params) ->
  [Uid, _IP, _Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
  {?Verify_Result_Ok, Uid};

check(?PLATFORM_SIFU_DAMAI, Params) ->
  [Uid, _IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
  case platformSf_DaMa:verify(Uid, Sign) of
    true  ->
      {?Verify_Result_Ok, Uid};
    _ ->
      {?Login_LS_Result_Fail_UserNameOrPassword, 0}
  end;

check(Platform, Params) ->
  ?ERR(check, "Platform=~p, Params=~p", [Platform, Params]),
  if
    Platform >= ?PLATFORM_SIFU_JINZHU andalso Platform =< ?PLATFORM_SIFU_JINZHU_MAX ->
      ?ERR(check, "222"),
      [Uid, _IP, Sign, _PublicUrl, _BundleId, _Salt, _Timestamp, _DeviceIMEI | _] = Params,
      case platformGame:verify(Uid, Sign, Platform) of
        true  ->
          {?Verify_Result_Ok, Uid};
        _ ->
          {?Login_LS_Result_Fail_UserNameOrPassword, 0}
      end;
    true ->
      ?ERR(check, "222"),
      {?Login_LS_Result_Fail_Unsupport, 0}
  end.

%%check(_, _) ->
%%  {?Login_LS_Result_Fail_Unsupport, 0}.

%%%-======================================================================
%%%-======================================================================
%%%-======================================================================
%% 测试平台验证
-spec verifyTest(Account, IP) -> success | failed when
  Account :: string(),
  IP :: string().
verifyTest(Account, IP) when erlang:is_list(Account) ->
  ?DEBUG(verifyTest, "verifyTest Account=~p, IP=~p", [Account, IP]),
  case platformTest:isTestCheck() of
    true ->
      case loginMysqlProc:select_test_platform_allow_account(Account) of
        true ->
          success;
        false ->
          ?INFO(verifyTest, "verifyTest failed. Account:[~p], IP:[~p]", [Account, IP]),
          failed
      end;
    false ->
      success
  end.

%%553平台验证
verify553(Account, Time, Sign) ->
  ?DEBUG(verify553, "verify553 Account:[~p],Time[~p],Sign[~p]", [Account, Time, Sign]),
  case md5:encrypt(common:formatString(Time) ++ Account ++ ?KEY_PLATFORM_553_VERIFY) of
    Sign ->
      success;
    _ ->
      ?INFO(verify553, "verify553 TimeString:[~p],Key:[~p],md5:encrypt[~p]", [common:formatString(Time), ?KEY_PLATFORM_553_VERIFY, md5:encrypt(common:formatString(Time) ++ Account ++ ?KEY_PLATFORM_553_VERIFY)]),
      failed
  end.

verify553_android(Account, Time, Sign) ->
  ?DEBUG(verify553_android, "verify553_android Account:[~p],Time[~p],Sign[~p]", [Account, Time, Sign]),
  case md5:encrypt(common:formatString(Time) ++ Account ++ ?KEY_PLATFORM_553_ANDROID_VERIFY) of
    Sign ->
      success;
    _ ->
      ?INFO(verify553_android, "verify553_android TimeString:[~p],Key:[~p],md5:encrypt[~p]", [common:formatString(Time), ?KEY_PLATFORM_553_ANDROID_VERIFY, md5:encrypt(common:formatString(Time) ++ Account ++ ?KEY_PLATFORM_553_ANDROID_VERIFY)]),
      failed
  end.

%%苹果平台验证
verifyAPPS(Account, Time, Sign) ->
  ?DEBUG(verifyAPPS, "verifyAPPS Account:[~p],Time[~p],Sign[~p]", [Account, Time, Sign]),
  case md5:encrypt(common:formatString(Time) ++ Account ++ ?KEY_PLATFORM_APPS_VERIFY) of
    Sign ->
      success;
    _ ->
      ?INFO(verifyAPPS, "verify553 TimeString:[~p],Key:[~p],md5:encrypt[~p]", [common:formatString(Time), ?KEY_PLATFORM_APPS_VERIFY, md5:encrypt(common:formatString(Time) ++ Account ++ ?KEY_PLATFORM_APPS_VERIFY)]),
      failed
  end.

%%皮皮平台验证
verifyPP(Account, Token1, Token2) ->
  ?INFO(verifyPP, "verifyPP Account:[~p],Token1[~p],Token2[~p]", [Account, Token1, Token2]),
  %% 合成Token串
  Bin0 = messageBase:write_int64(Token1),
  Bin1 = messageBase:write_int64(Token2),
  Token = <<Bin0/binary, Bin1/binary>>,
  ?DEBUG(verifyPP, "verifyPP Token[~p]", [Token]),
  platformPP:verifyRequestPP(Account, Token).

%%360平台验证
verify360(Code) ->
  ?INFO(verify360, "verify360 Code[~p]", [Code]),
  platform360:verifyRequest360(Code).

%%UC平台验证
verifyUC(Code) ->
  ?INFO(verifyUC, "verifyUC Code[~p]", [Code]),
  gen_server:call(platformUCVerify_PID, {verify, Code}).

%%%% DY平台验证
verifyV5(UserCode, Token) ->
  ?INFO(verifyV5, "verifyV5 Code[~p]", [UserCode]),
  platformV5:verifyRequestV5(UserCode, Token).
%%V5平台验证
verifyV5_2B(UserCode, Token) ->
  ?INFO(verifyV5_2B, "verifyV5 Code[~p]", [UserCode]),
  platformV5_2B:verifyRequestV5(UserCode, Token).


%% 91平台验证
verify91(Uin, SessionID) ->
  ?INFO(verify91, "verify91 Uin[~p],SessionID[~p]", [Uin, SessionID]),
  platform91:verifyRequest91(Uin, SessionID).

%%多酷平台验证
verifyDK(Uid, SessionID) ->
  platformDK:verifyRequestDK(Uid, SessionID).

verifyDL(Uid, Token) ->
  platformDL:verifyRequestDL(Uid, Token).

verifyWDJ(Uid, Token) ->
  platformWDJ:verifyRequestWDJ(Uid, Token).

verifyQH(Uid, Token) ->
  ?DEBUG(fieldsR, "fieldsRequestQH Uid:~p, Token=~p", [Uid, Token]),
%%  case Uid of
%%    "10000" ->
      platform360:fieldsRequestQH(Token, Uid).
%%    _ ->
%%      platform360:verifyRequestQH(Uid, Token)
%%  end.

verifyAppChina(Uid, Token) ->
  platformAppChina:verifyRequestAppChina(Uid, Token).

verifyMI(Uid, Token) ->
  platformMI:verifyRequestMI(Uid, Token).

verifyLenovo(Uid, Token) ->
  platformLenovo:verifyRequestLenovo(Uid, Token).

verifyGionee(Uid, Token) ->
  platformGionee:verifyRequestGionee(Uid, Token).

verifyAnzhi(Uid, Token) ->
  platformAnzhi:verifyRequestAnzhi(Uid, Token).

verify37(Uid, Token) ->
  platform37:verifyRequest37(Uid, Token).

verifyOppo(Uid, Token) ->
  platformOppo:verifyRequestOppo(Uid, Token).

verifyKingsoft(Uid, Ip, Token) ->
  platformKingsoft:verifyRequestKingsoft(Uid, Ip, Token).

verifyQQ(Uid, Token) ->
  platformQQ:verifyRequestQQ(Uid, Token).

verify201(Uid, Token) ->
  platform201:verifyRequest201(Uid, Token).

verify91ios(Uin, SessionID) ->
  ?INFO(verify91ios, "verify91 Uin[~p],SessionID[~p]", [Uin, SessionID]),
  platform91ios:verifyRequest91(Uin, SessionID).

verifyppios(Post_data) ->
  ?INFO(verifyppios, "verifypp Post_data[~p]", [Post_data]),
  platformppios:verifyRequestppios(Post_data).

verifyitoolsios(UserID, SessionKey) ->
  ?INFO(verifyitoolsios, "verifyitoolsios UserID[~p],SessionKey[~p]", [UserID, SessionKey]),
  platformitoolios:verifyRequestitoolios(UserID, SessionKey).

verifyDLios(Uid, Token) ->
  platformDLios:verifyRequestDL(Uid, Token).

verifykyios(Token) ->
  platformklios:verifyRequestKY(Token).

verifytbtios(SessionKey) ->
  platformtbtios:verifyRequestTBT(SessionKey).

verifyvtcios(Post_data) ->
  ?INFO(verifyvtcios, "verifypp Post_data[~p]", [Post_data]),
  platformvtcios:verifyRequestvtc(Post_data).

verifyaisi(Token) ->
  ?INFO(verifyaisi, "verifyaisi Token[~p]", [Token]),
  platformaisi:verifyRequestaisi(Token).


verifyhmios(UserID) ->
  ?INFO(verifyhmios, "verifyaisi UserID[~p]", [UserID]),
  platformthmios:verifyRequestHM(UserID).

%% 威游平台验证
verifyweiyou(OpenId, OpenKey) ->
  ?INFO(verifyweiyou, "verifyweiyou OpenId = ~p  OpenKey = ~p", [OpenId, OpenKey]),
  platformWeiyou:verifyRequestWeiyou(OpenId, OpenKey).

%%xy平台验证
verifyxy(Uid, Token) ->
  ?INFO(verifyxy, "verifyxy Uid = ~p  Token = ~p", [Uid, Token]),
  platformXY:verifyRequestxy(Uid, Token).

%%水煮平台验证
verifyshuizhu(Sid) ->
  ?INFO(verifyxy, "verifyxy Uid = ~p ", [Sid]),
  platformShuizhu:verifyRequestxy(Sid).

%% 越南平台验证
verifyVTCid(Uid, Token) ->
  ?INFO(verifyVTCid, "verify Uid = ~p, Token=~p", [Uid, Token]),
  platformVTCid:verifyRequestTVCid(Uid, Token).

%% 爱贝平台验证
verifyAiBei(Uid, Token) ->
  ?INFO(verifyAiBei, "verify Uid = ~p, Token=~p", [Uid, Token]),
  platformAiBei:verifyRequestaibei(Uid, Token).

%% 搜狗平台验证
verifySogou(Uid, Token) ->
  ?INFO(verifySogou, "verify Uid = ~p, Token=~p", [Uid, Token]),
  platformSogou:verifyRequestsogou(Uid, Token).

%% N多平台验证
verifyNduo(Uid, Token) ->
  ?INFO(verifyNduo, "verify Uid = ~p, Token=~p", [Uid, Token]),
  platformNduo:verifyRequestnduo(Uid, Token).

%% 宜游平台验证
verifyYiyou(Uid, Token) ->
  ?INFO(verifyYiyou, "verify Uid = ~p, Token=~p", [Uid, Token]),
  platformYiyou:verifyRequestyiyou(Uid, Token).

%% 手盟平台验证
verifyShoumeng(Uid, Token) ->
  ?INFO(verifyShoumeng, "verify Uid = ~p, Token=~p", [Uid, Token]),
  platformShoumeng:verifyRequestshoumeng(Uid, Token).

%%开心平台验证
verifyKX(Uid, IP, Token, ServerID) ->
  ?INFO(verifyKX, "verify Uid = ~p, Token=~p, ServerID=~p", [Uid, Token, ServerID]),
  platformKX:verifyRequestkx(Uid, IP, Token, ServerID).

%%开心ios验证
verifyKXios(Uid, IP, Token, ServerID) ->
  ?INFO(verifyKXios, "verify Uid = ~p, Token=~p, ServerID=~p", [Uid, Token, ServerID]),
  platformKXios:verifyRequestkx(Uid, IP, Token, ServerID).

%%华为平台验证
verifyhuawei(Uid, Token) ->
  ?INFO(verifyhuawei, "verify Uid = ~p, Token=~p", [Uid, Token]),
  platformHuaWei:verifyRequesthuawei(Token).

verifyweiuu(Uid, Token) ->
  ?INFO(verifyweiuu, "verify Uid = ~p, Token=~p", [Uid, Token]),
  platformWeiuu:verifyRequestweiuu(Token).
verifyFastLogin(Uid) ->
  ?INFO(verifyFastLogin, "verify Uid = ~p", [Uid]),
  platformfastLogin:verifyRequestfastlogin(Uid).

%%微游汇平台验证
verifyweiuuios(Uid, Token) ->
  ?INFO(verifyweiuuios, "verify Uid = ~p, Token=~p", [Uid, Token]),
  platformWeiuuios:verifyRequestweiuu(Token).

%%木蚂蚁平台验证
verifymumayi(Uid, Token) ->
  ?INFO(verifymumayi, "verify Uid = ~p, Token=~p", [Uid, Token]),
  platformMumayi:verifyRequestmumayi(Uid, Token).

%%机峰平台验证
verifyjifeng(Uid, Token) ->
  ?INFO(verifyjifeng, "verify Uid = ~p, Token=~p", [Uid, Token]),
  platformJifeng:verifyRequestjifeng(Uid, Token).

verifyGuangyu(Uid, Signature, PublicUrl, BundleId, Salt, Timestamp, DeviceIMEI) ->
  ?INFO(verifyGuangyu, "Uid:~p, DeviceIMEI: ~p, Signature: ~p, PublicUrl: ~p, BundleId: ~p, Salt: ~p, Timestamp:~p", [Uid, DeviceIMEI, Signature, PublicUrl, BundleId, Salt, Timestamp]),
  platformGuangyu:verify(Uid, Signature, PublicUrl, BundleId, Salt, Timestamp, DeviceIMEI).

