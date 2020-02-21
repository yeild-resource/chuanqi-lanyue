-ifndef(__MAIL_DEFINE_HRL__).
-define(__MAIL_DEFINE_HRL__, 1).

-define(Mail_Un_Read, 0).
-define(Mail_Read, 1).

-define(Max_System_Mail, 100).
-define(Mail_Title_Len, 40).
-define(Mail_Conten_Len, 160).
-define(Mail_Attr_Cnt, 5).

-define(Send_System_Mail_Failed_Title_Long, -1).
-define(Send_System_Mail_Failed_Content_Long, -2).
-define(Send_System_Mail_Failed_Name_Is_Not_Exit, -3).
-define(Send_System_Mail_Failed_Item, -4).
-define(Send_System_Mail_Succ, 1).

-define(Get_Attach_Failed_Bag_Is_Full, -1).

-record(mailRecord, {
  mailId = 0,
  mailReceivePlayerId = 0,
  mailTitle = "",
  mailType = 0,
  mailContent = "",
  mailSendName = "",
  mailReceiveName = "",
  mailItemIdMsgList = [],
  mailReadState = ?Mail_Un_Read,
  mailSendTime = 0,
  mailCoin = 0,
  mailBindCoin = 0,
  mailGold = 0,
  mailBindGold = 0
}).

-record(playerMailItemRecord, {
  mailId = 0,
  time = 0
}).

-record(playerMailRecord, {
  playerId = 0,
  mailItemIdList = []
}).

-endif.

