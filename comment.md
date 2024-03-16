# 动作规律

30xx xx < 50 主动攻击招式

3100 架刀防御动作
3101
3102


305x 交锋动作，从左右手弹开的位置开始

5201 小步后撤
5211 连续多步后撤

## 交锋

| 动作编号 | 特效标识      | 描述                                         |
| -------- | ------------- | -------------------------------------------- |
| 8400     | 200211        | 弹开 到左侧                                  |
| 8401     | 200210        | 弹开 到右侧                                  |
| 8402     | 200227        | 同8400，更大冲击力                           |
| 8403     | 200228        | 同8401，更大冲击力                           |
|          |               |                                              |
| 8500     | 200216 200250 | 招架 到左侧                                  |
| 8501     | 200215 200250 | 招架 到右侧                                  |
| 8502     | 200216 200250 | 同8500，更大冲击力                           |
| 8503     | 200215 200250 | 同8501，更大冲击力                           |
| 8510     | 无     200250 | 同8500，巨大冲击力，打出踉跄，无法接上交锋 |
| 8511     | 无     200250 | 同8501，巨大冲击力                         |
| 8550     | 无            | 同8500，此时崩躯干                           |
| 8551     | 无            | 同8501，此时崩躯干                           |
|          |               |                                              |
| 8600     | 200200        | 被弹开 到右侧                                |
| 8601     | 200201        | 被弹开 到左侧                                |
| 8650     | 无            | 同8600，此时崩躯干                           |
| 8651     | 无            | 同8601，此时崩躯干                           |
|          |               |                                              |
| 8700     | 200205        | 被招架 到右边                                |
| 8701     | 200206        | 被招架 到左边                                |
|          |               |                                              |


200225
200226
200229

200300
200301
200305
200306

200400
200401
200405
200406


# api

## 参数


    self:SetStringIndexedNumber("Dist_Step_Small", 2)
    self:SetStringIndexedNumber("Dist_Step_Large", 4)
    self:SetStringIndexedNumber("KengekiID", 0)
    self:SetStringIndexedNumber("KaihukuSp", 30)


## 计时器

arg1:IsFinishTimer(0)
0 号计时器是否已经计时结束
计时结束就保持在 0

arg0:SetTimer(0, 10)
将 0 号计时器置为 10s 并开始倒计时

arg1:GetAttackPassedTime(3020)
获取某个动作自上次执行，过了多少s

## 计数器

SetNumber(22, 1)
计数器22 设置为1，招式有计数忍耐度

## 空间检测

arg0:GetMapHitRadius(TARGET_SELF)

取得自身胶囊碰撞体的半径，单位 m
在进行与玩家的距离判断时，将其减去

arg0:GetDist(TARGET_ENE_0)

取得到玩家的距离

arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF
TARGET_ENE_0

自己的目标焦点是谁
如果是self，则说明对玩家没有仇恨
主要仇恨对象，一般是玩家，也可能是其它npc


arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90)
- target
- direction
- degree

目标是否在范围内

正前左右 45 度组成 90 度扇形，进行检测

AI_DIR_TYPE_F = 1
AI_DIR_TYPE_B = 2
AI_DIR_TYPE_L = 3
AI_DIR_TYPE_R = 4

AI_DIR_TYPE_ToF = 5
AI_DIR_TYPE_ToB = 6
AI_DIR_TYPE_ToL = 7
AI_DIR_TYPE_ToR = 8
AI_DIR_TYPE_Top = 9

arg1:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 120, 9999)

- target
- self
- direction
- degree
- distance

增强版，加上了距离参数



SpaceCheck(arg1, arg2, 180, arg1:GetStringIndexedNumber("Dist_Step_Large"))

- self
- meanless
- degree
- distance

正前是 0 度，顺时针增大；180是背后

检测相应角度的直线上，在 dist 范围内，有没有障碍物

如果没有障碍物，返回true





arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, parry_dist)


arg1:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToB, dist)

发射射线，进行障碍检测
return true when no collision？

- target，所检测的目标，可以为自己 or 玩家
- dir
- dist



arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, 45, 4)

时刻进行位置的检测
用于变招检测的身位判断

- 检测区域命名
- 检测者
- 检测目标
- 检测方向
- 角度范围
- 距离


if arg1:IsInterupt(INTERUPT_Inside_ObserveArea)
if arg1:IsInsideObserve(0) == true 
arg1:DeleteObserve(0)

如果检测到，则触发中断

## SubGoal

subgoal 与  jumptable 的关系



lifetime
每个 subgoal 是有寿命时长的，过期就会自动消失
ai的记忆力
只要在这个时长内，执行 subgoal 的条件得到满足，ai就会执行相应的subgoal



self:IsActiveGoal(GOAL_COMMON_SidewayMove)
当前正在执行的 subgoal 类型?队列中存在相应类型？
当前帧是否有jumptable的执行条件？

### move

arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, lifetime, target, arg2, TARGET_SELF, f1_local2, f1_local3)

arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)

### EndureAttack
            
goal_manager:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, parry_act_id, TARGET_ENE_0, 9999, 0)

