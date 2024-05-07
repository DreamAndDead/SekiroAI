Goal.Activate = function(self, pawn, planner)
    Init_Pseudo_Global(pawn, planner)

    local act_weights = {}
    local act_funcs = {}
    local default_act_params = {}
    Common_Clear_Param(act_weights, act_funcs, default_act_params)

    local dist_to_player = pawn:GetDist(TARGET_ENE_0)
    local sp_rate = pawn:GetSp(TARGET_SELF)

    pawn:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    pawn:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    pawn:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
    pawn:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)
    pawn:AddObserveSpecialEffectAttribute(TARGET_SELF, 5031)
    pawn:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710010)
    pawn:AddObserveSpecialEffectAttribute(TARGET_SELF, SP_SHINOBI_JUDGMENT)
    pawn:AddObserveSpecialEffectAttribute(TARGET_SELF, SP_AI_INT_JUDGMENT_ADDITION_PLAYED)
    pawn:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710031)

    pawn:AddObserveSpecialEffectAttribute(TARGET_ENE_0, SP_PRETEND_DEAD)
    pawn:AddObserveSpecialEffectAttribute(TARGET_ENE_0, SP_ROUNDHOUSE_KICK_HIT)
    pawn:AddObserveSpecialEffectAttribute(TARGET_ENE_0, SP_ENEMY_AI_REFERENCE_DEDICATED_RESPONSE_IAI_STANCE)

    Set_ConsecutiveGuardCount_Interrupt(pawn)
    pawn:DeleteObserve(0)

    if self:Kengeki_Activate(pawn, planner) then
        return
    end

    -- 优先判断 pc 死亡的反应
    if pawn:HasSpecialEffectId(TARGET_ENE_0, SP_DEAD) or pawn:HasSpecialEffectId(TARGET_ENE_0, SP_PRETEND_DEAD) then
        if pawn:IsInsideTarget(TARGET_ENE_0, DIR_FRONT, 90) then
            act_weights[21] = 1
            act_weights[28] = 100
        else
            act_weights[21] = 100
        end
    elseif Common_ActivateAct(pawn, planner, 0, 1) then

    -- TODO 动作变化模式？与计数器？
    elseif pawn:GetNumber(7) == 0 and pawn:HasSpecialEffectId(TARGET_SELF, SP_BEHAVIOR_PATTERN_CHANGE_0) then
        act_weights[15] = 600
    -- 如果此时 pc 在忍杀其它 enemy，则停留在周围，停止攻击，进行观察
    elseif pawn:HasSpecialEffectId(TARGET_ENE_0, SP_ENEMY_AI_REFERENCE_SHINOBI) then
        act_weights[28] = 100
    -- 此时 pc 在 ai 的背后，首选进行转身，次选进行快速移动离开
    elseif pawn:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        act_weights[21] = 100
        act_weights[22] = 1
    -- 对 pc 死亡的反应，和上面有所重复？
    elseif pawn:HasSpecialEffectId(TARGET_ENE_0, SP_DEAD) or pawn:HasSpecialEffectId(TARGET_ENE_0, SP_PRETEND_DEAD) then
        act_weights[27] = 100
    -- 7m 开外的选择
    elseif dist_to_player >= 7 then
        act_weights[10] = 300
        act_weights[15] = 600
    -- 5m-7m 之间
    elseif dist_to_player >= 5 then
        act_weights[10] = 300
        act_weights[23] = 100
        act_weights[34] = 100
        if sp_rate <= 360 then
            act_weights[9] = 300
        end
    -- 3m-5m 之间
    elseif dist_to_player > 3 then
        act_weights[1] = 5
        act_weights[2] = 10
        act_weights[6] = 30
        act_weights[11] = 15
        act_weights[23] = 15
        if sp_rate <= 360 then
            act_weights[9] = 300
        end
    -- 3m 之内
    else
        act_weights[3] = 15
        act_weights[11] = 15
        act_weights[23] = 10
        act_weights[31] = 30
        if pawn:IsFinishTimer(7) == true then
            act_weights[24] = 30
        end
    end

    -- pc 倒地 崩躯干的反应
    if (pawn:HasSpecialEffectId(TARGET_ENE_0, SP_PLAYER_DOWN) or pawn:HasSpecialEffectId(TARGET_ENE_0, SP_PC_BREAK)) and dist_to_player <= 5 then
        act_weights[16] = 100
    end

    if pawn:HasSpecialEffectId(TARGET_ENE_0, SP_ENEMY_AI_REFERENCE_DASHING) then
        act_weights[1] = 5
        act_weights[2] = 5
        act_weights[3] = 5
        act_weights[9] = 0
        act_weights[10] = 30
        act_weights[11] = 5
        act_weights[15] = 0
        act_weights[31] = 0
        act_weights[48] = 30
    end

    if pawn:GetNumber(2) == 1 then
        act_weights[23] = 6000
        pawn:SetNumber(2, 0)
    end

    if pawn:IsFinishTimer(0) == false then
        act_weights[3] = 0
        act_weights[6] = 1
    end

    if pawn:IsFinishTimer(1) == false then
        act_weights[2] = 0
    end
    
    if pawn:IsFinishTimer(3) == false then
        act_weights[24] = 0
    end

    if pawn:IsFinishTimer(6) == false then
        act_weights[9] = 0
    end

    if pawn:HasSpecialEffectId(TARGET_SELF, SP_BEHAVIOR_PATTERN_CHANGE_1) then
        act_weights[15] = 0
        act_weights[18] = 0
        act_weights[19] = 0
        act_weights[34] = 0
        act_weights[48] = 0
    end
    if NoCollisionAround(pawn, planner, 45, 2) == false and NoCollisionAround(pawn, planner, -45, 2) == false then
        act_weights[22] = 0
    end
    if NoCollisionAround(pawn, planner, 90, 1) == false and NoCollisionAround(pawn, planner, -90, 1) == false then
        act_weights[23] = 0
    end
    if NoCollisionAround(pawn, planner, 180, 2) == false then
        act_weights[24] = 0
    end
    if NoCollisionAround(pawn, planner, 180, 1) == false then
        act_weights[25] = 0
    end

    if pawn:HasSpecialEffectId(TARGET_ENE_0, SP_ENEMY_AI_REFERENCE_DEDICATED_RESPONSE_IAI_SLASHING) then
        act_weights[23] = 0
        act_weights[24] = 0
        act_weights[31] = 10
    end

    act_weights[1] = get_weight_base_on_cooldown(pawn, planner, 3000, 15, act_weights[1], 1)
    act_weights[2] = get_weight_base_on_cooldown(pawn, planner, 3004, 15, act_weights[2], 1)
    act_weights[3] = get_weight_base_on_cooldown(pawn, planner, 3005, 15, act_weights[3], 1)
    act_weights[4] = get_weight_base_on_cooldown(pawn, planner, 3006, 15, act_weights[4], 1)
    act_weights[5] = get_weight_base_on_cooldown(pawn, planner, 3007, 15, act_weights[5], 1)
    act_weights[6] = get_weight_base_on_cooldown(pawn, planner, 3016, 15, act_weights[6], 1)
    act_weights[7] = get_weight_base_on_cooldown(pawn, planner, 3020, 15, act_weights[7], 1)
    act_weights[8] = get_weight_base_on_cooldown(pawn, planner, 3021, 15, act_weights[8], 1)
    act_weights[9] = get_weight_base_on_cooldown(pawn, planner, 3092, 15, act_weights[9], 1)
    act_weights[10] = get_weight_base_on_cooldown(pawn, planner, 3006, 15, act_weights[10], 1)
    act_weights[11] = get_weight_base_on_cooldown(pawn, planner, 3037, 15, act_weights[11], 1)
    act_weights[13] = get_weight_base_on_cooldown(pawn, planner, 3011, 15, act_weights[13], 1)
    act_weights[14] = get_weight_base_on_cooldown(pawn, planner, 3014, 15, act_weights[14], 1)
    act_weights[15] = get_weight_base_on_cooldown(pawn, planner, 3014, 15, act_weights[15], 1)
    act_weights[18] = get_weight_base_on_cooldown(pawn, planner, 3040, 15, act_weights[18], 1)
    act_weights[30] = get_weight_base_on_cooldown(pawn, planner, 3006, 15, act_weights[30], 1)
    act_weights[31] = get_weight_base_on_cooldown(pawn, planner, 3045, 15, act_weights[31], 1)
    act_weights[32] = get_weight_base_on_cooldown(pawn, planner, 3006, 15, act_weights[32], 1)
    act_weights[34] = get_weight_base_on_cooldown(pawn, planner, 3007, 15, act_weights[34], 1)
    act_weights[38] = get_weight_base_on_cooldown(pawn, planner, 3006, 15, act_weights[38], 1)
    act_weights[48] = get_weight_base_on_cooldown(pawn, planner, 3013, 5, act_weights[48], 1)

    act_funcs[1] = REGIST_FUNC(pawn, planner, self.Act01)
    act_funcs[2] = REGIST_FUNC(pawn, planner, self.Act02)
    act_funcs[3] = REGIST_FUNC(pawn, planner, self.Act03)
    act_funcs[5] = REGIST_FUNC(pawn, planner, self.Act05)
    act_funcs[6] = REGIST_FUNC(pawn, planner, self.Act06)
    act_funcs[7] = REGIST_FUNC(pawn, planner, self.Act07)
    act_funcs[8] = REGIST_FUNC(pawn, planner, self.Act08)
    act_funcs[9] = REGIST_FUNC(pawn, planner, self.Act09)
    act_funcs[10] = REGIST_FUNC(pawn, planner, self.Act10)
    act_funcs[11] = REGIST_FUNC(pawn, planner, self.Act11)
    act_funcs[15] = REGIST_FUNC(pawn, planner, self.Act15)
    act_funcs[16] = REGIST_FUNC(pawn, planner, self.Act16)
    act_funcs[18] = REGIST_FUNC(pawn, planner, self.Act18)
    act_funcs[19] = REGIST_FUNC(pawn, planner, self.Act19)
    act_funcs[20] = REGIST_FUNC(pawn, planner, self.Act20)
    act_funcs[21] = REGIST_FUNC(pawn, planner, self.Act21)
    act_funcs[22] = REGIST_FUNC(pawn, planner, self.Act22)
    act_funcs[23] = REGIST_FUNC(pawn, planner, self.Act23)
    act_funcs[24] = REGIST_FUNC(pawn, planner, self.Act24)
    act_funcs[25] = REGIST_FUNC(pawn, planner, self.Act25)
    act_funcs[26] = REGIST_FUNC(pawn, planner, self.Act26)
    act_funcs[27] = REGIST_FUNC(pawn, planner, self.Act27)
    act_funcs[28] = REGIST_FUNC(pawn, planner, self.Act28)
    act_funcs[30] = REGIST_FUNC(pawn, planner, self.Act30)
    act_funcs[31] = REGIST_FUNC(pawn, planner, self.Act31)
    act_funcs[34] = REGIST_FUNC(pawn, planner, self.Act34)
    act_funcs[40] = REGIST_FUNC(pawn, planner, self.Act40)
    act_funcs[41] = REGIST_FUNC(pawn, planner, self.Act41)
    act_funcs[42] = REGIST_FUNC(pawn, planner, self.Act42)
    act_funcs[45] = REGIST_FUNC(pawn, planner, self.Act45)
    act_funcs[46] = REGIST_FUNC(pawn, planner, self.Act46)
    act_funcs[47] = REGIST_FUNC(pawn, planner, self.Act47)
    act_funcs[48] = REGIST_FUNC(pawn, planner, self.Act48)

    local f2_local8 = REGIST_FUNC(pawn, planner, self.ActAfter_AdjustSpace)
    Common_Battle_Activate(pawn, planner, act_weights, act_funcs, f2_local8, default_act_params)
