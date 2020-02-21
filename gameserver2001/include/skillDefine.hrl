-ifndef(skillDefine_hrl).
-define(skillDefine_hrl, 1).
-include("excelDefine.hrl").

%% 普通攻击范围
-define(Normal_Attack_Distance, 2).

%% 技能公共CD
-define(SKILL_PUBLIC_CD, 800). %% unit: msec 毫秒

%% 怪物的技能公CD
-define(MONSTER_SKILL_PUBLIC_CD, 1700). %% unit: msec 毫秒
%% 


%% 技能类型定义
-define(SKILLSORT_Damage, 1).  %% 伤害
-define(SKILLSORT_Buff, 2).  %% 加buff
-define(SKILLSORT_Move, 3).  %% 位移
-define(SKILLSORT_Summon, 4).  %% 召唤
-define(SKILLSORT_Tempt, 5).  %% 诱惑
-define(SKILLSORT_CiShaSword, 6). %% 刺杀剑法
-define(SKILLSORT_TransferSelf, 7). %% 当前地图随机传送
-define(SKILLSORT_Trap, 8). %% 陷阱 如火墙
-define(SKILLSORT_SavageCut, 9). %%野蛮突斩

-define(SKILLSORT_GainBuff, 12). %%增益buff
-define(SKILLSORT_Damage_And_Buff, 13). %% 伤害加buff

-define(SKILLSORT_Immobilize, 14). %%禁锢, 不准移动
-define(SKILLSORT_Stun, 15). %% 击晕, 不能释放技能, 也无法移动

-define(Skill_Shunyi_ID, 220).%%瞬移技能id

-define(SavageCut_Meet_None, 0).
-define(SavageCut_Meet_Block, 1).
-define(SavageCut_Meet_Ally, 2).
-define(SavageCut_Meet_Enemy, 3).


-define(PASSITIVE_SKILLSORT_Add_HitRate, 11). %%被动技能，增加命中率,万分数


%%-define(SKILLSORT_SavageSuddenCut,6). %%野蛮突斩

%% 技能消耗类型定义
-define(SKILL_COSTTYPE_NONE, 0). %%没有消耗
-define(SKILL_COSTTYPE_MP, 1).  %%消耗魔法


%% 技能伤害类型定义
-define(SKILL_DAMAGETYPE_PHY, 1).    %% 物理伤害
-define(SKILL_DAMAGETYPE_MAGIC, 2).    %% 魔法伤害
-define(SKILL_DAMAGETYPE_DOW, 3).    %% 道术伤害
-define(SKILL_DAMAGETYPE_PHY_IGNORE_DEF, 4).  %% 无视防御
-define(SKILL_DAMAGETYPE_MAGIC_IGNORE_DEF, 5).  %% 无视防御
-define(SKILL_DAMAGETYPE_DOW_IGNORE_DEF, 6).  %% 无视防御

%% 技能目标定义
-define(SKILL_TARGETTYPE_NONE, 0).      %% 不需要指定目标
-define(SKILL_TARGETTYPE_SELF, 1).      %% 对自己使用
-define(SKILL_TARGETTYPE_ROLE, 2).      %% 对目标使用
-define(SKILL_TARGETTYPE_CELL, 3).      %% 对地图上某个点使用
-define(SKILL_TARGETTYPE_SELF_OR_ROLE, 4).  %% 对自己或目标使用

%% 技能目标范围定义
-define(SKILL_RANGETYPE_ALLY, 1).      %% 单个目标，盟友
-define(SKILL_RANGETYPE_ENEMY, 2).      %% 单个目标，敌人
-define(SKILL_RANGETYPE_ARC_ALLY, 3).    %% 取弧形范围内的盟友
-define(SKILL_RANGETYPE_ARC_ENEMY, 4).    %% 取弧形范围的敌人
-define(SKILL_RANGETYPE_CIRCLE_ALLY, 5).  %% 取圆形范围的盟友
-define(SKILL_RANGETYPE_CIRCLE_ENEMY, 6).  %% 取圆形范围的敌人
-define(SKILL_RANGETYPE_LINE_ALLY, 7).    %% 取直线范围的盟友
-define(SKILL_RANGETYPE_LINE_ENEMY, 8).    %% 取直线范围的敌人

