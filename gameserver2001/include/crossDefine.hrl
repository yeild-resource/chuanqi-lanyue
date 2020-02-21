-define(CROSSPLAYER, 'crossplayer').
-define(CROSSSERV, 'crossserv').
-define(CROSSLOG, 'crosslog').
-define(CROSSZONE, 'crosszone').
-define(CROSSSIGN, 'crosssign').
-define(LEFT, 1).
-define(RIGHT, 2).

%% 跨服战玩家表
-record(cross_player, {
  playerid = 0,  %玩家ID
  servid = 0,  %服务器ID
  level = 1,  %玩家等级
  lscore = 0,  %个人帮会积分
  pscore = 0,  %贡献的帮会积分
  lfscore = 0,  %个人战斗积分
  rank = 0,    %个人战场排名(暂时没用到，实时计算到的排名)
  expReward = 0,%活动经验
  isReward = 0  %0未领奖 1领奖了
}).
%% 跨服战服务器
-record(cross_serv, {
  servid = 0,    %服务器ID
  score = 0,    %rank分
  rank = 0,    %排名
  zone = 0,    %分区（后台手动）
  side = 0    %左方1 右方2
}).