end

--[[
    4 连
]]
Goal.Act01 = function(pawn, planner, arg2)
    local f3_local0 = 3.6 - pawn:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 3.6 - pawn:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 3.6 - pawn:GetMapHitRadius(TARGET_SELF) + 3
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 2.5
    local f3_local6 = 3
    local percent_rand = pawn:GetRandam_Int(1, 100)

    Approach_Act_Flex(pawn, planner, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)

    local f3_local8 = 3.5 - pawn:GetMapHitRadius(TARGET_SELF)
    local f3_local9 = 3.4 - pawn:GetMapHitRadius(TARGET_SELF)
    local f3_local10 = 3.4 - pawn:GetMapHitRadius(TARGET_SELF)
    local f3_local11 = 0
    local f3_local12 = 0

    -- 同一个 act 下，也有概率选择
    -- 进行一些招式变化，前两招相同，到后面突然改变
    -- 打破玩家的预想
    if percent_rand <= 30 then
        planner:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local11, f3_local12, 0,
            0)
        planner:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, f3_local9, 0)
        planner:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3002, TARGET_ENE_0, f3_local10, 0)
        planner:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    else
        planner:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local11, f3_local12, 0,
            0)
        planner:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 3.5, 0)
        planner:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3010, TARGET_ENE_0, 5, 0)
        planner:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)
    end

    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act02 = function(arg0, arg1, arg2)
    local f4_local0 = 3.2 - arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 3.2 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 3.2 - arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 2.5
    local f4_local6 = 3
    Approach_Act_Flex(arg0, arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)

    local f4_local7 = 0
    local f4_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act03 = function(arg0, arg1, arg2)
    local f5_local0 = 2.2 - arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 2.2 - arg0:GetMapHitRadius(TARGET_SELF) + 0.3
    local f5_local2 = 2.2 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(arg0, arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    local f5_local9 = 180
    local f5_local10 = 3
    arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, f5_local9, f5_local10)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    arg0:SetTimer(0, 7)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act05 = function(arg0, arg1, arg2)
    local f6_local0 = 5.9 - arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 5.9 - arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 5.9 - arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 2.5
    local f6_local6 = 3
    Approach_Act_Flex(arg0, arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f6_local7, f6_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act06 = function(arg0, arg1, arg2)
    local f7_local0 = 5.2 - arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 5.2 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local2 = 5.2 - arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(arg0, arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)

    local f7_local7 = 0
    local f7_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3016, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    arg0:SetTimer(0, 5)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

--[[
    飞渡浮舟
]]
Goal.Act09 = function(arg0, arg1, arg2)
    local f8_local0 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(arg0, arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)

    local f8_local7 = 0
    local f8_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3040, TARGET_ENE_0, 4, f8_local7, f8_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3041, TARGET_ENE_0, 3.5, 0)
    arg0:SetTimer(6, 30)

    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

