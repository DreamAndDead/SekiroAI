RegisterTableGoal(GOAL_Ochimusha_katate_101000_Battle, "Ochimusha_katate_101000_Battle")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_Ochimusha_katate_101000_Battle, true)
Goal.Initialize = function(arg0, arg1, arg2, arg3)

end

Goal.Activate = function(goal, arg1, arg2)
    Init_Pseudo_Global(arg1, arg2)
    arg1:SetStringIndexedNumber("Dist_Step_Small", 2)
    arg1:SetStringIndexedNumber("Dist_Step_Large", 4)
    arg1:SetStringIndexedNumber("KengekiID", 0)
    arg1:SetStringIndexedNumber("KaihukuSp", 30)
    if goal:Kengeki_Activate(arg1, arg2) then
        return
    end
    arg1:SetStringIndexedNumber("targetWhich", TARGET_ENE_0)
    if not not arg1:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 120, 9999) or arg1:HasSpecialEffectId(TARGET_SELF, 220020) then
        arg1:SetStringIndexedNumber("karaburiDist", 0)
    else
        arg1:SetStringIndexedNumber("karaburiDist", 2)
    end

    local act_weight_list = {}
    local act_func_list = {}
    local default_act_param_list = {}
    
    Common_Clear_Param(act_weight_list, act_func_list, default_act_param_list)

    local f2_local9 = arg1:GetSpRate(TARGET_SELF)
    local f2_local10 = arg1:GetDist(TARGET_ENE_0)
    local f2_local12 = arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    
    -- 变招输入的观察点，会引发变招 int
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 107900)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109220)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109221)

    Set_ConsecutiveGuardCount_Interrupt(arg1)

    if arg1:HasSpecialEffectId(TARGET_ENE_0, 3170200) then
        act_weight_list[25] = 1000
        act_weight_list[1] = 1
    elseif arg1:HasSpecialEffectId(TARGET_ENE_0, 3101540) then
        act_weight_list[27] = 100
    elseif Common_ActivateAct(arg1, arg2) then

    elseif arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false or not not arg1:HasSpecialEffectId(TARGET_ENE_0, 109220) or arg1:HasSpecialEffectId(TARGET_ENE_0, 109221) then
        act_weight_list[7] = 100
        act_weight_list[27] = 100
    elseif arg1:HasSpecialEffectId(TARGET_SELF, 107900) and arg1:GetNumber(12) == 1 then
        arg1:SetNumber(12, 0)
        act_weight_list[6] = 100
    elseif f2_local12 == 1 and arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(arg1, arg2)
    elseif f2_local12 == 1 and arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(arg1, arg2) then
            act_weight_list[1] = 50
            act_weight_list[2] = 50
            act_weight_list[7] = 100
        end
    elseif arg1:HasSpecialEffectId(TARGET_SELF, 310000) then
        act_weight_list[23] = 100
    elseif arg1:HasSpecialEffectId(TARGET_SELF, 310001) then
        act_weight_list[1] = 10
    elseif arg1:HasSpecialEffectId(TARGET_SELF, 310020) then
        if f2_local9 < 0.4 then
            act_weight_list[12] = 100
            act_weight_list[1] = 1
            act_weight_list[3] = 1
            act_weight_list[11] = 1
        else
            act_weight_list[1] = 10
            act_weight_list[3] = 10
            act_weight_list[11] = 10
        end
    elseif arg1:HasSpecialEffectId(TARGET_SELF, 310060) then
        act_weight_list[1] = 10
        act_weight_list[14] = 10
        act_weight_list[15] = 10
        act_weight_list[23] = 10
    elseif arg1:HasSpecialEffectId(TARGET_SELF, 310090) then
        act_weight_list[1] = 10
        act_weight_list[3] = 10
        act_weight_list[11] = 10
    elseif f2_local10 >= 7 then
        if not (not arg1:HasSpecialEffectId(TARGET_SELF, 200050) or arg1:GetNumber(5) ~= 0) or arg1:HasSpecialEffectId(TARGET_ENE_0, 100002) then
            act_weight_list[8] = 100
            act_weight_list[9] = 100
        elseif arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) then
            act_weight_list[23] = 100
        elseif arg1:IsTargetGuard(TARGET_ENE_0) then
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
    elseif f2_local10 >= 5 then
        if arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) then
            act_weight_list[23] = 100
        elseif arg1:IsTargetGuard(TARGET_ENE_0) then
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
    elseif f2_local10 >= 3 then
        if arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) then
            act_weight_list[24] = 100
            act_weight_list[25] = 100
        elseif arg1:IsTargetGuard(TARGET_ENE_0) then
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
    elseif f2_local10 >= 1 then
        if arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) then
            act_weight_list[24] = 100
            act_weight_list[25] = 100
        elseif arg1:IsTargetGuard(TARGET_ENE_0) then
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
    elseif arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) then
        act_weight_list[24] = 100
        act_weight_list[25] = 100
    elseif arg1:IsTargetGuard(TARGET_ENE_0) then
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
    if arg1:IsFinishTimer(0) == false then
        act_weight_list[12] = 0
    end
    if SpaceCheck(arg1, arg2, 45, arg1:GetStringIndexedNumber("Dist_Step_Small")) == false and SpaceCheck(arg1, arg2, -45, arg1:GetStringIndexedNumber("Dist_Step_Small")) == false then
        act_weight_list[22] = 0
    end
    if SpaceCheck(arg1, arg2, 90, 1) == false and SpaceCheck(arg1, arg2, -90, 1) == false then
        act_weight_list[23] = 0
    end
    if SpaceCheck(arg1, arg2, 180, arg1:GetStringIndexedNumber("Dist_Step_Small")) == false then
        act_weight_list[24] = 0
    end
    if SpaceCheck(arg1, arg2, 180, 1) == false then
        act_weight_list[25] = 0
    end

    act_weight_list[1] = SetCoolTime(arg1, arg2, 3000, 5, act_weight_list[1], 1)
    act_weight_list[2] = SetCoolTime(arg1, arg2, 3002, 5, act_weight_list[2], 1)
    act_weight_list[3] = SetCoolTime(arg1, arg2, 3003, 5, act_weight_list[3], 1)
    act_weight_list[4] = SetCoolTime(arg1, arg2, 3004, 10, act_weight_list[4], 1)
    act_weight_list[5] = SetCoolTime(arg1, arg2, 3005, 10, act_weight_list[5], 1)
    act_weight_list[6] = SetCoolTime(arg1, arg2, 3008, 10, act_weight_list[6], 1)
    act_weight_list[7] = SetCoolTime(arg1, arg2, 3009, 5, act_weight_list[7], 1)
    act_weight_list[8] = SetCoolTime(arg1, arg2, 3010, 15, act_weight_list[8], 1)
    act_weight_list[9] = SetCoolTime(arg1, arg2, 3011, 15, act_weight_list[9], 1)
    act_weight_list[11] = SetCoolTime(arg1, arg2, 3012, 5, act_weight_list[11], 1)
    act_weight_list[14] = SetCoolTime(arg1, arg2, 3014, 5, act_weight_list[14], 1)
    act_weight_list[15] = SetCoolTime(arg1, arg2, 3015, 5, act_weight_list[15], 1)
    act_weight_list[24] = SetCoolTime(arg1, arg2, 5211, 5, act_weight_list[24], 1)

    act_func_list[1] = REGIST_FUNC(arg1, arg2, goal.Act01)
    act_func_list[2] = REGIST_FUNC(arg1, arg2, goal.Act02)
    act_func_list[3] = REGIST_FUNC(arg1, arg2, goal.Act03)
    act_func_list[4] = REGIST_FUNC(arg1, arg2, goal.Act04)
    act_func_list[5] = REGIST_FUNC(arg1, arg2, goal.Act05)
    act_func_list[6] = REGIST_FUNC(arg1, arg2, goal.Act06)
    act_func_list[7] = REGIST_FUNC(arg1, arg2, goal.Act07)
    act_func_list[8] = REGIST_FUNC(arg1, arg2, goal.Act08)
    act_func_list[9] = REGIST_FUNC(arg1, arg2, goal.Act09)
    act_func_list[10] = REGIST_FUNC(arg1, arg2, goal.Act10)
    act_func_list[11] = REGIST_FUNC(arg1, arg2, goal.Act11)
    act_func_list[12] = REGIST_FUNC(arg1, arg2, goal.Act12)
    act_func_list[13] = REGIST_FUNC(arg1, arg2, goal.Act13)
    act_func_list[14] = REGIST_FUNC(arg1, arg2, goal.Act14)
    act_func_list[15] = REGIST_FUNC(arg1, arg2, goal.Act15)
    act_func_list[21] = REGIST_FUNC(arg1, arg2, goal.Act21)
    act_func_list[22] = REGIST_FUNC(arg1, arg2, goal.Act22)
    act_func_list[23] = REGIST_FUNC(arg1, arg2, goal.Act23)
    act_func_list[24] = REGIST_FUNC(arg1, arg2, goal.Act24)
    act_func_list[25] = REGIST_FUNC(arg1, arg2, goal.Act25)
    act_func_list[26] = REGIST_FUNC(arg1, arg2, goal.Act26)
    act_func_list[27] = REGIST_FUNC(arg1, arg2, goal.Act27)
    act_func_list[28] = REGIST_FUNC(arg1, arg2, goal.Act28)
    act_func_list[41] = REGIST_FUNC(arg1, arg2, goal.Act41)

    local act_after_adjust_space = REGIST_FUNC(arg1, arg2, goal.ActAfter_AdjustSpace)

    Common_Battle_Activate(arg1, arg2, act_weight_list, act_func_list, act_after_adjust_space, default_act_param_list)
