RegisterTableGoal(GOAL_Ochimusha_katate_101000_Battle, "Ochimusha_katate_101000_Battle")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_Ochimusha_katate_101000_Battle, true)

Goal.Initialize = function(arg0, arg1, arg2, arg3)

end

Goal.Activate = function(goal, self, goal_manager)
    Init_Pseudo_Global(self, goal_manager)

    self:SetStringIndexedNumber("Dist_Step_Small", 2)
    self:SetStringIndexedNumber("Dist_Step_Large", 4)
    self:SetStringIndexedNumber("KengekiID", 0)
    self:SetStringIndexedNumber("KaihukuSp", 30)

    -- 先执行交锋计划
    if goal:Kengeki_Activate(self, goal_manager) then
        return
    end

    self:SetStringIndexedNumber("targetWhich", TARGET_ENE_0)
    -- 和傀儡忍杀有关？
    if self:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 120, 9999) or self:HasSpecialEffectId(TARGET_SELF, SP_PUPPET_SHINOBI) then
        self:SetStringIndexedNumber("karaburiDist", 0)
    else
        self:SetStringIndexedNumber("karaburiDist", 2)
    end

    local act_weight_list = {}
    local act_func_list = {}
    local default_act_param_list = {}
    Common_Clear_Param(act_weight_list, act_func_list, default_act_param_list)

    local sp_rate = self:GetSpRate(TARGET_SELF)
    local dist_to_player = self:GetDist(TARGET_ENE_0)
    -- NpcThinkParam -> thinkAttrDoAdmirer 属性
    local think_attr_do_admirer = self:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    
    -- 变招输入的 sp 观察点，会引发变招信号
    self:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
    self:AddObserveSpecialEffectAttribute(TARGET_SELF, 107900)
    self:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109220)
    self:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109221)

    Set_ConsecutiveGuardCount_Interrupt(self)

    -- 和火炎攻击相关
    if self:HasSpecialEffectId(TARGET_ENE_0, 3170200) then
        act_weight_list[25] = 1000
        act_weight_list[1] = 1
    -- 铃婆npc相关
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 3101540) then
        act_weight_list[27] = 100
    elseif Common_ActivateAct(self, goal_manager) then

    -- 悬挂隐蔽？
    elseif self:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false or self:HasSpecialEffectId(TARGET_ENE_0, 109220) or self:HasSpecialEffectId(TARGET_ENE_0, 109221) then
        act_weight_list[7] = 100
        act_weight_list[27] = 100
    -- 指笛相关？
    elseif self:HasSpecialEffectId(TARGET_SELF, 107900) and self:GetNumber(12) == 1 then
        self:SetNumber(12, 0)
        act_weight_list[6] = 100
    elseif think_attr_do_admirer == 1 and self:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(self, goal_manager)
    elseif think_attr_do_admirer == 1 and self:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(self, goal_manager) then
            act_weight_list[1] = 50
            act_weight_list[2] = 50
            act_weight_list[7] = 100
        end
    -- 横移
    elseif self:HasSpecialEffectId(TARGET_SELF, 310000) then
        act_weight_list[23] = 100
    -- 攻击并横移
    elseif self:HasSpecialEffectId(TARGET_SELF, 310001) then
        act_weight_list[1] = 10
    -- 回避
    elseif self:HasSpecialEffectId(TARGET_SELF, 310020) then
        if sp_rate < 0.4 then
            act_weight_list[12] = 100
            act_weight_list[1] = 1
            act_weight_list[3] = 1
            act_weight_list[11] = 1
        else
            act_weight_list[1] = 10
            act_weight_list[3] = 10
            act_weight_list[11] = 10
        end
    -- 崩躯干
    elseif self:HasSpecialEffectId(TARGET_SELF, 310060) then
        act_weight_list[1] = 10
        act_weight_list[14] = 10
        act_weight_list[15] = 10
        act_weight_list[23] = 10
    -- ？
    elseif self:HasSpecialEffectId(TARGET_SELF, 310090) then
        act_weight_list[1] = 10
        act_weight_list[3] = 10
        act_weight_list[11] = 10
    elseif dist_to_player >= 7 then
        if not (not self:HasSpecialEffectId(TARGET_SELF, 200050) or self:GetNumber(5) ~= 0) or self:HasSpecialEffectId(TARGET_ENE_0, 100002) then
            act_weight_list[8] = 100
            act_weight_list[9] = 100
        elseif self:HasSpecialEffectId(TARGET_ENE_0, 109031) then
            act_weight_list[23] = 100
        elseif self:IsTargetGuard(TARGET_ENE_0) then
            act_weight_list[1] = 0
            act_weight_list[2] = 0
            act_weight_list[3] = 100
            act_weight_list[4] = 0
            act_weight_list[5] = 200
            act_weight_list[6] = 0
            act_weight_list[7] = 0
            act_weight_list[11] = 0
        else
            act_weight_list[1] = 0
            act_weight_list[2] = 100
            act_weight_list[3] = 200
            act_weight_list[4] = 0
            act_weight_list[5] = 0
            act_weight_list[6] = 0
            act_weight_list[7] = 0
            act_weight_list[11] = 0
        end
    elseif dist_to_player >= 5 then
        if self:HasSpecialEffectId(TARGET_ENE_0, 109031) then
            act_weight_list[23] = 100
        elseif self:IsTargetGuard(TARGET_ENE_0) then
            act_weight_list[1] = 0
            act_weight_list[2] = 200
            act_weight_list[3] = 100
            act_weight_list[4] = 0
            act_weight_list[5] = 200
            act_weight_list[6] = 0
            act_weight_list[7] = 0
            act_weight_list[11] = 0
        else
            act_weight_list[1] = 100
            act_weight_list[2] = 200
            act_weight_list[3] = 100
            act_weight_list[4] = 0
            act_weight_list[5] = 0
            act_weight_list[6] = 100
            act_weight_list[7] = 0
            act_weight_list[11] = 100
        end
    elseif dist_to_player >= 3 then
        if self:HasSpecialEffectId(TARGET_ENE_0, 109031) then
            act_weight_list[24] = 100
            act_weight_list[25] = 100
        elseif self:IsTargetGuard(TARGET_ENE_0) then
            act_weight_list[1] = 100
            act_weight_list[2] = 0
            act_weight_list[3] = 0
            act_weight_list[4] = 0
            act_weight_list[5] = 300
            act_weight_list[6] = 100
            act_weight_list[7] = 0
            act_weight_list[11] = 100
        else
            act_weight_list[1] = 100
            act_weight_list[2] = 0
            act_weight_list[3] = 0
            act_weight_list[4] = 0
            act_weight_list[5] = 0
            act_weight_list[6] = 100
            act_weight_list[7] = 0
            act_weight_list[11] = 100
        end
    elseif dist_to_player >= 1 then
        if self:HasSpecialEffectId(TARGET_ENE_0, 109031) then
            act_weight_list[24] = 100
            act_weight_list[25] = 100
        elseif self:IsTargetGuard(TARGET_ENE_0) then
            act_weight_list[1] = 100
            act_weight_list[2] = 0
            act_weight_list[3] = 0
            act_weight_list[4] = 0
            act_weight_list[5] = 300
            act_weight_list[6] = 100
            act_weight_list[7] = 0
            act_weight_list[11] = 100
            act_weight_list[24] = 0
        else
            act_weight_list[1] = 200
            act_weight_list[2] = 0
            act_weight_list[3] = 0
            act_weight_list[4] = 0
            act_weight_list[5] = 0
            act_weight_list[6] = 200
            act_weight_list[7] = 0
            act_weight_list[11] = 200
            act_weight_list[24] = 0
        end
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 109031) then
        act_weight_list[24] = 100
        act_weight_list[25] = 100
    elseif self:IsTargetGuard(TARGET_ENE_0) then
        act_weight_list[1] = 100
        act_weight_list[2] = 0
        act_weight_list[3] = 0
        act_weight_list[4] = 0
        act_weight_list[5] = 300
        act_weight_list[6] = 100
        act_weight_list[7] = 0
        act_weight_list[11] = 100
        act_weight_list[24] = 0
    else
        act_weight_list[1] = 200
        act_weight_list[2] = 0
        act_weight_list[3] = 0
        act_weight_list[4] = 0
        act_weight_list[5] = 0
        act_weight_list[6] = 200
        act_weight_list[7] = 0
        act_weight_list[11] = 200
        act_weight_list[24] = 50
    end

    if self:IsFinishTimer(0) == false then
        act_weight_list[12] = 0
    end

    -- 四周如果有障碍，取消相应方向的移动
    if SpaceCheck(self, goal_manager, 45, self:GetStringIndexedNumber("Dist_Step_Small")) == false and SpaceCheck(self, goal_manager, -45, self:GetStringIndexedNumber("Dist_Step_Small")) == false then
        act_weight_list[22] = 0
    end
    if SpaceCheck(self, goal_manager, 90, 1) == false and SpaceCheck(self, goal_manager, -90, 1) == false then
        act_weight_list[23] = 0
    end
    if SpaceCheck(self, goal_manager, 180, self:GetStringIndexedNumber("Dist_Step_Small")) == false then
        act_weight_list[24] = 0
    end
    if SpaceCheck(self, goal_manager, 180, 1) == false then
        act_weight_list[25] = 0
    end

    act_weight_list[1] = get_weight_base_on_cooldown(self, goal_manager, 3000, 5, act_weight_list[1], 1)
    act_weight_list[2] = get_weight_base_on_cooldown(self, goal_manager, 3002, 5, act_weight_list[2], 1)
    act_weight_list[3] = get_weight_base_on_cooldown(self, goal_manager, 3003, 5, act_weight_list[3], 1)
    act_weight_list[4] = get_weight_base_on_cooldown(self, goal_manager, 3004, 10, act_weight_list[4], 1)
    act_weight_list[5] = get_weight_base_on_cooldown(self, goal_manager, 3005, 10, act_weight_list[5], 1)
    act_weight_list[6] = get_weight_base_on_cooldown(self, goal_manager, 3008, 10, act_weight_list[6], 1)
    act_weight_list[7] = get_weight_base_on_cooldown(self, goal_manager, 3009, 5, act_weight_list[7], 1)
    act_weight_list[8] = get_weight_base_on_cooldown(self, goal_manager, 3010, 15, act_weight_list[8], 1)
    act_weight_list[9] = get_weight_base_on_cooldown(self, goal_manager, 3011, 15, act_weight_list[9], 1)
    act_weight_list[11] = get_weight_base_on_cooldown(self, goal_manager, 3012, 5, act_weight_list[11], 1)
    act_weight_list[14] = get_weight_base_on_cooldown(self, goal_manager, 3014, 5, act_weight_list[14], 1)
    act_weight_list[15] = get_weight_base_on_cooldown(self, goal_manager, 3015, 5, act_weight_list[15], 1)
    act_weight_list[24] = get_weight_base_on_cooldown(self, goal_manager, 5211, 5, act_weight_list[24], 1)

    act_func_list[1] = REGIST_FUNC(self, goal_manager, goal.Act01)
    act_func_list[2] = REGIST_FUNC(self, goal_manager, goal.Act02)
    act_func_list[3] = REGIST_FUNC(self, goal_manager, goal.Act03)
    act_func_list[4] = REGIST_FUNC(self, goal_manager, goal.Act04)
    act_func_list[5] = REGIST_FUNC(self, goal_manager, goal.Act05)
    act_func_list[6] = REGIST_FUNC(self, goal_manager, goal.Act06)
    act_func_list[7] = REGIST_FUNC(self, goal_manager, goal.Act07)
    act_func_list[8] = REGIST_FUNC(self, goal_manager, goal.Act08)
    act_func_list[9] = REGIST_FUNC(self, goal_manager, goal.Act09)
    act_func_list[10] = REGIST_FUNC(self, goal_manager, goal.Act10)
    act_func_list[11] = REGIST_FUNC(self, goal_manager, goal.Act11)
    act_func_list[12] = REGIST_FUNC(self, goal_manager, goal.Act12)
    act_func_list[13] = REGIST_FUNC(self, goal_manager, goal.Act13)
    act_func_list[14] = REGIST_FUNC(self, goal_manager, goal.Act14)
    act_func_list[15] = REGIST_FUNC(self, goal_manager, goal.Act15)
    act_func_list[21] = REGIST_FUNC(self, goal_manager, goal.Act21)
    act_func_list[22] = REGIST_FUNC(self, goal_manager, goal.Act22)
    act_func_list[23] = REGIST_FUNC(self, goal_manager, goal.Act23)
    act_func_list[24] = REGIST_FUNC(self, goal_manager, goal.Act24)
    act_func_list[25] = REGIST_FUNC(self, goal_manager, goal.Act25)
    act_func_list[26] = REGIST_FUNC(self, goal_manager, goal.Act26)
    act_func_list[27] = REGIST_FUNC(self, goal_manager, goal.Act27)
    act_func_list[28] = REGIST_FUNC(self, goal_manager, goal.Act28)
    act_func_list[41] = REGIST_FUNC(self, goal_manager, goal.Act41)

    local act_after_adjust_space = REGIST_FUNC(self, goal_manager, goal.ActAfter_AdjustSpace)

    Common_Battle_Activate(self, goal_manager, act_weight_list, act_func_list, act_after_adjust_space, default_act_param_list)