--[[
    快速近身，进行左右交叉斩
]]
Goal.Act10 = function(pawn, planner, arg2)
    local f9_local0 = 4.8 - pawn:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 4.8 - pawn:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 4.8 - pawn:GetMapHitRadius(TARGET_SELF)
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 10
    local f9_local6 = 10
    Approach_Act_Flex(pawn, planner, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)

    local f9_local7 = 0
    local f9_local8 = 0
    planner:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f9_local7, f9_local8, 0, 0)
    pawn:SetTimer(3, 10)

    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act11 = function(arg0, arg1, arg2)
    local f10_local0 = 3.2 - arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 3.2 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local2 = 3.2 - arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 3
    local f10_local6 = 3
    Approach_Act_Flex(arg0, arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)

    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3037, TARGET_ENE_0, 6, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
end

--[[
    在 SP_BEHAVIOR_PATTERN_CHANGE_0 时触发
    近身，进行射剑与斩击的 2 连
]]
Goal.Act15 = function(pawn, planner, arg2)
    local f11_local0 = 8.9 - pawn:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 8.9 - pawn:GetMapHitRadius(TARGET_SELF) - 2
    local f11_local2 = 8.9 - pawn:GetMapHitRadius(TARGET_SELF)
    Approach_Act_Flex(pawn, planner, f11_local0, f11_local1, f11_local2, 100, 0, 1.5, 3)

    local f11_local9 = 7 - pawn:GetMapHitRadius(TARGET_SELF)
    planner:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3014, TARGET_ENE_0, f11_local9, 0, 0, 0, 0)
    planner:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    pawn:SetNumber(7, 1)

    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act16 = function(arg0, arg1, arg2)
    local f12_local0 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local1 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local2 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local3 = 100
    local f12_local4 = 0
    local f12_local5 = 1.5
    local f12_local6 = 3
    Approach_Act_Flex(arg0, arg1, f12_local0, f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6)

    local f12_local8 = 0
    local f12_local9 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, f12_local8, f12_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act20 = function(arg0, arg1, arg2)
    local f13_local0 = 3.2 - arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local1 = 3.2 - arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f13_local2 = 3.2 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local3 = 100
    local f13_local4 = 0
    local f13_local5 = 2.5
    local f13_local6 = 3
    Approach_Act_Flex(arg0, arg1, f13_local0, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6)
    local f13_local7 = 0
    local f13_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3062, TARGET_ENE_0, 9999, f13_local7, f13_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

--[[
    对 pc 死亡的反应
    此时 ai 不在 pc 的正面
--]]
Goal.Act21 = function(arg0, planner, arg2)
    planner:AddSubGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 45, -1, GOAL_RESULT_Success, true)

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

--[[
    pc 在自己身后，快速调整站位
]]
Goal.Act22 = function(pawn, planner, arg2)
    if NoCollisionAround(pawn, planner, -45, 2) == true then
        if NoCollisionAround(pawn, planner, 45, 2) == true then
            -- pc 在 ai 的偏右侧，向左侧侧步
            if pawn:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                planner:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5202, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 0)
            -- 反之，向左侧侧步
            else
                planner:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5203, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 0)
            end
        -- 向左侧快速侧步
        else
            planner:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5202, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 0)
        end
    -- 向右侧快速侧步
    elseif NoCollisionAround(pawn, planner, 45, 2) == true then
        planner:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5203, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 0)
    end

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