end

Goal.Act01 = function(arg0, arg1, arg2)
    local dist_to_player = arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF) + arg0:GetStringIndexedNumber("karaburiDist")
    local f3_local2 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local3 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local4 = 100
    local f3_local5 = 0
    local f3_local6 = 1.5
    local f3_local7 = 3

    if f3_local1 < dist_to_player then
        Approach_Act_Flex(arg0, arg1, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6, f3_local7)
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
    local f5_local0 = arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 7.1 - arg0:GetMapHitRadius(TARGET_SELF) + arg0:GetStringIndexedNumber("karaburiDist")
    local f5_local2 = 7.1 - arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f5_local3 = 7.1 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local4 = 100
    local f5_local5 = 0
    local f5_local6 = 1.5
    local f5_local7 = 3

    if f5_local1 < f5_local0 then
        Approach_Act_Flex(arg0, arg1, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6, f5_local7)
    elseif arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end

    local f5_local8 = 3003
    local f5_local9 = 0.5
    local f5_local10 = 90
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local8, arg0:GetStringIndexedNumber("targetWhich"), 9999,
        f5_local9, f5_local10, 0, 0)

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

    local f7_local8 = 3005
    local f7_local9 = 3007
    local f7_local10 = 3.4 - arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f7_local11 = 0.5
    local f7_local12 = 90

    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f7_local8, arg0:GetStringIndexedNumber("targetWhich"),
        f7_local10, f7_local11, f7_local12, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f7_local9, arg0:GetStringIndexedNumber("targetWhich"), 9999, 0, 0)
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
    local f9_local0 = arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 12 - arg0:GetMapHitRadius(TARGET_SELF) + arg0:GetStringIndexedNumber("karaburiDist")
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
    local f23_local0 = arg0:GetSp(TARGET_SELF)
    local f23_local1 = 0
    local f23_local2 = arg0:GetRandam_Int(1, 100)
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