end

Goal.Act01 = function(arg0, arg1, arg2)
    local dist_to_player = arg0:GetDist(TARGET_ENE_0)
    local approach_dist = 2.5 - arg0:GetMapHitRadius(TARGET_SELF) + arg0:GetStringIndexedNumber("karaburiDist")
    local min_dist = 2.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local max_dist = 2.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local4 = 100
    local f3_local5 = 0
    local f3_local6 = 1.5
    local f3_local7 = 3

    if approach_dist < dist_to_player then
        Approach_Act_Flex(arg0, arg1, approach_dist, min_dist, max_dist, f3_local4, f3_local5, f3_local6, f3_local7)
    elseif arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end

    local f3_local10 = 4 - arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local11 = 0.5
    local f3_local12 = 90

    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, arg0:GetStringIndexedNumber("targetWhich"),
        f3_local10, f3_local11, f3_local12, 0, 0)

    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, arg0:GetStringIndexedNumber("targetWhich"), 9999, 0, 0)

    if arg0:HasSpecialEffectId(TARGET_SELF, 310060) then
        arg0:SetNumber(1, 1)
    end
end

Goal.Act02 = function(arg0, arg1, arg2)
    local f4_local0 = arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 7 - arg0:GetMapHitRadius(TARGET_SELF) + arg0:GetStringIndexedNumber("karaburiDist")
    local f4_local2 = 7 - arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local3 = 7 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local4 = 100
    local f4_local5 = 0
    local f4_local6 = 1.5
    local f4_local7 = 3

    if f4_local1 < f4_local0 then
        Approach_Act_Flex(arg0, arg1, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6, f4_local7)
    elseif arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end

    local f4_local8 = 3002
    local f4_local9 = 0.5
    local f4_local10 = 90
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local8, arg0:GetStringIndexedNumber("targetWhich"), DistToAtt1,
        f4_local9, f4_local10, 0, 0)

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act03 = function(arg0, arg1, arg2)
    local dist_to_pc = arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 7.1 - arg0:GetMapHitRadius(TARGET_SELF) + arg0:GetStringIndexedNumber("karaburiDist")
    local f5_local2 = 7.1 - arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f5_local3 = 7.1 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local4 = 100
    local f5_local5 = 0
    local f5_local6 = 1.5
    local f5_local7 = 3

    if f5_local1 < dist_to_pc then
        Approach_Act_Flex(arg0, arg1, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6, f5_local7)
    elseif arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end

    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, arg0:GetStringIndexedNumber("targetWhich"), 9999, 0.5, 90, 0, 0)

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act04 = function(arg0, arg1, arg2)
    local f6_local0 = arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 3.1 - arg0:GetMapHitRadius(TARGET_SELF) + arg0:GetStringIndexedNumber("karaburiDist")
    local f6_local2 = 3.1 - arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f6_local3 = 3.1 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local4 = 100
    local f6_local5 = 0
    local f6_local6 = 1.5
    local f6_local7 = 3

    if f6_local1 < f6_local0 then
        Approach_Act_Flex(arg0, arg1, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6, f6_local7)
    elseif arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end

    local f6_local8 = 3004
    local f6_local9 = 3006
    local f6_local10 = 3.7 - arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f6_local11 = 0.5
    local f6_local12 = 90

    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f6_local8, arg0:GetStringIndexedNumber("targetWhich"),
        f6_local10, f6_local11, f6_local12, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f6_local9, arg0:GetStringIndexedNumber("targetWhich"), 9999, 0, 0)