--[[
    侧步接近 pc
]]
Goal.Act23 = function(pawn, planner, arg2)
    local right_dir = 0
    if NoCollisionAround(pawn, planner, -90, 1) == true then
        if NoCollisionAround(pawn, planner, 90, 1) == true then
            if pawn:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 5) then
                right_dir = 1
            else
                right_dir = 0
            end
        else
            right_dir = 0
        end
    elseif NoCollisionAround(pawn, planner, 90, 1) == true then
        right_dir = 1
    end

    local f16_local6 = pawn:GetRandam_Int(1.5, 3)
    local f16_local7 = pawn:GetRandam_Int(30, 45)
    pawn:SetNumber(10, right_dir)
    planner:AddSubGoal(GOAL_COMMON_SidewayMove, f16_local6, TARGET_ENE_0, right_dir, f16_local7, true, true, -1)

    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act24 = function(arg0, arg1, arg2)
    local f17_local0 = arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = 3
    local f17_local2 = 0
    local f17_local3 = 5201
    local f17_local4 = arg0:GetSpRate(TARGET_SELF)
    if NoCollisionAround(arg0, arg1, 180, 2) == true and NoCollisionAround(arg0, arg1, 180, 4) == true then
        if f17_local0 <= 4 then
            f17_local3 = 5201
        end
    end
    arg0:SetNumber(2, 1)

    local f17_local5 = arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local1, f17_local3, TARGET_ENE_0, f17_local2,
        AI_DIR_TYPE_B, 0)
    f17_local5:TimingSetTimer(3, 30, AI_TIMING_SET__UPDATE_SUCCESS)
    if f17_local4 <= 0.7 and arg0:HasSpecialEffectId(TARGET_SELF, SP_BEHAVIOR_PATTERN_CHANGE_0) then
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3044, TARGET_ENE_0, DistToAtt1, f17_local2, FrontAngle, 0, 0)
    end

    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act25 = function(arg0, arg1, arg2)
    local f18_local0 = arg0:GetRandam_Float(2, 4)
    local f18_local1 = arg0:GetRandam_Float(1, 3)
    local f18_local2 = arg0:GetDist(TARGET_ENE_0)
    local f18_local3 = -1
    if NoCollisionAround(arg0, arg1, 180, 1) == true then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f18_local0, TARGET_ENE_0, f18_local1, TARGET_ENE_0, true, f18_local3)
    else

    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act26 = function(arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

--[[
    同样是守尸行为
]]
Goal.Act27 = function(pawn, planner, arg2)
    local dist_to_player = pawn:GetDist(TARGET_ENE_0)
    local rand_2_4 = pawn:GetRandam_Float(2, 4)
    local rand_30_45 = pawn:GetRandam_Int(30, 45)

    -- 保持合适的距离
    if dist_to_player >= 8 then
        planner:AddSubGoal(GOAL_COMMON_ApproachTarget, rand_2_4, TARGET_ENE_0, 8, TARGET_ENE_0, true, -1)
    elseif dist_to_player <= 5 then
        planner:AddSubGoal(GOAL_COMMON_LeaveTarget, rand_2_4, TARGET_ENE_0, 5, TARGET_ENE_0, true, -1)
    end

    -- 在旁边徘徊
    planner:AddSubGoal(GOAL_COMMON_SidewayMove, rand_2_4, TARGET_ENE_0, pawn:GetRandam_Int(0, 1), rand_30_45, true, true, -1)

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

--[[
    对 pc 死亡的反应
    此时 ai 在 pc 的正面
    进行守尸行为
--]]
Goal.Act28 = function(pawn, planner, arg2)
    local dist_to_player = pawn:GetDist(TARGET_ENE_0)
    local rand_30_45 = pawn:GetRandam_Int(30, 45)
    local rand_0_1 = pawn:GetRandam_Int(0, 1)

    if dist_to_player <= 3 then
        planner:AddSubGoal(GOAL_COMMON_SidewayMove, 1.5, TARGET_ENE_0, rand_0_1, rand_30_45, true, true, -1)
    elseif dist_to_player <= 8 then
        planner:AddSubGoal(GOAL_COMMON_ApproachTarget, 1.5, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else -- dist_to_player > 8
        planner:AddSubGoal(GOAL_COMMON_ApproachTarget, 1.5, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act30 = function(arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3044, TARGET_ENE_0, DistToAtt1, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act31 = function(arg0, arg1, arg2)
    local f23_local0 = 3.6 - arg0:GetMapHitRadius(TARGET_SELF)
    local f23_local1 = 3.6 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f23_local2 = 3.6 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f23_local3 = 100
    local f23_local4 = 0
    local f23_local5 = 1.5
    local f23_local6 = 3
    Approach_Act_Flex(arg0, arg1, f23_local0, f23_local1, f23_local2, f23_local3, f23_local4, f23_local5, f23_local6)
    local f23_local7 = 0
    local f23_local8 = 0
    local f23_local9 = 999 - arg0:GetMapHitRadius(TARGET_SELF)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, f23_local9, f23_local7, f23_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3045, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

--[[
    近身下位攻击 接 射击
]]
Goal.Act34 = function(pawn, planner, arg2)
    local f24_local0 = 5.9 - pawn:GetMapHitRadius(TARGET_SELF)
    local f24_local1 = 5.9 - pawn:GetMapHitRadius(TARGET_SELF) + 2
    local f24_local2 = 5.9 - pawn:GetMapHitRadius(TARGET_SELF) + 2
    local f24_local3 = 100
    local f24_local4 = 0
    local f24_local5 = 1.5
    local f24_local6 = 3
    Approach_Act_Flex(pawn, planner, f24_local0, f24_local1, f24_local2, f24_local3, f24_local4, f24_local5, f24_local6)

    local f24_local7 = 0
    local f24_local8 = 0
    local f24_local9 = 999 - pawn:GetMapHitRadius(TARGET_SELF)
    planner:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3007, TARGET_ENE_0, f24_local9, f24_local7, f24_local8, 0, 0)
    planner:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act48 = function(arg0, arg1, arg2)
    local f25_local0 = 8.9 - arg0:GetMapHitRadius(TARGET_SELF)
    local f25_local1 = 8.9 - arg0:GetMapHitRadius(TARGET_SELF) - 2
    local f25_local2 = 8.9 - arg0:GetMapHitRadius(TARGET_SELF)
    local f25_local3 = 100
    local f25_local4 = 0
    local f25_local5 = 1.5
    local f25_local6 = 3
    Approach_Act_Flex(arg0, arg1, f25_local0, f25_local1, f25_local2, f25_local3, f25_local4, f25_local5, f25_local6)

    local f25_local7 = 0
    local f25_local8 = 0
    local f25_local9 = 7 - arg0:GetMapHitRadius(TARGET_SELF)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3013, TARGET_ENE_0, f25_local9, f25_local7, f25_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetNumber(7, 1)

    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end





Goal.Interrupt = function(self, pawn, planner)
    local int_sp = pawn:GetSpecialEffectActivateInterruptType(0)
    local dist_to_player = pawn:GetDist(TARGET_ENE_0)
    local percent_rand = pawn:GetRandam_Int(1, 100)
    local ninsatsu_num = pawn:GetNinsatsuNum()

    -- 爬梯时不准被中断
    if pawn:IsLadderAct(TARGET_SELF) then
        return false
    end

    -- 只有有发现 战斗阶段，中断才有意义
    if not pawn:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then
        return false
    end

    -- 攻击信号带来的中断
    if pawn:IsInterupt(INTERUPT_ParryTiming) then
        return self.Parry(pawn, planner, 100, 0)
    end

    -- 远程攻击的中断
    if pawn:IsInterupt(INTERUPT_ShootImpact) and self.ShootReaction(pawn, planner) then
        return true
    end

    if pawn:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if int_sp == SP_SHINOBI_JUDGMENT then
            pawn:SetNumber(0, 0)
            return true
        elseif int_sp == SP_AI_INT_JUDGMENT_ADDITION_PLAYED and pawn:HasSpecialEffectId(TARGET_SELF, SP_AI_INT_JUDGMENT_PARRIED_AND_STRONG_ATTACK) then
            planner:ClearSubGoal()
            planner:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3092, TARGET_ENE_0, 9999, 0)
            pawn:SetTimer(6, 50)
            return true
        elseif int_sp == 5029 then
            return self.Damaged(pawn, planner)
        elseif int_sp == 5031 then
            if ninsatsu_num <= 1 and dist_to_player >= 4.1 then
                planner:ClearSubGoal()
                planner:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3017, TARGET_ENE_0, 9999, 0)
            end
        elseif int_sp == SP_ROUNDHOUSE_KICK_HIT then
            if percent_rand <= 50 and pawn:HasSpecialEffectId(TARGET_SELF, SP_BEHAVIOR_PATTERN_CHANGE_0) then
                planner:ClearSubGoal()
                planner:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3023, TARGET_ENE_0, 9999, 0)
            else
                planner:ClearSubGoal()
                planner:AddSubGoal(GOAL_COMMON_SidewayMove, 4, TARGET_ENE_0, pawn:GetRandam_Int(0, 1),
                    pawn:GetRandam_Int(30, 45), true, true, -1)
            end
        elseif int_sp == SP_ENEMY_AI_REFERENCE_DEDICATED_RESPONSE_IAI_STANCE then
            pawn:Replanning()
            return true
        end
    end

    if Interupt_Use_Item(pawn, 8, 5) then
        if not pawn:HasSpecialEffectId(TARGET_SELF, SP_BEHAVIOR_PATTERN_CHANGE_1) or ninsatsu_num <= 1 then
            planner:ClearSubGoal()
            planner:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3023, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        end
    end

    return false