Goal.Interrupt = function(goal, arg1, arg2)
    local interupt_sp = arg1:GetSpecialEffectActivateInterruptType(0)
    if arg1:IsLadderAct(TARGET_SELF) then
        return false
    end

    if not arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end

    if interupt_sp == 109031 then
        arg1:Replanning()
        return true
    end

    if arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if interupt_sp == 107900 then
            arg1:SetNumber(12, 1)
            arg2:ClearSubGoal()
            arg1:Replanning()
            return true
        elseif interupt_sp == 109220 or interupt_sp == 109221 then
            arg1:Replanning()
            return true
        end
    end

    if arg1:IsInterupt(INTERUPT_ParryTiming) and not arg1:HasSpecialEffectId(TARGET_ENE_0, 3502520) then
        return Common_Parry(arg1, arg2, 50, 25, 0, 3102)
    end

    if arg1:IsInterupt(INTERUPT_LoseSightTarget) and arg1:IsActiveGoal(GOAL_COMMON_SidewayMove) then
        if arg1:GetNumber(10) == 0 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 1, arg1:GetRandam_Int(30, 45), true, true, -1)
        elseif arg1:GetNumber(10) == 1 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 0, arg1:GetRandam_Int(30, 45), true, true, -1)
        end
        return true
    end

    if arg1:IsInterupt(INTERUPT_ShootImpact) and goal.ShootReaction(arg1, arg2) then
        return true
    end

    return false