end

Goal.Act05 = function(arg0, arg1, arg2)
    local f7_local0 = arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 3.7 - arg0:GetMapHitRadius(TARGET_SELF) + arg0:GetStringIndexedNumber("karaburiDist")
    local f7_local2 = 3.7 - arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f7_local3 = 3.7 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local4 = 100
    local f7_local5 = 0
    local f7_local6 = 1.5
    local f7_local7 = 3

    if f7_local1 < f7_local0 then
        Approach_Act_Flex(arg0, arg1, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7)
    elseif arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end

    local f7_local10 = 3.4 - arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f7_local11 = 0.5
    local f7_local12 = 90

    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3005, arg0:GetStringIndexedNumber("targetWhich"),
        f7_local10, f7_local11, f7_local12, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, arg0:GetStringIndexedNumber("targetWhich"), 9999, 0, 0)
end

Goal.Act06 = function(arg0, arg1, arg2)
    local f8_local0 = arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 4.7 - arg0:GetMapHitRadius(TARGET_SELF) + arg0:GetStringIndexedNumber("karaburiDist")
    local f8_local2 = 4.7 - arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f8_local3 = 4.7 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local4 = 100
    local f8_local5 = 0
    local f8_local6 = 1.5
    local f8_local7 = 3

    if f8_local1 < f8_local0 then
        Approach_Act_Flex(arg0, arg1, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6, f8_local7)
    elseif arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end

    local f8_local8 = 3008
    local f8_local9 = 0.5
    local f8_local10 = 90

    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local8, arg0:GetStringIndexedNumber("targetWhich"), 9999,
        f8_local9, f8_local10, 0, 0)

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act07 = function(arg0, arg1, arg2)
    local f9_local8 = 3009
    local f9_local9 = 0.5
    local f9_local10 = 90

    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local8, arg0:GetStringIndexedNumber("targetWhich"), 9999,
        f9_local9, f9_local10, 0, 0)

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act08 = function(arg0, arg1, arg2)
    arg0:SetNumber(5, 1)
    local f10_local0 = arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 5 - arg0:GetMapHitRadius(TARGET_SELF)

    if arg0:HasSpecialEffectId(TARGET_ENE_0, 109900) then
        f10_local1 = f10_local1 + 4
    end

    local f10_local2 = f10_local1 + 0
    local f10_local3 = f10_local1 + 2
    local f10_local4 = 100
    local f10_local5 = 0
    local f10_local6 = 1.5
    local f10_local7 = 3

    if f10_local1 < f10_local0 then
        Approach_Act_Flex(arg0, arg1, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6, f10_local7)
    end

    local f10_local8 = 3010
    local f10_local9 = 0.5
    local f10_local10 = 90

    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f10_local8, arg0:GetStringIndexedNumber("targetWhich"), 9999,
        f10_local9, f10_local10, 0, 0)

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act09 = function(arg0, arg1, arg2)
    arg0:SetNumber(5, 1)
    local f11_local0 = arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 7.6 - arg0:GetMapHitRadius(TARGET_SELF)
    if arg0:HasSpecialEffectId(TARGET_ENE_0, 109900) then
        f11_local1 = f11_local1 + 4
    end

    local f11_local2 = f11_local1 + 0
    local f11_local3 = f11_local1 + 2
    local f11_local4 = 100
    local f11_local5 = 0
    local f11_local6 = 1.5
    local f11_local7 = 3

    if f11_local1 < f11_local0 then
        Approach_Act_Flex(arg0, arg1, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6, f11_local7)
    end

    local f11_local8 = 3011
    local f11_local9 = 0.5
    local f11_local10 = 90

    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f11_local8, arg0:GetStringIndexedNumber("targetWhich"), 9999,
        f11_local9, f11_local10, 0, 0)

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act10 = function(arg0, arg1, arg2)
    arg0:SetEventMoveTarget(9622518)
    arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, POINT_EVENT, 2, TARGET_SELF, false, -1)

    local f12_local0 = 3013
    local f12_local1 = 0.5
    local f12_local2 = 90
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f12_local0, POINT_EVENT, 9999, f12_local1, f12_local2, 0, 0)
end