end


-- 对 pc 攻击信号的反应
Goal.Parry = function(pawn, planner, arg2, arg3)
    local parry_dist = GetDist_Parry(pawn)

    local percent_rand_1 = pawn:GetRandam_Int(1, 100)
    local percent_rand_2 = pawn:GetRandam_Int(1, 100)
    local percent_rand_3 = pawn:GetRandam_Int(1, 100)

    local f27_local5 = pawn:HasSpecialEffectId(TARGET_ENE_0, SP_PUSH)
    local f27_local6 = pawn:HasSpecialEffectId(TARGET_ENE_0, SP_CONTINUOUS_ATTACK)

    local f27_local7 = 2
    if pawn:HasSpecialEffectId(TARGET_SELF, 221000) then
        f27_local7 = 0
    elseif pawn:HasSpecialEffectId(TARGET_SELF, 221001) then
        f27_local7 = 1
    end

    -- 还未冷却下来，无法 parry
    if pawn:IsFinishTimer(AI_TIMER_PARRY) == false then
        return false
    end

    if pawn:HasSpecialEffectId(TARGET_ENE_0, 110450) or pawn:HasSpecialEffectId(TARGET_ENE_0, 110501) or pawn:HasSpecialEffectId(TARGET_ENE_0, 110500) then
        return false
    end

    -- 重置计时器
    pawn:SetTimer(AI_TIMER_PARRY, 0.1)

    if arg2 == nil then
        arg2 = 50
    end
    if arg3 == nil then
        arg3 = 0
    end

    if pawn:IsInsideTarget(TARGET_ENE_0, DIR_FRONT, 90) and pawn:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, DIR_FRONT, 180, parry_dist) then
        if pawn:HasSpecialEffectId(TARGET_SELF, 3710040) then
            planner:ClearSubGoal()
            planner:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
            pawn:SetTimer(5, 60)
            return true
        elseif f27_local6 then
            planner:ClearSubGoal()
            planner:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3103, TARGET_ENE_0, 9999, 0)
            return true
        elseif f27_local5 then
            if pawn:IsTargetGuard(TARGET_SELF) and get_kengeki_sp(pawn) == false then
                return false
            elseif f27_local7 == 2 then
                return false
            elseif f27_local7 == 1 then
                if percent_rand_1 <= 50 then
                    planner:ClearSubGoal()
                    planner:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                    return true
                end
            elseif f27_local7 == 0 and percent_rand_1 <= 100 then
                planner:ClearSubGoal()
                planner:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif pawn:HasSpecialEffectId(TARGET_ENE_0, 109980) then
            planner:ClearSubGoal()
            planner:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        elseif percent_rand_2 <= Get_ConsecutiveGuardCount(pawn) * arg2 then
            planner:ClearSubGoal()
            planner:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
            return true
        else
            planner:ClearSubGoal()
            planner:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif pawn:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, DIR_FRONT, 90, parry_dist + 1) then
        if percent_rand_3 <= arg3 then
            planner:ClearSubGoal()
            planner:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        else
            return false
        end
    else
        return false
    end
end