准备开始承受攻击，架刀准备

- goal 时长
- 动作 id
- target
- 距离范围内生效
- ？？


生效条件，jumptable 122 允许 ai 输入 endure 命令


### Combo

arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, arg0:GetStringIndexedNumber("targetWhich"), f3_local10, f3_local11, f3_local12, 0, 0)


arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, arg0:GetStringIndexedNumber("targetWhich"), 9999, 0, 0)

- 9999
成功距离，只有在这个范围内，combo才会输入执行
9999 代表必定执行，
如果玩家离的远了，就不必执行




    
arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local8, arg0:GetStringIndexedNumber("targetWhich"), DistToAtt1,
        f4_local9, f4_local10, 0, 0)

arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 1, arg1:GetRandam_Int(30, 45), true, true, -1)


                goal_manager:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
后撤步

### AttackImmediateAction

arg0:AddTopGoal(GOAL_COMMON_AttackImmediateAction, 0.5, 20020, TARGET_SELF, 9999, 0, 0, 0, 0)

瞬发
即刻生效的动作，不需要依赖tae中的条件
但存在屏蔽瞬发动作的event block
disable ai immediate action



        
### arg2:ClearSubGoal()

arg1:Replanning()




## subgoal chain






# ai

Kaihuku 恢复
karaburi
Kankyaku 观众
Torimaki 随行人员

## 机制

主动计划，是ai执行的入口

循环不断的执行
replanning
当 subgoal 为空时


主动计划，最先执行交锋计划
否则进行常规计划

内部的 act 最大有 50 个


activate 无所谓返回值

act 的返回值是？
每个 act 返回当前 subgoal 队列的长度？
no action return -1


变招计划则与主动计划并行执行
不断搜索可能导致变招的信号，必要时将主动计划中断


存在一个 goal manager，存储了当前ai所有待执行的 subgoal list
每个 subgoal 有自己的寿命，过期自动清除
每个 subgoal 有自己的执行条件
每帧都会检测subgoal队列，从前到后，优先级从高到低，选择能执行的subgoal，执行，并清除

主动计划，交锋计划，内部分成不同的 act，每个 act 有不同的权重
每个 act 中，内部可添加 subgoal

每个 subgoal 有不同的类型
类型的执行条件，和tae event block中的设定相关



每个goal都注册到统一table中

有5个方法
- init
- activate
- update
- term
- int

在每个方法中，可以进行 add sub goal
add top goal

get top goal
add sub goal front


sub goal 是一个树？



logic 和 battle 的区别是什么？
main
int



Goal.Update = function (arg0, arg1, arg2)
    if arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end
    if arg2:GetLife() <= 0 then
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end


function Update_Default_NoSubGoal(arg0, arg1, arg2)
    if arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
end

## 主动计划 activate

- 判断，并赋予不同技能以权重
	- hp rate
	- 躯干 rate
	- dist
	- random int
	- space check，不同的度数
- 每个技能有自己的冷却时间
	- 在冷却时间内，使用冷却权重 1
		- 不使用 0，为了防止无技能可用
	- 在冷却之外，不修改权重，并重置计时器
- 根据权重，随机选择出技能释放
- 进行自身 目标的通知状态检测
- 优先级打断

approach act flex, move to 

add sub goal, 施放技能
- goal common combo attack tunable spin
- goal common combo repeat
- goal common combo final

clear sub goal


## 中断变招计划 interupt

参考 ai_define.lua

返回 false 说明没有中断发生
true 说明进行了中断

中断有多种类型
- sp中断，身上有某种sp引发的中断 
  - 观察相应的sp，需要提前注册
- parry timing 防御行为中断
  - 检测到玩家的攻击信号
  - 通用ai防御
    - 连续防御 2 3 次进行弹开
    - 对突刺直接弹开
    - 再执行交锋计划
- 被射击导致的中断
  - 通用行为
    - <= 30m 触发防御
    - 否则 0.3s 后再进行防御
    - 用招架防御
- 药检中断
  - <= 3m 用投技
  - 3-6m 挥枪
  - 6m 外使用主动计划
- 失去追踪目标引发的中断，距离太远

- 在技能攻击上添加状态，用于打断自己，在特定情况下
	- 药检
	- 变招成防御
    - 格挡计划
      - 检测对手的攻击前摇状态，打断主动计划，进行格挡


变招计划不会因动作冷却而不生效
但出招后，会影响主动计划 交锋计划的冷却时间

replan noaction 都会回到主动计划

同样可引入计数器机制

特殊变招

可以通过信号，来与其它队友进行联动



## 交锋计划 kengeki

根据交锋类型 sp 来进行检测

对敌人的多数招式，如果被弹开，玩家马上反斩，敌人会优先防御，而不是发动交锋计划




对于霸体敌人，ai不用考虑防御，无论近 或 远，更不用考虑交锋
在主动计划上更为细致
距离细分
方位细分

可能有被弹开的交锋


计数机制

每次交锋计划，都会令计数器+1
在 3 次之后，出仙峰脚，重置计数器