Goal.Act11 = function(arg0, arg1, arg2)
    local f13_local0 = arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF) + arg0:GetStringIndexedNumber("karaburiDist")
    local f13_local2 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f13_local3 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local4 = 100
    local f13_local5 = 0
    local f13_local6 = 1.5
    local f13_local7 = 3

    if f13_local1 < f13_local0 then
        Approach_Act_Flex(arg0, arg1, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6, f13_local7)
    elseif arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end

    local f13_local8 = 3012
    local f13_local9 = 0.5
    local f13_local10 = 90
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local8, arg0:GetStringIndexedNumber("targetWhich"), 9999,
        f13_local9, f13_local10, 0, 0)

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act12 = function(arg0, arg1, arg2)
    local f14_local0 = arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 0.5
    local f14_local2 = 90

    if f14_local0 <= 5 and SpaceCheck(arg0, arg1, 180, 4) == true then
        arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5211, arg0:GetStringIndexedNumber("targetWhich"), 9999, 0,
            0)
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3030, TARGET_SELF, 9999, f14_local1, f14_local2, 0, 0)
    else
        arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_SELF, 9999, f14_local1, f14_local2, 0, 0)
    end

    arg0:SetTimer(0, 10)
end

Goal.Act13 = function(arg0, arg1, arg2)
    arg0:SetNumber(5, 1)
    local f15_local0 = 3011
    local f15_local1 = 0.5
    local f15_local2 = 90
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f15_local0, TARGET_EVENT, 9999, f15_local1, f15_local2, 0, 0)

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act14 = function(arg0, arg1, arg2)
    local f16_local0 = arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local2 = 5 - arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f16_local3 = 5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f16_local4 = 100
    local f16_local5 = 0
    local f16_local6 = 1.5
    local f16_local7 = 3

    if f16_local1 < f16_local0 then
        Approach_Act_Flex(arg0, arg1, f16_local1, f16_local2, f16_local3, f16_local4, f16_local5, f16_local6, f16_local7)
    end

    local f16_local8 = 3013
    local f16_local9 = 0.5
    local f16_local10 = 90

    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f16_local8, TARGET_ENE_0, 9999, f16_local9, f16_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act15 = function(arg0, arg1, arg2)
    local f17_local0 = arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local2 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f17_local3 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f17_local4 = 100
    local f17_local5 = 0
    local f17_local6 = 1.5
    local f17_local7 = 3

    if f17_local1 < f17_local0 then
        Approach_Act_Flex(arg0, arg1, f17_local1, f17_local2, f17_local3, f17_local4, f17_local5, f17_local6, f17_local7)
    end

    local f17_local8 = 3014
    local f17_local9 = 0.5
    local f17_local10 = 90
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f17_local8, TARGET_ENE_0, 9999, f17_local9, f17_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act41 = function(arg0, arg1, arg2)
    local f18_local0 = 3.5
    local f18_local1 = arg0:GetRandam_Int(30, 45)
    local f18_local2 = 0

    if SpaceCheck(arg0, arg1, -90, 1) == true then
        if SpaceCheck(arg0, arg1, 90, 1) == true then
            if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f18_local2 = 0
            else
                f18_local2 = 1
            end
        else
            f18_local2 = 0
        end
    elseif SpaceCheck(arg0, arg1, 90, 1) == true then
        f18_local2 = 1
    else

    end

    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f18_local0, TARGET_ENE_0, f18_local2, f18_local1, true, true, -1)
    return GETWELLSPACE_ODDS