Goal.Damaged = function(pawn, planner)
    local percent_rand = pawn:GetRandam_Int(1, 100)

    if percent_rand <= 15 then
        planner:ClearSubGoal()
        -- 后撤
        local f28_local6 = planner:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B,
            0)
        f28_local6:TimingSetTimer(3, 6, UPDATE_SUCCESS)
        pawn:SetNumber(2, 1)

        if pawn:GetNumber(0) <= 3 then
            pawn:SetNumber(0, 0)
        else
            pawn:SetNumber(0, pawn:GetNumber(0) - 3)
        end

        return true
    elseif percent_rand <= 30 and pawn:HasSpecialEffectId(TARGET_SELF, SP_BEHAVIOR_PATTERN_CHANGE_0) then
        planner:ClearSubGoal()
        -- 后撤射击
        planner:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3009, TARGET_ENE_0, 9999, 0)
        pawn:SetNumber(2, 1)

        if pawn:GetNumber(0) <= 3 then
            pawn:SetNumber(0, 0)
        else
            pawn:SetNumber(0, pawn:GetNumber(0) - 3)
        end

        return true
    end
    return false
end



Goal.ShootReaction = function(arg0, arg1)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
end




Goal.Kengeki_Activate = function(self, pawn, planner)
    local kengeki_sp = get_kengeki_sp(pawn)
    if kengeki_sp == 0 then
        return false
    end

    local act_weights = {}
    local act_funcs = {}
    local default_act_params = {}
    Common_Clear_Param(act_weights, act_funcs, default_act_params)

    local dist_to_player = pawn:GetDist(TARGET_ENE_0)
    local hp_rate = pawn:GetHpRate(TARGET_SELF)

    if kengeki_sp == 200200 then
        pawn:SetNumber(0, pawn:GetNumber(0) + 1)
        if dist_to_player >= 2.5 then
            act_weights[50] = 100
        elseif pawn:GetNumber(0) >= 2 then
            act_weights[3] = 60
            act_weights[20] = 60
            act_weights[30] = 5
            act_weights[38] = 50
            act_weights[15] = 30
            act_weights[43] = 50
            act_weights[39] = 30
            if pawn:GetNumber(6) == 0 then
                act_weights[32] = 20
            else
                act_weights[33] = 20
            end
        elseif pawn:GetNumber(3) == 0 then
            act_weights[1] = 50
        else
            act_weights[4] = 100
        end
    elseif kengeki_sp == 200201 then
        if dist_to_player >= 2.5 then
            act_weights[50] = 100
        elseif pawn:GetNumber(0) >= 2 then
            act_weights[3] = 60
            act_weights[20] = 60
            act_weights[38] = 50
            act_weights[15] = 30
            act_weights[43] = 50
            act_weights[39] = 30
            if pawn:GetNumber(6) == 0 then
                act_weights[32] = 50
            else
                act_weights[33] = 50
            end
        elseif pawn:GetNumber(3) == 0 then
            act_weights[1] = 50
        else
            act_weights[4] = 100
        end
    elseif kengeki_sp == SP_PARRY_COUNT_RIGHT then
        act_weights[2] = 100
        act_weights[17] = 100
        act_weights[38] = 50
        act_weights[31] = 50
    elseif kengeki_sp == SP_PARRY_COUNT_LEFT then
        act_weights[2] = 100
        act_weights[10] = 50
        act_weights[31] = 50
        act_weights[38] = 50
    elseif kengeki_sp == 200216 then
        if dist_to_player >= 2 then
            act_weights[50] = 10
        else
            pawn:SetNumber(0, pawn:GetNumber(0) + 1)
            if pawn:GetNumber(0) >= 3 then
                act_weights[3] = 60
                act_weights[20] = 20
                act_weights[38] = 100
                act_weights[43] = 50
                if pawn:GetNumber(6) == 0 then
                    act_weights[32] = 50
                else
                    act_weights[33] = 50
                end
            else
                act_weights[20] = 50
                if pawn:GetNumber(3) == 0 then
                    act_weights[1] = 50
                else
                    act_weights[14] = 50
                end
            end
        end
    elseif kengeki_sp == 200215 then
        if dist_to_player >= 2 then
            act_weights[50] = 10
        else
            pawn:SetNumber(0, pawn:GetNumber(0) + 1)
            if pawn:GetNumber(0) >= 3 then
                act_weights[20] = 20
                act_weights[38] = 30
                act_weights[31] = 15
                act_weights[43] = 10
                act_weights[39] = 10
                if pawn:GetNumber(6) == 0 then
                    act_weights[32] = 50
                else
                    act_weights[33] = 50
                end
            else
                act_weights[20] = 50
                if pawn:GetNumber(3) == 0 then
                    act_weights[1] = 50
                else
                    act_weights[14] = 50
                end
            end
        end
    end

    if pawn:HasSpecialEffectId(TARGET_SELF, SP_BEHAVIOR_PATTERN_CHANGE_1) then
        act_weights[3] = 0
        act_weights[9] = 0
        act_weights[15] = 0
        act_weights[32] = 0
        act_weights[33] = 0
        act_weights[39] = 0
        act_weights[46] = 0
    elseif pawn:HasSpecialEffectId(TARGET_SELF, SP_BEHAVIOR_PATTERN_CHANGE_0) then
        act_weights[20] = 0
    end

    if NoCollisionAround(pawn, planner, 45, 2) == false and NoCollisionAround(pawn, planner, -45, 2) == false then
        act_weights[20] = 0
    end

    if pawn:IsFinishTimer(6) == false then
        act_weights[40] = 0
    elseif pawn:IsFinishTimer(6) == true and hp_rate <= 0.75 then
        act_weights[40] = 50
    end

    act_weights[1] = get_weight_base_on_cooldown(pawn, planner, 3050, 8, act_weights[1], 1)
    act_weights[2] = get_weight_base_on_cooldown(pawn, planner, 5201, 10, act_weights[2], 1)
    act_weights[3] = get_weight_base_on_cooldown(pawn, planner, 3009, 10, act_weights[3], 1)
    act_weights[4] = get_weight_base_on_cooldown(pawn, planner, 3055, 8, act_weights[4], 1)
    act_weights[7] = get_weight_base_on_cooldown(pawn, planner, 3060, 8, act_weights[7], 1)
    act_weights[9] = get_weight_base_on_cooldown(pawn, planner, 3018, 8, act_weights[9], 1)
    act_weights[10] = get_weight_base_on_cooldown(pawn, planner, 3065, 8, act_weights[10], 1)
    act_weights[13] = get_weight_base_on_cooldown(pawn, planner, 3075, 8, act_weights[13], 1)
    act_weights[14] = get_weight_base_on_cooldown(pawn, planner, 3076, 8, act_weights[14], 1)
    act_weights[15] = get_weight_base_on_cooldown(pawn, planner, 3031, 15, act_weights[15], 1)
    act_weights[17] = get_weight_base_on_cooldown(pawn, planner, 3071, 8, act_weights[17], 1)
    act_weights[18] = get_weight_base_on_cooldown(pawn, planner, 3004, 8, act_weights[18], 1)
    act_weights[20] = get_weight_base_on_cooldown(pawn, planner, 5202, 15, act_weights[20], 1)
    act_weights[30] = get_weight_base_on_cooldown(pawn, planner, 3063, 15, act_weights[30], 1)
    act_weights[31] = get_weight_base_on_cooldown(pawn, planner, 3068, 15, act_weights[31], 1)
    act_weights[32] = get_weight_base_on_cooldown(pawn, planner, 3018, 15, act_weights[32], 1)
    act_weights[33] = get_weight_base_on_cooldown(pawn, planner, 3007, 15, act_weights[33], 1)
    act_weights[34] = get_weight_base_on_cooldown(pawn, planner, 3037, 15, act_weights[34], 1)
    act_weights[35] = get_weight_base_on_cooldown(pawn, planner, 3016, 8, act_weights[35], 1)
    act_weights[38] = get_weight_base_on_cooldown(pawn, planner, 3030, 8, act_weights[38], 1)
    act_weights[39] = get_weight_base_on_cooldown(pawn, planner, 3034, 15, act_weights[39], 1)
    act_weights[40] = get_weight_base_on_cooldown(pawn, planner, 3028, 15, act_weights[40], 1)
    act_weights[41] = get_weight_base_on_cooldown(pawn, planner, 3020, 15, act_weights[41], 1)
    act_weights[43] = get_weight_base_on_cooldown(pawn, planner, 3062, 15, act_weights[43], 1)
    act_weights[44] = get_weight_base_on_cooldown(pawn, planner, 3067, 15, act_weights[44], 1)
    act_weights[45] = get_weight_base_on_cooldown(pawn, planner, 3032, 15, act_weights[45], 1)

    act_funcs[1] = REGIST_FUNC(pawn, planner, self.Kengeki01)
    act_funcs[2] = REGIST_FUNC(pawn, planner, self.Kengeki02)
    act_funcs[3] = REGIST_FUNC(pawn, planner, self.Kengeki03)
    act_funcs[4] = REGIST_FUNC(pawn, planner, self.Kengeki04)
    act_funcs[5] = REGIST_FUNC(pawn, planner, self.Kengeki05)
    act_funcs[6] = REGIST_FUNC(pawn, planner, self.Kengeki06)
    act_funcs[7] = REGIST_FUNC(pawn, planner, self.Kengeki07)
    act_funcs[9] = REGIST_FUNC(pawn, planner, self.Kengeki09)
    act_funcs[10] = REGIST_FUNC(pawn, planner, self.Kengeki10)
    act_funcs[13] = REGIST_FUNC(pawn, planner, self.Kengeki13)
    act_funcs[14] = REGIST_FUNC(pawn, planner, self.Kengeki14)
    act_funcs[15] = REGIST_FUNC(pawn, planner, self.Kengeki15)
    act_funcs[17] = REGIST_FUNC(pawn, planner, self.Kengeki17)
    act_funcs[18] = REGIST_FUNC(pawn, planner, self.Kengeki18)
    act_funcs[19] = REGIST_FUNC(pawn, planner, self.Kengeki19)
    act_funcs[20] = REGIST_FUNC(pawn, planner, self.Kengeki20)
    act_funcs[21] = REGIST_FUNC(pawn, planner, self.Kengeki21)
    act_funcs[30] = REGIST_FUNC(pawn, planner, self.Kengeki30)
    act_funcs[31] = REGIST_FUNC(pawn, planner, self.Kengeki31)
    act_funcs[32] = REGIST_FUNC(pawn, planner, self.Kengeki32)
    act_funcs[33] = REGIST_FUNC(pawn, planner, self.Kengeki33)
    act_funcs[34] = REGIST_FUNC(pawn, planner, self.Kengeki34)
    act_funcs[35] = REGIST_FUNC(pawn, planner, self.Kengeki35)
    act_funcs[36] = REGIST_FUNC(pawn, planner, self.Kengeki36)
    act_funcs[37] = REGIST_FUNC(pawn, planner, self.Kengeki37)
    act_funcs[38] = REGIST_FUNC(pawn, planner, self.Kengeki38)
    act_funcs[39] = REGIST_FUNC(pawn, planner, self.Kengeki39)
    act_funcs[40] = REGIST_FUNC(pawn, planner, self.Kengeki40)
    act_funcs[41] = REGIST_FUNC(pawn, planner, self.Kengeki41)
    act_funcs[43] = REGIST_FUNC(pawn, planner, self.Kengeki43)
    act_funcs[44] = REGIST_FUNC(pawn, planner, self.Kengeki44)
    act_funcs[45] = REGIST_FUNC(pawn, planner, self.Kengeki45)
    act_funcs[46] = REGIST_FUNC(pawn, planner, self.Kengeki46)
    act_funcs[50] = REGIST_FUNC(pawn, planner, self.NoAction)

    local f30_local7 = REGIST_FUNC(pawn, planner, self.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(pawn, planner, act_weights, act_funcs, f30_local7, default_act_params)
end

Goal.Kengeki01 = function(pawn, planner, arg2)
    pawn:SetNumber(3, 1)
    planner:ClearSubGoal()
    planner:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3050, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki02 = function(arg0, arg1, arg2)
    local f32_local0 = arg0:GetSpRate(TARGET_SELF)
    arg1:ClearSubGoal()
    local f32_local1 = arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 9999, 0, 0)
    f32_local1:TimingSetTimer(3, 30, AI_TIMING_SET__UPDATE_SUCCESS)
    arg0:SetNumber(2, 1)
    if f32_local0 <= 0.7 and arg0:HasSpecialEffectId(TARGET_SELF, SP_BEHAVIOR_PATTERN_CHANGE_0) then
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3044, TARGET_ENE_0, DistToAtt1, TurnTime, FrontAngle, 0, 0)
    end
