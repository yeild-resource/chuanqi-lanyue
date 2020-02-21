-- MySQL dump 10.13  Distrib 5.6.31, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: dragongamedata2001
-- ------------------------------------------------------
-- Server version	5.6.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `dragongamedata2001`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dragongamedata2001` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `dragongamedata2001`;

--
-- Table structure for table `arena`
--

DROP TABLE IF EXISTS `arena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arena` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '竞技场排名',
  `playerid` bigint(20) NOT NULL COMMENT '玩家id，如果是机器人， 则为机器人的名次',
  `points` int(11) NOT NULL COMMENT '竞技场积分',
  PRIMARY KEY (`id`,`playerid`),
  UNIQUE KEY `idx_player_id` (`playerid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='竞技场数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arena_msg`
--

DROP TABLE IF EXISTS `arena_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arena_msg` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '竞技场消息id',
  `playerid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家id',
  `mirrorPlayerid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家镜像或者机器人镜像id',
  `type` int(4) NOT NULL COMMENT '0表示玩家， 1表示机器人',
  `flag` int(4) unsigned NOT NULL DEFAULT '0' COMMENT '0表示主动挑战，1表示被挑战',
  `rank` int(11) NOT NULL DEFAULT '0' COMMENT '挑战过后的排名',
  `time` int(4) unsigned DEFAULT '0' COMMENT '竞技场挑战的时间',
  PRIMARY KEY (`id`),
  KEY `playerid` (`playerid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8071 DEFAULT CHARSET=utf8 COMMENT='竞技场玩家战斗日志消息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `army_data`
--

DROP TABLE IF EXISTS `army_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `army_data` (
  `playerid` bigint(20) NOT NULL COMMENT '玩家ID',
  `armyid` bigint(20) NOT NULL COMMENT '仇人ID',
  UNIQUE KEY `idx_army` (`playerid`,`armyid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='仇人关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blacklist_data`
--

DROP TABLE IF EXISTS `blacklist_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blacklist_data` (
  `playerid` bigint(20) NOT NULL COMMENT '玩家ID',
  `blackid` bigint(20) NOT NULL COMMENT '对应黑名单ID',
  UNIQUE KEY `idx_black` (`playerid`,`blackid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='黑名单关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `everyday`
--

DROP TABLE IF EXISTS `everyday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `everyday` (
  `playerid` bigint(11) NOT NULL COMMENT '玩家ID',
  `id` int(10) DEFAULT NULL COMMENT '任务ID',
  `times` int(10) DEFAULT NULL COMMENT '完成次数',
  UNIQUE KEY `idx_everyday` (`playerid`,`id`) USING BTREE,
  KEY `idx_everydayp` (`playerid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每日必做次数统计';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `everyday_mineral`
--

DROP TABLE IF EXISTS `everyday_mineral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `everyday_mineral` (
  `player_id` bigint(20) NOT NULL COMMENT '玩家ID',
  `free_lucky_times` tinyint(4) NOT NULL COMMENT '已用免费幸运挖矿次数',
  `free_mystery_times` tinyint(4) NOT NULL COMMENT '已用免费神秘挖矿次数',
  `mined_lucky_times` int(11) NOT NULL COMMENT '已幸运探矿次数',
  `mined_mystery_times` int(11) NOT NULL COMMENT '已神秘探矿次数',
  `lucky_reset_times` int(11) NOT NULL COMMENT '幸运探矿重置次数',
  `mystery_reset_times` int(11) NOT NULL COMMENT '神秘探矿重置次数',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每日挖矿 (1.此表数据表示今天已用次数；2.数据零时清空)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `everyday_reward`
--

DROP TABLE IF EXISTS `everyday_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `everyday_reward` (
  `playerid` bigint(11) NOT NULL COMMENT '玩家ID ',
  `lv` smallint(5) DEFAULT NULL COMMENT '奖励等级',
  `status` smallint(5) DEFAULT NULL COMMENT '领取状态：1已领取 0其他',
  UNIQUE KEY `idx_ereward` (`playerid`,`lv`) USING BTREE,
  KEY `idx_erewardp` (`playerid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每日必做奖励统计';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fans_data`
--

DROP TABLE IF EXISTS `fans_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fans_data` (
  `playerid` bigint(20) NOT NULL COMMENT '玩家id',
  `fansIdlist` varbinary(1024) DEFAULT NULL COMMENT '玩家的好友列表',
  UNIQUE KEY `UKEY_ID` (`playerid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家好友列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fastlogin`
--

DROP TABLE IF EXISTS `fastlogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fastlogin` (
  `devime` char(64) DEFAULT NULL COMMENT '唯一设备号',
  `userid` bigint(8) DEFAULT '0' COMMENT 'userid',
  KEY `devime` (`devime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户快速登录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fight_rank`
--

DROP TABLE IF EXISTS `fight_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fight_rank` (
  `rank` int(11) NOT NULL AUTO_INCREMENT COMMENT '排名',
  `playerid` bigint(20) NOT NULL COMMENT '玩家ID',
  `name` char(32) DEFAULT '' COMMENT '玩家名字',
  `level` int(11) DEFAULT '0' COMMENT '玩家等级',
  `career` int(11) DEFAULT '0' COMMENT '玩家职业',
  `fightingCapacity` int(11) DEFAULT '0' COMMENT '玩家战斗力',
  `leagueId` bigint(20) NOT NULL DEFAULT '0' COMMENT '玩家公会id',
  `totaltreasure` bigint(20) DEFAULT '0',
  `leaguename` char(32) DEFAULT '' COMMENT '玩家公会名字',
  UNIQUE KEY `UKEY_ID` (`rank`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='玩家战力排行表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flower`
--

DROP TABLE IF EXISTS `flower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flower` (
  `playerId` bigint(20) NOT NULL COMMENT '玩家ID',
  `value` int(11) DEFAULT '0' COMMENT '魅力值',
  PRIMARY KEY (`playerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='鲜花魅力值表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_code`
--

DROP TABLE IF EXISTS `gift_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gift_code` (
  `code` char(32) NOT NULL DEFAULT '' COMMENT '激活码',
  `platform` char(32) DEFAULT '' COMMENT '平台ID',
  `system` int(11) DEFAULT '0' COMMENT '激活码ID',
  `systemName` char(32) DEFAULT '' COMMENT '激活码礼包名字',
  `user_id` bigint(20) DEFAULT '0' COMMENT '领取激活码的账号ID',
  UNIQUE KEY `UKEY_ID` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='激活码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gm_cmd`
--

DROP TABLE IF EXISTS `gm_cmd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gm_cmd` (
  `type` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'GM命令类型',
  `bitId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '位ID',
  `playerId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `msg` char(64) DEFAULT '' COMMENT 'GM消息',
  `level_min` int(11) NOT NULL DEFAULT '0' COMMENT '最小等级',
  `level_max` int(11) NOT NULL DEFAULT '0' COMMENT '最大等级',
  `expirationdate` int(4) DEFAULT NULL COMMENT '过期时间',
  KEY `type` (`type`) USING BTREE,
  KEY `bitId` (`bitId`) USING BTREE,
  KEY `playerId` (`playerId`) USING BTREE,
  KEY `expirationdate` (`expirationdate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台gm命令表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `internal_pay`
--

DROP TABLE IF EXISTS `internal_pay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `internal_pay` (
  `userId` bigint(20) NOT NULL COMMENT '内测充值的玩家， 双倍返利',
  `money` int(11) DEFAULT NULL,
  `flag` smallint(6) DEFAULT '0',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kill_rank`
--

DROP TABLE IF EXISTS `kill_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kill_rank` (
  `rank` int(11) NOT NULL AUTO_INCREMENT COMMENT '排名',
  `playerid` bigint(20) NOT NULL COMMENT '玩家ID',
  `name` char(32) DEFAULT '' COMMENT '玩家名字',
  `level` int(11) DEFAULT '0' COMMENT '战绩',
  `career` int(11) DEFAULT '0' COMMENT '职业',
  `fightingCapacity` int(11) DEFAULT '0' COMMENT '战斗力',
  `totaltreasure` int(11) DEFAULT '0' COMMENT '总的充值元宝数',
  `leaguename` char(32) DEFAULT '' COMMENT '帮会名字',
  UNIQUE KEY `UKEY_ID` (`rank`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='战绩排名';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `league_battle`
--

DROP TABLE IF EXISTS `league_battle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `league_battle` (
  `league_battle_id` int(11) NOT NULL DEFAULT '0' COMMENT '行会站地图id',
  `level` int(11) DEFAULT '0' COMMENT '帮会战地图等级',
  `defending_id` bigint(20) DEFAULT '0' COMMENT '行会站占领方帮会id',
  `offending_id` bigint(20) DEFAULT '0' COMMENT '行会站进攻方id',
  `map_data_id` int(11) DEFAULT '0' COMMENT '行会战使用哪张地图战斗',
  `state` int(11) DEFAULT '0' COMMENT '当前行会站状态',
  `map_id` bigint(20) DEFAULT '0' COMMENT '当前行会站地图实例id',
  `league_bid` varbinary(256) DEFAULT NULL COMMENT '行会竞标资金列表',
  `fief` bigint(20) DEFAULT '0' COMMENT '0表示未封地， 封地后表示获得封地权限的帮会id',
  PRIMARY KEY (`league_battle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行会战数据库';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `league_boss_info`
--

DROP TABLE IF EXISTS `league_boss_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `league_boss_info` (
  `league_id` bigint(20) NOT NULL,
  `league_boss_level` int(11) DEFAULT NULL,
  `exp` bigint(20) DEFAULT NULL,
  `inspire_level` int(11) DEFAULT NULL,
  `pill` int(11) DEFAULT NULL,
  `free_league_inspire_times` int(11) DEFAULT NULL,
  `inspired` int(11) DEFAULT NULL,
  `expire_milli_seconds_timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`league_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `league_data`
--

DROP TABLE IF EXISTS `league_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `league_data` (
  `leagueId` bigint(20) NOT NULL COMMENT '帮会id',
  `name` char(32) DEFAULT '' COMMENT '帮会名字',
  `level` int(11) DEFAULT '0' COMMENT '帮会等级',
  `fightingCapacity` int(11) DEFAULT '0' COMMENT '帮会战斗力',
  `curCount` int(11) DEFAULT '0' COMMENT '帮会当前人数',
  `maxCount` int(11) DEFAULT '0' COMMENT '帮会最大人数',
  `memberlist` varbinary(4096) DEFAULT NULL COMMENT '帮会成员列表',
  `duplicateId` int(11) DEFAULT '0' COMMENT '没有用',
  `announcement` char(120) DEFAULT '' COMMENT '帮会声明',
  `manifesto` varchar(120) DEFAULT '""' COMMENT '帮会宣言。',
  `enteredCopyMapNum` int(4) DEFAULT '0' COMMENT '公会副本开启次数',
  `createtime` int(4) DEFAULT '0' COMMENT '创建时间',
  `renameTime` int(4) DEFAULT '100' COMMENT '改名次数',
  `score` int(11) DEFAULT '0' COMMENT '帮会积分',
  `exp` int(11) DEFAULT '0' COMMENT '行会经验',
  `fund` int(11) DEFAULT '0' COMMENT '行会资金',
  `rank` int(11) DEFAULT NULL COMMENT '帮会排名',
  `escortTimes` int(11) DEFAULT '1' COMMENT '帮会美女护送次数， 默认为1次。',
  `escortState` bigint(20) DEFAULT '0' COMMENT '护送美女的状态， 0表示没有在护送， 否则表示护送的monster id',
  `robTimes` int(11) DEFAULT '3' COMMENT '每天的打劫次数， 护送美女',
  `robbingList` varbinary(256) DEFAULT NULL COMMENT '正在打劫的其他帮会的id列表',
  `robbedList` varbinary(256) DEFAULT NULL COMMENT '正在打劫我的帮会id列表。',
  PRIMARY KEY (`leagueId`),
  UNIQUE KEY `UKEY_ID` (`leagueId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮会信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `league_pk_state`
--

DROP TABLE IF EXISTS `league_pk_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `league_pk_state` (
  `leagueId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '帮会id',
  `pkLeagueId` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '敌对帮会id',
  `relation` varchar(45) DEFAULT '0',
  `leftTime` int(4) unsigned DEFAULT '0' COMMENT '帮会pk剩余时间',
  KEY `leagueId` (`leagueId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮会战表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `league_rank`
--

DROP TABLE IF EXISTS `league_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `league_rank` (
  `rank` int(11) NOT NULL AUTO_INCREMENT COMMENT '排名',
  `leagueid` bigint(20) NOT NULL COMMENT '帮会ID',
  `name` char(32) DEFAULT '' COMMENT '帮会名字',
  `level` int(11) DEFAULT '0' COMMENT '帮会等级',
  UNIQUE KEY `UKEY_ID` (`rank`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮会排名';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `level_rank`
--

DROP TABLE IF EXISTS `level_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `level_rank` (
  `rank` int(11) NOT NULL AUTO_INCREMENT COMMENT '排名',
  `playerid` bigint(20) NOT NULL COMMENT '玩家ID',
  `name` char(32) DEFAULT '' COMMENT '玩家名字',
  `level` int(11) DEFAULT '0' COMMENT '等级',
  `career` int(11) DEFAULT '0' COMMENT '职业',
  `fightingCapacity` int(11) DEFAULT '0' COMMENT '战斗力',
  `totaltreasure` bigint(20) DEFAULT '0',
  `leaguename` char(32) DEFAULT '' COMMENT '帮会名字',
  UNIQUE KEY `UKEY_ID` (`rank`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='等级排名';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail_table`
--

DROP TABLE IF EXISTS `mail_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_table` (
  `mailId` bigint(20) NOT NULL DEFAULT '0' COMMENT '邮件ID',
  `mailReceivePlayerId` bigint(20) NOT NULL DEFAULT '0' COMMENT '接收邮件的玩家ID',
  `mailTitle` char(64) DEFAULT '' COMMENT '邮件标题',
  `mailType` int(4) DEFAULT '0' COMMENT '邮件类型',
  `mailContent` char(255) DEFAULT '' COMMENT '邮件正文内容',
  `mailSendName` char(32) DEFAULT '' COMMENT '邮件发送者名字',
  `mailItemIdList` varbinary(1024) DEFAULT NULL COMMENT '邮件附件的道具列表',
  `mailReadState` int(11) DEFAULT '0' COMMENT '邮件读取状态',
  `mailSendtime` int(4) DEFAULT '0' COMMENT '邮件发送时间',
  `mailCoin` int(4) DEFAULT '0' COMMENT '邮件附件中非绑定金币数量',
  `mailBindCoin` int(4) DEFAULT '0' COMMENT '邮件附件中绑定金币数量',
  `mailGold` int(4) DEFAULT '0' COMMENT '邮件附件中非绑定元宝数量',
  `mailBindGold` int(4) DEFAULT '0' COMMENT '邮件附件中绑定元宝数量',
  UNIQUE KEY `UKEY_ID` (`mailId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮件列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manorbattle`
--

DROP TABLE IF EXISTS `manorbattle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manorbattle` (
  `mapdataID` int(10) NOT NULL DEFAULT '0' COMMENT '领地ID',
  `owerGuildID` bigint(20) DEFAULT '0' COMMENT '所有者公会ID',
  `ownerGuildName` char(32) DEFAULT NULL COMMENT '所有者公会名称',
  `attackGuildID` bigint(20) DEFAULT '0' COMMENT '攻打者公会ID',
  `attackGold` int(10) DEFAULT '0' COMMENT '攻打资格花费元宝',
  `attackPlayer` bigint(20) DEFAULT '0' COMMENT '报名的玩家ID',
  `moneyToGain` int(10) DEFAULT '0' COMMENT '等着打完再分的元宝',
  `attackGuildName` char(32) DEFAULT NULL COMMENT '攻打公会名称',
  PRIMARY KEY (`mapdataID`),
  KEY `owerGuildID` (`owerGuildID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='领地战表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pay_related_gold`
--

DROP TABLE IF EXISTS `pay_related_gold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_related_gold` (
  `playerid` bigint(20) NOT NULL COMMENT '玩家ID',
  `type` int(4) DEFAULT '0' COMMENT '类型',
  `pdate` int(11) NOT NULL COMMENT '日期',
  `gold` int(11) NOT NULL COMMENT '充值金额',
  UNIQUE KEY `tpay_idx` (`playerid`,`pdate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日充累充金额表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pay_related_info`
--

DROP TABLE IF EXISTS `pay_related_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_related_info` (
  `playerid` bigint(20) NOT NULL COMMENT '玩家ID',
  `type` smallint(5) NOT NULL COMMENT '充值类型 1单笔 2单日 3累计',
  `lv` smallint(5) NOT NULL COMMENT '充值等级',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '奖励数量',
  `flag` smallint(5) NOT NULL COMMENT '奖励是否获取标志（0未获取，1获取了）',
  UNIQUE KEY `pay_idx` (`playerid`,`type`,`lv`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日充累充奖励表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_attachinfo`
--

DROP TABLE IF EXISTS `player_attachinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_attachinfo` (
  `playerId` bigint(8) DEFAULT NULL COMMENT '玩家ID',
  `liveNessValue` int(4) DEFAULT '0' COMMENT '玩家活跃度',
  `liveNessList` varbinary(1024) DEFAULT NULL COMMENT '一天的活跃度完成情况',
  `drewLnAwardList` varbinary(1024) DEFAULT NULL COMMENT '已经领取过的活跃度奖励',
  UNIQUE KEY `playerId` (`playerId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家额外属性';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_gamedata`
--

DROP TABLE IF EXISTS `player_gamedata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_gamedata` (
  `id` bigint(20) NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `userId` bigint(20) DEFAULT '0' COMMENT '玩家账号ID',
  `name` char(32) DEFAULT '' COMMENT '玩家名字',
  `career` int(11) DEFAULT '0' COMMENT '职业',
  `sex` int(11) DEFAULT '0' COMMENT '性别',
  `level` int(11) DEFAULT '0' COMMENT '等级',
  `mapDataId` int(11) DEFAULT '0' COMMENT '玩家所在地图配置ID',
  `mapId` bigint(20) DEFAULT '0' COMMENT '玩家所在地图实例ID',
  `X` int(11) DEFAULT '0' COMMENT '玩家地图X坐标',
  `Y` int(11) DEFAULT '0' COMMENT '玩家地图Y坐标',
  `equipDataArray` varbinary(1024) DEFAULT NULL COMMENT '装备二进制数据',
  `enchaseDataArray` varbinary(1024) DEFAULT NULL COMMENT '镶嵌二进制数据',
  `bagGridNum` smallint(6) DEFAULT '0' COMMENT '背包空余格子数',
  `bagDataArray` varbinary(2048) DEFAULT NULL COMMENT '背包二进制数据',
  `warehouseArray` varbinary(2048) DEFAULT NULL COMMENT '仓库二进制数据',
  `minehouseArray` varbinary(2048) DEFAULT NULL COMMENT '挖矿二进制数据',
  `varArray` varbinary(4096) DEFAULT NULL,
  `shortcutList` varbinary(128) DEFAULT NULL COMMENT '玩家自定义快捷键',
  `acceptTaskList` varbinary(512) DEFAULT NULL COMMENT '玩家接受的任务列表',
  `repeatCompletedTaskList` varbinary(1024) DEFAULT NULL COMMENT '重复完成的任务列表',
  `singleCompletedTaskList` varbinary(2048) DEFAULT NULL COMMENT '单次完成的任务列表',
  `skillList` varbinary(1024) DEFAULT NULL COMMENT '玩家技能表',
  `passitiveSkillIdList` varbinary(128) DEFAULT NULL COMMENT '玩家被动技能表',
  `pet` varbinary(128) DEFAULT NULL COMMENT '玩家宠物',
  `bufferList` varbinary(1024) DEFAULT NULL COMMENT '玩家buff列表',
  `friendIdList` varbinary(1024) DEFAULT NULL COMMENT '玩家好友id列表',
  `hp` int(11) DEFAULT '0' COMMENT '玩家生命值',
  `mp` int(11) DEFAULT '0' COMMENT '玩家魔法蓝值',
  `exp` int(11) DEFAULT '0' COMMENT '玩家经验值',
  `coin` int(11) DEFAULT '0' COMMENT '非绑定金币',
  `bindCoin` int(11) DEFAULT '0' COMMENT '绑定金币',
  `treasure` int(11) DEFAULT '0' COMMENT '非绑定元宝',
  `bindTreasure` int(11) DEFAULT '0' COMMENT '绑定元宝',
  `totaltreasure` bigint(20) DEFAULT '0' COMMENT '总共充值元宝总数',
  `pk` int(11) DEFAULT '0' COMMENT '玩家PK值',
  `pkState` int(11) DEFAULT '0' COMMENT '玩家pk状态',
  `reputation` int(11) DEFAULT '0' COMMENT '声誉值',
  `spirit` int(11) DEFAULT '0' COMMENT '体力值',
  `holy` int(11) DEFAULT '0' COMMENT '纯洁值',
  `cdUseItem` varbinary(1024) DEFAULT NULL COMMENT '道具CD列表',
  `fightingCapacity` int(11) DEFAULT '0' COMMENT '战斗力',
  `teamSet` tinyint(4) DEFAULT '0' COMMENT '玩家组队设置',
  `copyCDInfoList` varbinary(1024) DEFAULT NULL COMMENT '副本CD列表',
  `activedHighCopyList` varbinary(128) DEFAULT NULL COMMENT '激活的精英副本列表',
  `nextResetTimePerday` int(11) unsigned DEFAULT '0' COMMENT '下1次0点激活时间戳',
  `isDelete` tinyint(4) DEFAULT '0' COMMENT '是否是已经删除了玩家账号',
  `richerTimes` tinyint(4) DEFAULT '0' COMMENT '摇钱树次数',
  `registerTime` bigint(20) DEFAULT '0' COMMENT '注册时间',
  `wheelTimes` tinyint(4) DEFAULT '0' COMMENT '翻轮盘时间',
  `vipEveryDay` tinyint(4) DEFAULT '0' COMMENT '每日VIP',
  `createTime` int(11) DEFAULT '0' COMMENT '角色创建时间',
  `lastOnlineTime` int(11) DEFAULT '0' COMMENT '最后在线时间',
  `lastOfflineTime` int(11) DEFAULT '0' COMMENT '最后下线时间',
  `loginIp` char(15) DEFAULT '' COMMENT '登陆IP',
  `isOnline` tinyint(4) DEFAULT '0' COMMENT '玩家是否在线',
  `leagueId` bigint(20) NOT NULL DEFAULT '0' COMMENT '玩家帮会ID',
  `applyleagueTimes` tinyint(4) NOT NULL DEFAULT '0' COMMENT '申请加入帮会次数，每天最多申请6次',
  `platSendItemBits` varbinary(1024) DEFAULT NULL COMMENT '是否领取过gm发送的物品',
  `forbidChatFlag` tinyint(4) DEFAULT '0' COMMENT '是否禁止聊天',
  `forbidChatEndTime` int(4) DEFAULT '0' COMMENT '禁止聊天结束时间',
  `gmFlag` tinyint(4) DEFAULT '0' COMMENT 'GM标志， 是否是GM玩家',
  `platformID` int(10) DEFAULT NULL COMMENT '平台ID',
  `channelId` int(11) DEFAULT '0' COMMENT '渠道ID',
  `shaChengGetAwardFlag` int(4) DEFAULT '0' COMMENT '沙城奖励是否已领取',
  `huangChengGetAwardFlag` int(4) DEFAULT '0' COMMENT '皇城奖励是否已领取',
  `renameTime` int(11) DEFAULT '100' COMMENT '重命名次数',
  `changePetId` int(4) DEFAULT '0' COMMENT '宠物幻化id',
  `activeIdList` varbinary(128) DEFAULT NULL COMMENT '活动id列表',
  `orderid` varchar(55) DEFAULT NULL COMMENT '最后一次充值订单id',
  `serverid` int(11) unsigned DEFAULT '1' COMMENT '玩家所在服务器id',
  `paytreasure` int(11) unsigned DEFAULT '0' COMMENT '玩家充值的元宝数量',
  `lastUpgradeTime` int(11) DEFAULT '0' COMMENT '最后一次升级时间',
  `lastUpgradeCostTime` int(11) DEFAULT '0' COMMENT '最后一次升级所花费的时间',
  `invitePlayer` bigint(20) unsigned DEFAULT '0' COMMENT '邀请自己进入游戏的玩家id',
  `inviteList` varbinary(256) DEFAULT NULL COMMENT '邀请到的玩家列表',
  `nextKillTime` int(11) DEFAULT '0' COMMENT '下一次击杀该玩家能获得战绩值的时间',
  `killScore` int(11) DEFAULT '0' COMMENT '战绩值',
  `limitbuytime` int(4) DEFAULT '0' COMMENT '限时时间',
  `limitbuydata` varbinary(512) DEFAULT NULL COMMENT '限时购买数据',
  `achievement` varbinary(512) DEFAULT NULL COMMENT '成就',
  `attrMax` varbinary(256) DEFAULT NULL COMMENT '玩家属性达到过的最大值',
  UNIQUE KEY `UKEY_ID` (`id`) USING BTREE,
  KEY `KEY_USERID` (`userId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `saletrade_info`
--

DROP TABLE IF EXISTS `saletrade_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saletrade_info` (
  `id` bigint(20) unsigned NOT NULL COMMENT '物品全服唯一ID',
  `item_data_id` int(11) NOT NULL COMMENT '物品ID',
  `flag` int(4) NOT NULL COMMENT '一些标志',
  `stars` int(4) NOT NULL COMMENT '强化(即升星)',
  `promoteLevel` int(4) DEFAULT NULL COMMENT 'װȼ',
  `equipRandAttrArray` varbinary(1024) NOT NULL COMMENT '装备的随机属性（list）',
  `fujiaRandAttrArray` varbinary(1024) NOT NULL COMMENT '附加的随机属性(list)',
  `itemArrayForSpaceRing` int(4) NOT NULL COMMENT '0',
  `luck` int(11) NOT NULL COMMENT '幸运值',
  `curse` int(11) NOT NULL COMMENT '%%诅咒(只有武器才有，杀人时增加)',
  `crit` int(11) NOT NULL COMMENT '%%致命一击(装备生成的时候，随机一个值，后续洗练',
  `insuranceTimes` int(4) NOT NULL COMMENT '投保次数',
  `expiretime` int(4) NOT NULL COMMENT '过期时间',
  `processValue` int(4) NOT NULL COMMENT '进度值',
  `ownerid` bigint(20) NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `ownername` char(32) DEFAULT '' COMMENT '玩家名字',
  `item_level` int(4) NOT NULL COMMENT '道具等级',
  `sale_price` int(4) NOT NULL COMMENT '价格',
  `sale_count` int(4) NOT NULL COMMENT '进度值',
  `groundingTime` int(4) NOT NULL COMMENT '上架时间',
  `timeType` int(4) NOT NULL COMMENT '时间类型',
  `saleType` int(4) NOT NULL COMMENT '物品类型',
  `lockTime` int(4) NOT NULL COMMENT '锁定时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拍卖行物品信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seven_star_info`
--

DROP TABLE IF EXISTS `seven_star_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seven_star_info` (
  `playerid` bigint(20) NOT NULL COMMENT '玩家ID',
  `type` int(11) NOT NULL COMMENT '北斗七星ID',
  `lv` int(11) NOT NULL DEFAULT '0' COMMENT '北斗七星等级',
  UNIQUE KEY `ss_idx` (`playerid`,`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='北斗七星星座';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seven_star_total`
--

DROP TABLE IF EXISTS `seven_star_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seven_star_total` (
  `playerid` bigint(20) NOT NULL COMMENT '玩家ID',
  `reiki` int(11) NOT NULL DEFAULT '0' COMMENT '灵气',
  `goldtimes` int(11) NOT NULL DEFAULT '0' COMMENT '元宝充灵次数',
  `cointimes` int(11) NOT NULL DEFAULT '0' COMMENT '金币充灵次数',
  PRIMARY KEY (`playerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='北斗七星总计';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shop_pack`
--

DROP TABLE IF EXISTS `shop_pack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_pack` (
  `playerid` bigint(20) NOT NULL COMMENT '玩家ID',
  `type` smallint(5) NOT NULL COMMENT '类型：1礼包限购 2元宝兑换 3道具兑换',
  `key` int(10) NOT NULL,
  `value` int(10) NOT NULL,
  UNIQUE KEY `idx_shop` (`playerid`,`type`,`key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商城表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `valentine`
--

DROP TABLE IF EXISTS `valentine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valentine` (
  `playerid` bigint(20) NOT NULL COMMENT '玩家ID',
  `status` smallint(5) NOT NULL DEFAULT '1' COMMENT '领取奖励状态：1未领取 2可领取 3已领取',
  PRIMARY KEY (`playerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='巧果领取统计';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `worldvar`
--

DROP TABLE IF EXISTS `worldvar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `worldvar` (
  `varId` bigint(20) NOT NULL DEFAULT '0' COMMENT '世界变量ID',
  `worldvar` varbinary(2048) DEFAULT NULL COMMENT '世界变量值',
  UNIQUE KEY `UKEY_ID` (`varId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='世界变量表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yesterday_arena`
--

DROP TABLE IF EXISTS `yesterday_arena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yesterday_arena` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '竞技场排名',
  `playerid` bigint(20) NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `points` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='昨日arena排名';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zhaocai`
--

DROP TABLE IF EXISTS `zhaocai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zhaocai` (
  `id` int(11) DEFAULT '0' COMMENT 'ID',
  `beginTime` int(11) DEFAULT '0' COMMENT '开始时间',
  `endTime` int(11) DEFAULT '0' COMMENT '结束时间',
  `content` varbinary(1024) DEFAULT NULL COMMENT '配置信息',
  UNIQUE KEY `playerId` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招财宝信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zhaocai_player`
--

DROP TABLE IF EXISTS `zhaocai_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zhaocai_player` (
  `playerId` bigint(8) DEFAULT NULL COMMENT '玩家ID',
  `buyList` varbinary(256) DEFAULT NULL COMMENT '购买列表',
  `awardList` varbinary(256) DEFAULT NULL COMMENT '奖励列表',
  `num` int(11) DEFAULT '0' COMMENT '购买数量',
  UNIQUE KEY `playerId` (`playerId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='招财宝玩家信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `dragongamelog2001`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dragongamelog2001` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `dragongamelog2001`;

--
-- Table structure for table `cost_log`
--

DROP TABLE IF EXISTS `cost_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cost_log` (
  `gyyx_lf` varchar(64) NOT NULL COMMENT '生命指纹',
  `dist_id` int(11) NOT NULL COMMENT '区服ID',
  `account_id` varchar(30) NOT NULL COMMENT '账号ID',
  `role_id` varchar(30) NOT NULL COMMENT '角色ID',
  `role_lv` int(11) NOT NULL COMMENT '角色级别',
  `cost_type` varchar(30) NOT NULL COMMENT '消费类型(中文)',
  `cost_name` varchar(100) NOT NULL COMMENT '消费名称(中文)',
  `money` int(11) NOT NULL COMMENT '消费金额',
  `create_time` datetime NOT NULL COMMENT '日志时间',
  KEY `index_time` (`create_time`) USING BTREE,
  KEY `cost_type` (`cost_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏消费表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `credit_log`
--

DROP TABLE IF EXISTS `credit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_log` (
  `gyyx_lf` varchar(64) NOT NULL COMMENT '生命指纹',
  `dist_id` int(11) NOT NULL COMMENT '区服ID',
  `account_id` varchar(30) NOT NULL COMMENT '账号ID',
  `role_id` varchar(30) NOT NULL COMMENT '角色ID',
  `role_lv` int(11) NOT NULL COMMENT '角色等级',
  `money` int(11) NOT NULL COMMENT '人民币',
  `order_no` varchar(100) NOT NULL COMMENT '订单号',
  `create_time` datetime NOT NULL COMMENT '日志时间(订单成功时间)',
  KEY `index_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enter_dist_log`
--

DROP TABLE IF EXISTS `enter_dist_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enter_dist_log` (
  `gyyx_lf` varchar(64) NOT NULL COMMENT '生命指纹',
  `dist_id` int(11) NOT NULL COMMENT '区服ID',
  `account_id` varchar(30) NOT NULL COMMENT '账号ID',
  `login_type` int(11) NOT NULL COMMENT '状态(1:登录, 0:登出)',
  `online_sec` int(11) NOT NULL COMMENT '在线时长',
  `create_time` datetime NOT NULL COMMENT '日志时间',
  KEY `index_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='区服(登录/登出)表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enter_scene_log`
--

DROP TABLE IF EXISTS `enter_scene_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enter_scene_log` (
  `gyyx_lf` varchar(64) NOT NULL COMMENT '生命指纹',
  `dist_id` int(11) NOT NULL COMMENT '区服ID',
  `account_id` varchar(30) NOT NULL COMMENT '账号ID',
  `role_id` varchar(30) NOT NULL COMMENT '角色ID',
  `role_lv` int(11) NOT NULL COMMENT '角色等级',
  `login_type` int(11) NOT NULL COMMENT '状态(1:登录, 0:登出)',
  `online_sec` int(11) NOT NULL COMMENT '在线时长',
  `create_time` datetime NOT NULL COMMENT '日志时间',
  KEY `index_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主场景(登录/登出)表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `level_log`
--

DROP TABLE IF EXISTS `level_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `level_log` (
  `gyyx_lf` varchar(64) NOT NULL COMMENT '生命指纹',
  `dist_id` int(11) NOT NULL COMMENT '区服ID',
  `account_id` varchar(30) NOT NULL COMMENT '账号ID',
  `role_id` varchar(30) NOT NULL COMMENT '角色ID',
  `role_lv` int(11) NOT NULL COMMENT '角色等级',
  `create_time` datetime NOT NULL COMMENT '日志时间',
  KEY `index_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色升级表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_bag_change`
--

DROP TABLE IF EXISTS `log_bag_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_bag_change` (
  `userid` bigint(8) DEFAULT NULL COMMENT '账号ID',
  `playerid` bigint(8) DEFAULT NULL COMMENT '角色ID',
  `itemdataid` int(4) DEFAULT NULL COMMENT '物品ID',
  `itemid` bigint(8) DEFAULT NULL COMMENT '物品唯一ID',
  `count` int(4) DEFAULT NULL COMMENT '改变数量',
  `bagGridNum` smallint(4) DEFAULT NULL COMMENT '背包数量',
  `bagDataArray` varbinary(24) DEFAULT NULL COMMENT '背包数据',
  `changetype` bigint(20) DEFAULT NULL COMMENT '事件type',
  `content` varchar(255) DEFAULT NULL COMMENT '事件说明',
  `time` int(4) DEFAULT NULL COMMENT '存表时间戳',
  KEY `lbc` (`changetype`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='物品变化日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_copymap_event`
--

DROP TABLE IF EXISTS `log_copymap_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_copymap_event` (
  `userid` bigint(8) DEFAULT NULL COMMENT '账号ID',
  `playerid` bigint(8) DEFAULT NULL COMMENT '角色ID',
  `mapdataid` bigint(8) DEFAULT NULL COMMENT '副本地图的id',
  `eventtype` int(4) DEFAULT NULL COMMENT '事件type',
  `param` int(8) DEFAULT NULL COMMENT '杀怪数量或bossid',
  `time` int(4) DEFAULT NULL COMMENT '存表时间戳'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='副本地图事件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_exp_change`
--

DROP TABLE IF EXISTS `log_exp_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_exp_change` (
  `userid` bigint(8) DEFAULT NULL COMMENT '账号ID',
  `playerid` bigint(8) DEFAULT NULL COMMENT '角色ID',
  `level` int(11) DEFAULT NULL,
  `exp` int(11) DEFAULT NULL,
  `changeCount` int(11) DEFAULT NULL,
  `changetype` int(4) DEFAULT NULL COMMENT '事件type',
  `param` int(8) DEFAULT NULL COMMENT '杀怪数量或bossid',
  `content` varchar(255) DEFAULT NULL COMMENT '事件说明',
  `upgradeCostTime` int(4) DEFAULT NULL COMMENT '升级所花时间',
  `time` int(4) DEFAULT NULL COMMENT '存表时间戳'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家经验变化日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_gift_code`
--

DROP TABLE IF EXISTS `log_gift_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_gift_code` (
  `playerid` bigint(8) DEFAULT NULL COMMENT '角色ID',
  `code` char(32) NOT NULL DEFAULT '' COMMENT '领奖码',
  `time` int(4) DEFAULT NULL COMMENT '时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='领取兑换码礼包表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_huangchengzhengba`
--

DROP TABLE IF EXISTS `log_huangchengzhengba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_huangchengzhengba` (
  `leaguename` char(64) DEFAULT '' COMMENT '公会名字',
  `flag` int(4) DEFAULT '0' COMMENT '标志',
  `time` int(11) DEFAULT NULL COMMENT '存表时间戳'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='皇城争霸日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_money_change`
--

DROP TABLE IF EXISTS `log_money_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_money_change` (
  `userid` bigint(8) DEFAULT NULL COMMENT '账号ID',
  `playerid` bigint(8) DEFAULT NULL COMMENT '角色ID',
  `coin` int(4) DEFAULT NULL COMMENT '金币',
  `bindCoin` int(4) DEFAULT NULL COMMENT '绑定金币',
  `treasure` int(4) DEFAULT NULL COMMENT '元宝',
  `bindTreasure` int(4) DEFAULT NULL COMMENT '绑定元宝',
  `moneytype` int(4) DEFAULT NULL COMMENT '金钱类型',
  `changeCount` int(4) DEFAULT NULL COMMENT '改变数量',
  `changetype` int(4) DEFAULT NULL COMMENT '事件类型',
  `content` varchar(255) DEFAULT NULL COMMENT '事件说明',
  `time` int(4) DEFAULT NULL COMMENT '存表时间戳'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家金钱变化日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_online_record`
--

DROP TABLE IF EXISTS `log_online_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_online_record` (
  `time` int(4) DEFAULT NULL COMMENT '存表时间戳',
  `count` int(4) DEFAULT NULL COMMENT '在线人数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家在线表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_pay_record`
--

DROP TABLE IF EXISTS `log_pay_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_pay_record` (
  `userid` bigint(8) DEFAULT NULL COMMENT '账号ID',
  `playerid` bigint(8) DEFAULT NULL COMMENT '角色ID',
  `level` int(4) DEFAULT '0' COMMENT '等级',
  `orderId` varchar(55) DEFAULT NULL COMMENT '订单ID',
  `platformId` int(4) DEFAULT NULL COMMENT '平台ID',
  `accountId` varchar(55) DEFAULT NULL COMMENT '玩家平台账号',
  `payWay` varchar(55) DEFAULT NULL COMMENT '充值方式',
  `count` bigint(8) DEFAULT NULL COMMENT '充值数量',
  `treasure` int(4) DEFAULT '0' COMMENT '获得的元宝数',
  `flag` int(4) DEFAULT NULL COMMENT '成功1失败0',
  `time` int(4) DEFAULT NULL COMMENT '存表时间戳'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家充值日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_player_kick`
--

DROP TABLE IF EXISTS `log_player_kick`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_player_kick` (
  `playerid` bigint(8) NOT NULL COMMENT '角色ID',
  `reason` tinyint(4) NOT NULL COMMENT '原因',
  `time` int(4) NOT NULL COMMENT '时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='踢玩家下线日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_player_level_fight`
--

DROP TABLE IF EXISTS `log_player_level_fight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_player_level_fight` (
  `userid` bigint(20) NOT NULL DEFAULT '0' COMMENT '账号ID',
  `playerid` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `level` int(11) DEFAULT NULL COMMENT '等级',
  `fightingCapacity` int(11) DEFAULT '0' COMMENT '战斗力',
  `time` int(11) DEFAULT NULL COMMENT '存表时间戳',
  KEY `UKEY_ID` (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='24点记录玩家等级，战力表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_player_login`
--

DROP TABLE IF EXISTS `log_player_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_player_login` (
  `userid` bigint(8) NOT NULL DEFAULT '0' COMMENT '账号ID',
  `playerid` bigint(8) DEFAULT NULL COMMENT '角色ID',
  `level` int(4) DEFAULT NULL COMMENT '等级',
  `exp` int(4) DEFAULT NULL COMMENT '经验',
  `hp` int(4) DEFAULT NULL COMMENT '血',
  `mp` int(4) DEFAULT NULL COMMENT '蓝',
  `coin` int(4) DEFAULT NULL COMMENT '金币',
  `bindCoin` int(4) DEFAULT NULL COMMENT '绑定金币',
  `treasure` int(4) DEFAULT NULL COMMENT '元宝',
  `bindTreasure` int(4) DEFAULT NULL COMMENT '绑定元宝',
  `equipDataArray` varbinary(24) DEFAULT NULL COMMENT '装备',
  `enchaseDataArray` varbinary(24) DEFAULT NULL COMMENT '镶嵌',
  `bagGridNum` smallint(4) DEFAULT NULL COMMENT '背包数量',
  `bagDataArray` varbinary(24) DEFAULT NULL COMMENT '背包数据',
  `warehouseArray` varbinary(24) DEFAULT NULL COMMENT '仓库数据',
  `reputation` int(4) DEFAULT NULL COMMENT '声望值',
  `spirit` int(4) DEFAULT NULL COMMENT '元气值',
  `holy` int(4) DEFAULT NULL COMMENT '神圣值',
  `fightingCapacity` int(4) DEFAULT NULL COMMENT '战斗力',
  `cdUseItem` varbinary(1024) DEFAULT NULL COMMENT 'cd冷却',
  `flag` int(4) DEFAULT NULL COMMENT '上下线标志',
  `onlineTime` int(4) DEFAULT '0' COMMENT '在线时长',
  `time` int(4) DEFAULT NULL COMMENT '存表时间戳'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='玩家登陆日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_player_mail`
--

DROP TABLE IF EXISTS `log_player_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_player_mail` (
  `mailId` bigint(20) NOT NULL DEFAULT '0' COMMENT '邮件id',
  `mailReceivePlayerId` bigint(20) NOT NULL DEFAULT '0' COMMENT '收件方id',
  `mailTitle` char(32) DEFAULT '' COMMENT '邮件标题',
  `mailContent` char(255) DEFAULT '' COMMENT '邮件内容',
  `mailSendName` char(32) DEFAULT '' COMMENT '发送方名字',
  `mailItemIdList` varbinary(512) DEFAULT NULL,
  `mailReadState` int(11) DEFAULT '0' COMMENT '邮件是否读取状态',
  `mailSendtime` int(4) DEFAULT '0' COMMENT '邮件发送时间',
  `mailDeletetime` int(4) DEFAULT '0' COMMENT '邮件删除时间',
  `mailCoin` int(4) DEFAULT '0' COMMENT '邮件发送的金币',
  `mailBindCoin` int(4) DEFAULT '0' COMMENT '邮件发送的绑定金币',
  `mailGold` int(4) DEFAULT '0' COMMENT '邮件发送的元宝',
  `mailBindGold` int(4) DEFAULT '0' COMMENT '邮件发送的绑定元宝',
  UNIQUE KEY `UKEY_ID` (`mailId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮件日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_player_map`
--

DROP TABLE IF EXISTS `log_player_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_player_map` (
  `userid` bigint(8) DEFAULT NULL COMMENT '账号ID',
  `playerid` bigint(8) DEFAULT NULL COMMENT '角色ID',
  `mapdataid` bigint(8) DEFAULT NULL COMMENT '地图id',
  `time` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每5分钟记录玩家所在地图表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_player_task`
--

DROP TABLE IF EXISTS `log_player_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_player_task` (
  `userid` bigint(8) NOT NULL DEFAULT '0' COMMENT '账号ID',
  `playerid` bigint(8) DEFAULT NULL COMMENT '角色ID',
  `taskid` int(4) DEFAULT NULL COMMENT '任务ID',
  `flag` int(4) DEFAULT NULL COMMENT '交接标志',
  `time` int(4) DEFAULT NULL COMMENT '存表时间戳'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_sale_item`
--

DROP TABLE IF EXISTS `log_sale_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_sale_item` (
  `playerid` bigint(20) NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `itemid` bigint(20) NOT NULL COMMENT '物品全服唯一ID',
  `item_data_id` int(11) NOT NULL COMMENT '物品ID',
  `sale_price` int(11) NOT NULL COMMENT '价格',
  `sale_count` int(11) NOT NULL COMMENT '进度值',
  `groundingtime` int(11) NOT NULL COMMENT '上架时间',
  `timeType` int(11) NOT NULL COMMENT '时间类型',
  `event` int(11) NOT NULL COMMENT '事件',
  `time` int(11) DEFAULT NULL COMMENT '存表时间戳'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `online_log`
--

DROP TABLE IF EXISTS `online_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `online_log` (
  `gyyx_lf` varchar(64) NOT NULL COMMENT '生命指纹',
  `dist_id` int(11) NOT NULL COMMENT '区服ID',
  `account_id` varchar(30) NOT NULL COMMENT '账号ID',
  `create_time` datetime NOT NULL COMMENT '日志时间',
  KEY `index_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='在线日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `play_log`
--

DROP TABLE IF EXISTS `play_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `play_log` (
  `gyyx_lf` varchar(64) NOT NULL COMMENT '生命指纹',
  `dist_id` int(11) NOT NULL COMMENT '区服ID',
  `account_id` varchar(30) NOT NULL COMMENT '账号ID',
  `role_id` varchar(30) NOT NULL COMMENT '角色ID',
  `role_lv` int(11) NOT NULL COMMENT '角色等级',
  `t_type` varchar(30) DEFAULT NULL COMMENT '玩法分类(例:副本、任务等) (中文)',
  `t_name` varchar(100) NOT NULL COMMENT '小分类及名称(中文)',
  `op_type` int(11) NOT NULL COMMENT '状态(1:进入, 2:成功, 3:失败)',
  `use_time` int(11) NOT NULL COMMENT '完成耗时(s)',
  `create_time` datetime NOT NULL COMMENT '日志时间',
  KEY `index_time` (`create_time`) USING BTREE,
  KEY `t_type` (`t_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏玩法表';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-06  9:52:52