end

Goal.Act21 = function(arg0, arg1, arg2)
    local f19_local0 = 3
    local f19_local1 = 45
    if arg0:IsTargetGuard(TARGET_SELF) then
        arg1:AddSubGoal(GOAL_COMMON_Turn, f19_local0, TARGET_ENE_0, f19_local1, 9910, GOAL_RESULT_Success, true)
    else
        arg1:AddSubGoal(GOAL_COMMON_Turn, f19_local0, TARGET_ENE_0, f19_local1, -1, GOAL_RESULT_Success, true)
    end

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act22 = function(arg0, arg1, arg2)
    local f20_local0 = 3
    local f20_local1 = 0

    if SpaceCheck(arg0, arg1, -45, arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
        if SpaceCheck(arg0, arg1, 45, arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
            if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5202, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_L, 0)
            else
                arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5203, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_R, 0)
            end
        else
            arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5202, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_L, 0)
        end
    elseif SpaceCheck(arg0, arg1, 45, arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
        arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5203, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_R, 0)
    else

    end

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act23 = function(arg0, arg1, arg2)
    local f21_local0 = arg0:GetSp(TARGET_SELF)
    local f21_local1 = 0
    local f21_local2 = arg0:GetRandam_Int(1, 100)
    local f21_local3 = -1
    local f21_local4 = 0
    if f21_local1 <= f21_local0 and f21_local2 <= 0 then
        f21_local3 = 9910
    end

    if SpaceCheck(arg0, arg1, -90, 1) == true then
        if SpaceCheck(arg0, arg1, 90, 1) == true then
            if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f21_local4 = 1
            else
                f21_local4 = 0
            end
        else
            f21_local4 = 0
        end
    elseif SpaceCheck(arg0, arg1, 90, 1) == true then
        f21_local4 = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end

    local f21_local5 = 1.8
    local f21_local6 = arg0:GetRandam_Int(30, 45)
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f21_local5, TARGET_ENE_0, f21_local4, f21_local6, true, true, f21_local3)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act24 = function(arg0, arg1, arg2)
    local f22_local0 = arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = 3
    local f22_local2 = 0

    if SpaceCheck(arg0, arg1, 180, arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
        if SpaceCheck(arg0, arg1, 180, arg0:GetStringIndexedNumber("Dist_Step_Large")) == true then
            if f22_local0 > 4 then
                arg1:AddSubGoal(GOAL_COMMON_SpinStep, f22_local1, 5201, TARGET_ENE_0, f22_local2, AI_DIR_TYPE_B, 0)
            else
                arg1:AddSubGoal(GOAL_COMMON_SpinStep, f22_local1, 5211, TARGET_ENE_0, f22_local2, AI_DIR_TYPE_B, 0)
            end
        else
            arg1:AddSubGoal(GOAL_COMMON_SpinStep, f22_local1, 5201, TARGET_ENE_0, f22_local2, AI_DIR_TYPE_B, 0)
        end
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act25 = function(arg0, arg1, arg2)
    local f23_local3 = -1
    local f23_local4 = arg0:GetRandam_Float(3, 5)
    local f23_local5 = 5
    if arg0:HasSpecialEffectId(TARGET_ENE_0, 3170200) then
        f23_local5 = 999
    end

    if SpaceCheck(arg0, arg1, 180, 1) == true then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f23_local4, TARGET_ENE_0, f23_local5, TARGET_ENE_0, true, f23_local3)
    elseif f23_local3 == 9910 then
        arg1:AddSubGoal(GOAL_COMMON_Guard, f23_local4, 9910, TARGET_ENE_0, false, 0)
    else
        arg1:AddSubGoal(GOAL_COMMON_Wait, 5, TARGET_SELF, 0, 0, 0)
    end

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act26 = function(arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Act27 = function(arg0, arg1, arg2)
    local f25_local0 = arg0:GetRandam_Int(1, 100)

    if YousumiAct_SubGoal(arg0, arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end

    local f25_local1 = 0
    local f25_local2 = SpaceCheck_SidewayMove(arg0, arg1, 1)
    if f25_local2 == 0 then
        f25_local1 = 0
    elseif f25_local2 == 1 then
        f25_local1 = 1
    elseif f25_local2 == 2 then
        if f25_local0 <= 50 then
            f25_local1 = 0
        else
            f25_local1 = 1
        end
    else
        arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end

    arg0:SetNumber(10, f25_local1)
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f25_local1, arg0:GetRandam_Int(30, 45), true, true, -1)

    return GET_WELL_SPACE_ODDS
end

Goal.Act28 = function(arg0, arg1, arg2)
    local f26_local0 = arg0:GetDist(TARGET_ENE_0)
    local f26_local1 = 1.5
    local f26_local2 = arg0:GetRandam_Int(30, 45)
    local f26_local3 = -1
    local f26_local4 = 0

    if f26_local0 <= 3 then
        if SpaceCheck(arg0, arg1, -90, 1) == true then
            if SpaceCheck(arg0, arg1, 90, 1) == true then
                if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                    f26_local4 = 1
                else
                    f26_local4 = 0
                end
            else
                f26_local4 = 0
            end
        elseif SpaceCheck(arg0, arg1, 90, 1) == true then
            f26_local4 = 1
        else
            GetWellSpace_Odds = 100
            return GetWellSpace_Odds
        end

        arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f26_local1, TARGET_ENE_0, f26_local4, f26_local2, true, true, f26_local3)
    elseif f26_local0 <= 8 then
        Approach_Act_Flex(arg0, arg1, 3, 3, 3, 100, 0, 1.5, 3)
    else
        Approach_Act_Flex(arg0, arg1, 8, 999, 999, 0, 0, 1.5, 3)
    end

    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