end

Goal.Kengeki03 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 999, 0, 0, 0, 0)
    local f33_local0 = 0
    if NoCollisionAround(arg0, arg1, -90, 1) == true then
        if NoCollisionAround(arg0, arg1, 90, 1) == true then
            if arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 5) then
                f33_local0 = 1
            else
                f33_local0 = 0
            end
        else
            f33_local0 = 0
        end
    elseif NoCollisionAround(arg0, arg1, 90, 1) == true then
        f33_local0 = 1
    else
        f33_local0 = 1
    end
    local f33_local1 = 4
    local f33_local2 = arg0:GetRandam_Int(30, 45)
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f33_local1, TARGET_ENE_0, f33_local0, f33_local2, true, true, -1)
end

Goal.Kengeki04 = function(arg0, arg1, arg2)
    arg0:SetNumber(3, 0)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3055, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki07 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3060, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki09 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, 999, 0, 0, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki10 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3065, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki13 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3075, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki14 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3076, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki15 = function(arg0, arg1, arg2)
    local f40_local0 = 0
    local f40_local1 = 0
    local f40_local2 = 7.8 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f40_local3 = 0
    f40_local3 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f40_local4 = arg0:GetRandam_Int(1, 100)
    local f40_local5 = arg0:GetRandam_Int(1, 100)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3031, TARGET_ENE_0, f40_local2, f40_local0, f40_local1, 0, 0)
    if f40_local4 <= 50 then
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, f40_local3, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3029, TARGET_ENE_0, 9999, 0, 0)
    else
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3036, TARGET_ENE_0, 9999, 0, 0)
    end
    if f40_local5 <= 50 then
        arg0:SetNumber(2, 1)
    end
