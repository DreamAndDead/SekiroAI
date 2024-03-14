常见使用特效

200004
ai state discovery or combat


kengeki sp

200200
被弹开，到右侧

200201
被弹开，到左侧

200205
被招架，到右侧

200206
被招架，到左侧

200210
弹开到右侧

200211
弹开到左侧

200215
招架到右侧

200216
招架到左侧

200225
200226
200227
200228
200229

200300
200301
200305
200306

200400
200401
200405
200406




arg1:IsFinishTimer(0)
0 号计时器是否已经计时结束
计时结束就保持在 0

arg0:SetTimer(0, 10)
将 0 号计时器置为 10s 并开始倒计时

arg1:GetAttackPassedTime(3020)
获取某个动作自上次执行，过了多少s


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



AddSubGoal

lifetime
每个 subgoal 是有寿命时长的，过期就会自动消失
ai的记忆力
只要在这个时长内，执行 subgoal 的条件得到满足，ai就会执行相应的subgoal





arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, lifetime, target, arg2, TARGET_SELF, f1_local2, f1_local3)

arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)

            arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, arg5, TARGET_ENE_0, 9999, 0)


arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, arg0:GetStringIndexedNumber("targetWhich"), f3_local10, f3_local11, f3_local12, 0, 0)

arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, arg0:GetStringIndexedNumber("targetWhich"), 9999, 0, 0)

- 9999
成功距离，只有在这个范围内，combo才会输入执行
9999 代表必定执行，
如果玩家离的远了，就不必执行




    
arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local8, arg0:GetStringIndexedNumber("targetWhich"), DistToAtt1,
        f4_local9, f4_local10, 0, 0)

arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 1, arg1:GetRandam_Int(30, 45), true, true, -1)

        
arg2:ClearSubGoal()
arg1:Replanning()









* ai

** 主动计划 goal.activate

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

中断有多种类型
- sp中断，身上有某种sp引发的中断 
- parry timing 需要进行格挡时机引发的中断
- 失去追踪目标引发的中断，距离太远
- 被远程攻击导致的中断

- 在技能攻击上添加状态，用于打断自己，在特定情况下
	- 药检
	- 变招成防御
    - 格挡计划
      - 检测对手的攻击前摇状态，打断主动计划，进行格挡


** 交锋计划 kengeki

- 在自己的格挡动作上添加状态，ai检测到时，打断格挡计划
- 在自己被格挡动作上添加状态，ai检测，打断格挡计划


** 防御计划 parry