Goal.Interrupt = function(goal, self, goal_manager)
    local interupt_sp = self:GetSpecialEffectActivateInterruptType(0)

    if self:IsLadderAct(TARGET_SELF) then
        return false
    end

    -- 非战斗状态
    if not self:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end

    if interupt_sp == 109031 then
        self:Replanning()
        return true
    end

    if self:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if interupt_sp == 107900 then
            self:SetNumber(12, 1)
            goal_manager:ClearSubGoal()
            self:Replanning()
            return true
        elseif interupt_sp == 109220 or interupt_sp == 109221 then
            self:Replanning()
            return true
        end
    end

    if self:IsInterupt(INTERUPT_ParryTiming) and not self:HasSpecialEffectId(TARGET_ENE_0, 3502520) then
        return Common_Parry(self, goal_manager, 50, 25, 0, 3102)
    end

    if self:IsInterupt(INTERUPT_LoseSightTarget) and self:IsActiveGoal(GOAL_COMMON_SidewayMove) then
        if self:GetNumber(10) == 0 then
            goal_manager:ClearSubGoal()
            goal_manager:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 1, self:GetRandam_Int(30, 45), true, true, -1)
        elseif self:GetNumber(10) == 1 then
            goal_manager:ClearSubGoal()
            goal_manager:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 0, self:GetRandam_Int(30, 45), true, true, -1)
        end
        return true
    end

    if self:IsInterupt(INTERUPT_ShootImpact) and goal.ShootReaction(self, goal_manager) then
        return true
    end

    return false