end

Goal.Kengeki17 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3071, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki18 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki19 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3044, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki20 = function(arg0, arg1, arg2)
    local f44_local1 = 3

    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_SpinStep, f44_local1, 5202, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
    return GETWELLSPACE_ODDS
end

Goal.Kengeki21 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki30 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    local f46_local0 = arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3063, TARGET_ENE_0, 9999, 0, 0)
    f46_local0:TimingSetTimer(1, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    arg0:SetNumber(5, 0)
end

Goal.Kengeki31 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    local f47_local0 = arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3068, TARGET_ENE_0, 9999, 0, 0)
    f47_local0:TimingSetTimer(1, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    arg0:SetNumber(5, 0)
end

Goal.Kengeki32 = function(arg0, arg1, arg2)
    local f48_local0 = 0
    local f48_local1 = 0
    local f48_local2 = 999 - arg0:GetMapHitRadius(TARGET_SELF)
    local f48_local3 = 7 - arg0:GetMapHitRadius(TARGET_SELF)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, f48_local2, f48_local0, f48_local1, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetNumber(6, 1)
end

Goal.Kengeki33 = function(arg0, arg1, arg2)
    local f49_local0 = 0
    local f49_local1 = 0
    local f49_local2 = 999 - arg0:GetMapHitRadius(TARGET_SELF)
    local f49_local3 = 7.8 - arg0:GetMapHitRadius(TARGET_SELF)
    local f49_local5 = arg0:GetRandam_Int(1, 100)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, f49_local2, f49_local0, f49_local1, 0, 0)
    if f49_local5 <= 50 then
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, f49_local3, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3029, TARGET_ENE_0, 9999, 0, 0)
    else
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3019, TARGET_ENE_0, 9999, 0, 0)
    end
    arg0:SetNumber(6, 0)
end

Goal.Kengeki34 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3037, TARGET_ENE_0, 6, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki35 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetNumber(5, 0)
end

Goal.Kengeki38 = function(arg0, arg1, arg2)
    local f52_local0 = 0
    local f52_local1 = 0
    local f52_local2 = arg0:GetNinsatsuNum()
    local f52_local3 = arg0:GetRandam_Int(1, 100)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3030, TARGET_ENE_0, 999, f52_local0, f52_local1, 0, 0)
    if f52_local2 <= 1 then
        if f52_local3 <= 75 then
            arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3067, TARGET_ENE_0, 9999, 0, 0)
        else
            arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)
        end
    else
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)
    end
end

Goal.Kengeki39 = function(arg0, arg1, arg2)
    local f53_local0 = 0
    local f53_local1 = 0
    local f53_local2 = 999 - arg0:GetMapHitRadius(TARGET_SELF)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3034, TARGET_ENE_0, f53_local2, f53_local0, f53_local1, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3036, TARGET_ENE_0, 999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki40 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3028, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetTimer(6, 50)
end

Goal.Kengeki43 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3062, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetNumber(2, 1)
end

Goal.Kengeki44 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3067, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetNumber(2, 1)
end

Goal.Kengeki45 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3045, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetNumber(0, 0)
end

Goal.Kengeki46 = function(arg0, arg1, arg2)
    local f58_local5 = arg0:GetRandam_Int(30, 45)
    arg1:ClearSubGoal()
    local f58_local6 = arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3039, TARGET_ENE_0, 9999, 0, 0)
    f58_local6:TimingSetTimer(4, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, 0, f58_local5, true, true, -1)
end

Goal.Kengeki47 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    local f59_local0 = arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3038, TARGET_ENE_0, 9999, 0, 0)
    f59_local0:TimingSetTimer(4, 10, AI_TIMING_SET__UPDATE_SUCCESS)
end




Goal.NoAction = function(arg0, arg1, arg2)
    return -1
end

Goal.ActAfter_AdjustSpace = function(arg0, arg1, arg2)

end

Goal.Update = function(arg0, arg1, arg2)
    return default_update(arg0, arg1, arg2)
end

Goal.Terminate = function(arg0, arg1, arg2)

end