-define(SKILL_ARC_HALF_ANGLE, 60).                %%取弧形范围的目标时，使用的角度
-define(SKILL_LINE_HALF_ANGLE, 15).                %%取直线范围的目标时，使用的角度

%% BUFF类型定义
-define(BUFFTYPE_ADD_HP, 1).    %% 持续回血
-define(BUFFTYPE_ADD_MP, 2).    %% 持续回魔
-define(BUFFTYPE_DEC_HP, 3).    %% 持续减血
-define(BUFFTYPE_DEC_MP, 4).    %% 持续减魔
-define(BUFFTYPE_ADD_PHYSIC_DEF, 5).    %% 增加物防
-define(BUFFTYPE_ADD_MAGIC_DEF, 6).  %% 增加魔防
-define(BUFFTYPE_DEC_PHYSIC_DEF, 7).    %% 减少物防
-define(BUFFTYPE_DEC_MAGIC_DEF, 8).  %% 减少魔防
-define(BUFFTYPE_BENUMB, 9).    %% 麻痹
-define(BUFFTYPE_COPY, 10).          %% 副本BUFF
-define(BUFFTYPE_DEC_PHYSIC_AND_MAGIC_DEF, 11).    %% 减少物防和魔防
-define(BUFFTYPE_ADD_PHYSIC_AND_MAGIC_DEF, 12).    %% 增加物防和魔防
-define(BUFFTYPE_Hide, 13).    %% 隐身
-define(BUFFTYPE_ADD_MAGIC_SHIELD, 14).  %% 一个魔法盾覆盖在自己身上 Magic Shield,增加抵消伤害百分数 BUFFTYPE_ADD_CancelDamagePercent
-define(BUFFTYPE_PkColor_Brown, 15).  %% 褐色名字 此类型buff，只改变state_flag,不通知客户端增加或移除buff
-define(BUFFTYPE_POISON, 16).  %% 中毒后，持续减血并变成绿色
-define(BUFFTYPE_Harm, 17).  %% 增加伤害
-define(BUFFTYPE_AddPhysicalInjury, 20).  %% 增加物理伤害
-define(BUFFTYPE_AddTractInjury, 21).  %% 增加道术伤害
-define(BUFFTYPE_AddMagicInjury, 22).  %% 增加魔法伤害
-define(BUFFTYPE_AddPhysicalDefend, 23).  %% 增加物理防御
-define(BUFFTYPE_AddMagicDefend, 24).  %% 增加魔法防御
-define(BUFFTYPE_ExpScroll, 30).  %% 经验卷轴


%%叠加方式：
%%0，完全不能叠加；
%%1，只覆盖作用时间；
%%2，叠加作用时间；
%%3，叠加作用效果；
%%4，叠加作用时间和效果；
-define(BUFFACC_None, 0).    %% 无叠加
-define(BUFFACC_Recover_Time, 1).  %% 覆盖作用时间
-define(BUFFACC_Time, 2).    %% 叠加作用时间
%% -define(BUFFACC_Effect, 3).		%% 叠加作用效果
%% -define(BUFFACC_Time_Effect, 4).	%% 叠加作用时间和效果


-define(LevelUpSkill_Success, 0).  %%升级技能 成功
-define(LevelUpSkill_OldSkillNotLearn, -1).  %%老技能没学过
-define(LevelUpSkill_NewSkillLearned, -2).  %%新技能学过了
-define(LevelUpSkill_OtherError, -3).  %%其他错误


%% 技能记录信息
-record(playerSkill, {id, cdtime}). %%cdtime 在使用时，记录的是下一次能使用此技能的时间
%% BUFF记录信息
-record(playerBuffer, {id, casterid,
  extraPower = 0,%%据攻击者数据的百分比带来的power  attackpowerpercent
  times, nexttime, expiretime}).
%% 技能吟唱记录信息
-record(playerSkillLaunch, {id, targetid, launchtimer}).

-record(skillAiInfo, {skillId, cdTime, skillDist, nextSkillTime}).

%% 怪物技能cd信息
-record(monsterSkillCd, {
  skill_id,
  cd_time
}).

-endif.