end

Goal.ShootReaction = function(self, goal_manager)
    goal_manager:ClearSubGoal()
    goal_manager:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
    return true
end

--[[
    return true if activate any kengeki act
]]
Goal.Kengeki_Activate = function(goal, self, goal_manager)
    local kengeki_sp = get_kengeki_sp(self)

    if kengeki_sp == 0 then
        return false
    end

    local act_weight_list = {}
    local act_func_list = {}
    local act_default_param_list = {}
    Common_Clear_Param(act_weight_list, act_func_list, act_default_param_list)

    local dist_to_player = self:GetDist(TARGET_ENE_0)

    if kengeki_sp == 200200 or kengeki_sp == 200205 then
        if dist_to_player >= 2.7 then

        -- 0.2 是不是太近了？难道在空中？
        elseif dist_to_player <= 0.2 and SpaceCheck(self, goal_manager, 180, self:GetStringIndexedNumber("Dist_Step_Large")) == true then
            act_weight_list[30] = 50
            act_weight_list[50] = 50
        else
            act_weight_list[1] = 100
            act_weight_list[2] = 100
            act_weight_list[50] = 50
        end
    elseif kengeki_sp == 200201 or kengeki_sp == 200206 then
        if dist_to_player >= 2.7 then

        elseif dist_to_player <= 0.2 and SpaceCheck(self, goal_manager, 180, self:GetStringIndexedNumber("Dist_Step_Large")) == true then
            act_weight_list[30] = 50
            act_weight_list[50] = 50
        else
            act_weight_list[3] = 100
            act_weight_list[4] = 100
            act_weight_list[50] = 50
        end
    elseif kengeki_sp == 200210 or kengeki_sp == 200215 then
        if dist_to_player >= 2.7 then

        elseif dist_to_player <= 0.2 then

        elseif kengeki_sp == 200210 and self:HasSpecialEffectId(TARGET_SELF, 310080) then
            act_weight_list[3] = 100
        elseif kengeki_sp == 200215 and self:HasSpecialEffectId(TARGET_SELF, 310080) then
            act_weight_list[4] = 100
            act_weight_list[7] = 100
        else
            act_weight_list[5] = 0
            act_weight_list[50] = 100
        end
    elseif kengeki_sp == 200211 or kengeki_sp == 200216 then
        if dist_to_player >= 2.7 then

        elseif dist_to_player <= 0.2 then

        elseif kengeki_sp == 200211 and self:HasSpecialEffectId(TARGET_SELF, 310080) then
            act_weight_list[3] = 100
        elseif kengeki_sp == 200216 and self:HasSpecialEffectId(TARGET_SELF, 310080) then
            act_weight_list[4] = 100
            act_weight_list[7] = 100
        else
            act_weight_list[7] = 0
            act_weight_list[50] = 100
        end
    end

    -- 横斩 右
    act_func_list[1] = REGIST_FUNC(self, goal_manager, goal.Kengeki01)
    -- 纵斩 上
    act_func_list[2] = REGIST_FUNC(self, goal_manager, goal.Kengeki02)
    -- 横斩 左
    act_func_list[3] = REGIST_FUNC(self, goal_manager, goal.Kengeki03)
    -- 纵斩 上
    act_func_list[4] = REGIST_FUNC(self, goal_manager, goal.Kengeki04)
    -- 纵斩 右上
    act_func_list[5] = REGIST_FUNC(self, goal_manager, goal.Kengeki05)
    -- 踢击
    act_func_list[6] = REGIST_FUNC(self, goal_manager, goal.Kengeki06)
    -- 十字斩
    act_func_list[7] = REGIST_FUNC(self, goal_manager, goal.Kengeki07)
    -- 纵斩
    act_func_list[8] = REGIST_FUNC(self, goal_manager, goal.Kengeki08)

    act_func_list[21] = REGIST_FUNC(self, goal_manager, goal.Act21)
    act_func_list[22] = REGIST_FUNC(self, goal_manager, goal.Act22)
    act_func_list[23] = REGIST_FUNC(self, goal_manager, goal.Act23)
    act_func_list[24] = REGIST_FUNC(self, goal_manager, goal.Act24)
    act_func_list[25] = REGIST_FUNC(self, goal_manager, goal.Act25)
    -- 小步后撤
    act_func_list[30] = REGIST_FUNC(self, goal_manager, goal.Kengeki30)
    -- 无行动
    act_func_list[50] = REGIST_FUNC(self, goal_manager, goal.NoAction)

    local act_after_adjust_space = REGIST_FUNC(self, goal_manager, goal.ActAfter_AdjustSpace)

    return Common_Kengeki_Activate(self, goal_manager, act_weight_list, act_func_list, act_after_adjust_space, act_default_param_list)
end

Goal.Kengeki01 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3050, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki02 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3051, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki03 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3055, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki04 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3056, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki05 = function(arg0, arg1, arg2)
    arg0:SetNumber(0, 1)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3070, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki06 = function(arg0, arg1, arg2)
    arg0:SetNumber(0, 0)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3071, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki07 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3075, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki08 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3076, TARGET_ENE_0, 9999, 0, 0)
end

Goal.Kengeki30 = function(arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 2, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0)
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