end

Goal.ShootReaction = function(arg0, arg1)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
    return true
end

Goal.Kengeki_Activate = function(goal, arg1, arg2)
    local kengeki_sp = ReturnKengekiSpecialEffect(arg1)
    if kengeki_sp == 0 then
        return false
    end

    local act_weight_list = {}
    local act_func_list = {}
    local act_default_param_list = {}
    Common_Clear_Param(act_weight_list, act_func_list, act_default_param_list)

    local dist_to_player = arg1:GetDist(TARGET_ENE_0)

    if kengeki_sp == 200200 or kengeki_sp == 200205 then
        if dist_to_player >= 2.7 then

        -- 0.2 是不是太近了？难道在空中？
        elseif dist_to_player <= 0.2 and SpaceCheck(arg1, arg2, 180, arg1:GetStringIndexedNumber("Dist_Step_Large")) == true then
            act_weight_list[30] = 50
            act_weight_list[50] = 50
        else
            act_weight_list[1] = 100
            act_weight_list[2] = 100
            act_weight_list[50] = 50
        end
    elseif kengeki_sp == 200201 or kengeki_sp == 200206 then
        if dist_to_player >= 2.7 then

        elseif dist_to_player <= 0.2 and SpaceCheck(arg1, arg2, 180, arg1:GetStringIndexedNumber("Dist_Step_Large")) == true then
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

        elseif kengeki_sp == 200210 and arg1:HasSpecialEffectId(TARGET_SELF, 310080) then
            act_weight_list[3] = 100
        elseif kengeki_sp == 200215 and arg1:HasSpecialEffectId(TARGET_SELF, 310080) then
            act_weight_list[4] = 100
            act_weight_list[7] = 100
        else
            act_weight_list[5] = 0
            act_weight_list[50] = 100
        end
    elseif kengeki_sp == 200211 or kengeki_sp == 200216 then
        if dist_to_player >= 2.7 then

        elseif dist_to_player <= 0.2 then

        elseif kengeki_sp == 200211 and arg1:HasSpecialEffectId(TARGET_SELF, 310080) then
            act_weight_list[3] = 100
        elseif kengeki_sp == 200216 and arg1:HasSpecialEffectId(TARGET_SELF, 310080) then
            act_weight_list[4] = 100
            act_weight_list[7] = 100
        else
            act_weight_list[7] = 0
            act_weight_list[50] = 100
        end
    end

    act_func_list[1] = REGIST_FUNC(arg1, arg2, goal.Kengeki01)
    act_func_list[2] = REGIST_FUNC(arg1, arg2, goal.Kengeki02)
    act_func_list[3] = REGIST_FUNC(arg1, arg2, goal.Kengeki03)
    act_func_list[4] = REGIST_FUNC(arg1, arg2, goal.Kengeki04)
    act_func_list[5] = REGIST_FUNC(arg1, arg2, goal.Kengeki05)
    act_func_list[6] = REGIST_FUNC(arg1, arg2, goal.Kengeki06)
    act_func_list[7] = REGIST_FUNC(arg1, arg2, goal.Kengeki07)
    act_func_list[8] = REGIST_FUNC(arg1, arg2, goal.Kengeki08)
    act_func_list[21] = REGIST_FUNC(arg1, arg2, goal.Act21)
    act_func_list[22] = REGIST_FUNC(arg1, arg2, goal.Act22)
    act_func_list[23] = REGIST_FUNC(arg1, arg2, goal.Act23)
    act_func_list[24] = REGIST_FUNC(arg1, arg2, goal.Act24)
    act_func_list[25] = REGIST_FUNC(arg1, arg2, goal.Act25)
    act_func_list[30] = REGIST_FUNC(arg1, arg2, goal.Kengeki30)
    act_func_list[50] = REGIST_FUNC(arg1, arg2, goal.NoAction)

    local f29_local8 = REGIST_FUNC(arg1, arg2, goal.ActAfter_AdjustSpace)

    return Common_Kengeki_Activate(arg1, arg2, act_weight_list, act_func_list, f29_local8, act_default_param_list)
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
    return Update_Default_NoSubGoal(arg0, arg1, arg2)
end

Goal.Terminate = function(arg0, arg1, arg2)

end
