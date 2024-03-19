RegisterTableGoal(GOAL_Genan_118000_Battle, "GOAL_Genan_118000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Genan_118000_Battle, true)
Goal.Initialize = function (arg0, arg1, arg2, arg3)
    
end

Goal.Activate = function (arg0, arg1, arg2)
    Init_Pseudo_Global(arg1, arg2)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = arg1:GetSp(TARGET_SELF)
    local f2_local5 = arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = arg1:GetDistY(TARGET_ENE_0)
    local f2_local7 = arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local8 = Check_ReachAttack(arg1, 0)
    local f2_local9 = arg1:GetEventRequest()
    arg1:DeleteObserve(0)
    Set_ConsecutiveGuardCount_Interrupt(arg1)
    arg1:SetNumber(4, f2_local6)
    arg1:SetNumber(6, 0)
    if arg1:HasSpecialEffectId(TARGET_SELF, 3118060) then
        f2_local0[30] = 100
    elseif arg1:HasSpecialEffectId(TARGET_SELF, 200033) then
        f2_local0[40] = 100
    elseif Common_ActivateAct(arg1, arg2) then

    elseif f2_local8 ~= POSSIBLE_ATTACK then
        if f2_local7 == 1 and arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100
        elseif f2_local7 == 1 and arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100
        elseif f2_local8 == UNREACH_ATTACK then
            f2_local0[27] = 100
        elseif f2_local8 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[1] = 100
            f2_local0[4] = 100
        elseif f2_local8 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[1] = 100
            f2_local0[4] = 100
        else
            f2_local0[27] = 100
        end
    elseif arg1:HasSpecialEffectId(TARGET_SELF, 5026) and arg1:GetTimer(5) <= 0 then
        arg1:SetTimer(5, 15)
        if arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            f2_local0[31] = 100
        else
            f2_local0[7] = 100
        end
    elseif arg1:GetNumber(5) == 0 and f2_local3 <= 0.5 then
        arg1:SetTimer(5, 15)
        if arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            f2_local0[31] = 100
        else
            f2_local0[7] = 100
        end
    elseif arg1:HasSpecialEffectId(TARGET_ENE_0, 3118170) and f2_local5 <= 7 then
        f2_local0[23] = 100
    elseif f2_local7 == 1 and arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(arg1, arg2)
    elseif f2_local7 == 1 and arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(arg1, arg2) then
            f2_local0[4] = 100
        end
    elseif arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        if f2_local5 > 7 then
            f2_local0[21] = 100
            f2_local0[22] = 1
        elseif f2_local5 > 5 then
            f2_local0[21] = 100
            f2_local0[22] = 1
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            f2_local0[21] = 80
            f2_local0[3] = 100
        else
            f2_local0[21] = 80
            f2_local0[5] = 100
        end
    elseif f2_local6 > 1.8 or f2_local6 < -1.8 then
        f2_local0[1] = 100
        f2_local0[29] = 10
    elseif not arg1:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToB, f2_local5) and arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == true then
        f2_local0[1] = 100
        f2_local0[29] = 10
    elseif arg1:HasSpecialEffectId(TARGET_ENE_0, SP_PC_BREAK) then
        if f2_local5 >= 7 then
            f2_local0[2] = 100
        else
            f2_local0[4] = 100
        end
    elseif f2_local5 >= 7 then
        f2_local0[1] = 1
        f2_local0[2] = 100
        if arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            f2_local0[3] = 0
            f2_local0[4] = 100
            f2_local0[11] = 1
        else
            f2_local0[5] = 0
            f2_local0[6] = 0
            f2_local0[12] = 1
        end
    elseif f2_local5 >= 5 then
        f2_local0[1] = 100
        f2_local0[2] = 200
        if arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            f2_local0[3] = 150
            f2_local0[4] = 400
            f2_local0[11] = 100
        else
            f2_local0[5] = 900
            f2_local0[6] = 900
            f2_local0[12] = 100
        end
    elseif f2_local6 > 1.2 or f2_local6 < -1.2 then
        f2_local0[20] = 2000
    else
        f2_local0[1] = 100
        f2_local0[2] = 0
        if arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            f2_local0[3] = 100
            f2_local0[11] = 100
        else
            f2_local0[5] = 1000
            f2_local0[6] = 1000
            f2_local0[12] = 100
        end
    end
    if arg1:GetNumber(0) == 0 then

    else

    end
    if SpaceCheck(arg1, arg2, 45, 2) == false and SpaceCheck(arg1, arg2, -45, 2) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(arg1, arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(arg1, arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = get_weight_base_on_cooldown(arg1, arg2, 3009, 10, f2_local0[1], 1)
    f2_local0[2] = get_weight_base_on_cooldown(arg1, arg2, 3004, 5, f2_local0[2], 1)
    f2_local0[3] = get_weight_base_on_cooldown(arg1, arg2, 3005, 5, f2_local0[3], 1)
    f2_local0[4] = get_weight_base_on_cooldown(arg1, arg2, 3006, 8, f2_local0[4], 1)
    f2_local0[5] = get_weight_base_on_cooldown(arg1, arg2, 3007, 8, f2_local0[5], 1)
    f2_local0[6] = get_weight_base_on_cooldown(arg1, arg2, 3014, 8, f2_local0[6], 1)
    f2_local0[11] = get_weight_base_on_cooldown(arg1, arg2, 3011, 5, f2_local0[11], 1)
    f2_local0[12] = get_weight_base_on_cooldown(arg1, arg2, 3012, 5, f2_local0[12], 1)
    f2_local1[1] = REGIST_FUNC(arg1, arg2, arg0.Act01)
    f2_local1[2] = REGIST_FUNC(arg1, arg2, arg0.Act02)
    f2_local1[3] = REGIST_FUNC(arg1, arg2, arg0.Act03)
    f2_local1[4] = REGIST_FUNC(arg1, arg2, arg0.Act04)
    f2_local1[5] = REGIST_FUNC(arg1, arg2, arg0.Act05)
    f2_local1[6] = REGIST_FUNC(arg1, arg2, arg0.Act06)
    f2_local1[7] = REGIST_FUNC(arg1, arg2, arg0.Act07)
    f2_local1[11] = REGIST_FUNC(arg1, arg2, arg0.Act11)
    f2_local1[12] = REGIST_FUNC(arg1, arg2, arg0.Act12)
    f2_local1[20] = REGIST_FUNC(arg1, arg2, arg0.Act20)
    f2_local1[21] = REGIST_FUNC(arg1, arg2, arg0.Act21)
    f2_local1[22] = REGIST_FUNC(arg1, arg2, arg0.Act22)
    f2_local1[23] = REGIST_FUNC(arg1, arg2, arg0.Act23)
    f2_local1[24] = REGIST_FUNC(arg1, arg2, arg0.Act24)
    f2_local1[25] = REGIST_FUNC(arg1, arg2, arg0.Act25)
    f2_local1[26] = REGIST_FUNC(arg1, arg2, arg0.Act26)
    f2_local1[27] = REGIST_FUNC(arg1, arg2, arg0.Act27)
    f2_local1[28] = REGIST_FUNC(arg1, arg2, arg0.Act28)
    f2_local1[29] = REGIST_FUNC(arg1, arg2, arg0.Act29)
    f2_local1[30] = REGIST_FUNC(arg1, arg2, arg0.Act30)
    f2_local1[31] = REGIST_FUNC(arg1, arg2, arg0.Act31)
    f2_local1[40] = REGIST_FUNC(arg1, arg2, arg0.Act40)
    f2_local1[41] = REGIST_FUNC(arg1, arg2, arg0.Act41)
    local f2_local10 = REGIST_FUNC(arg1, arg2, arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(arg1, arg2, f2_local0, f2_local1, f2_local10, f2_local2)
    
end

Goal.Act01 = function (arg0, arg1, arg2)
    local f3_local0 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f3_local2 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f3_local3 = 0
    local f3_local4 = 0
    local f3_local5 = 30
    local f3_local6 = 30
    Approach_Act_Flex(arg0, arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 3000
    local f3_local8 = 3001
    local f3_local9 = 3009
    local f3_local10 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local11 = 5.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local12 = 0
    local f3_local13 = 0
    local f3_local14 = arg0:GetRandam_Int(1, 100)
    if f3_local14 <= 60 then
        arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local7, TARGET_ENE_0, f3_local10, f3_local12, f3_local13, 0, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f3_local8, TARGET_ENE_0, f3_local11, 0)
        local f3_local15 = arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local9, TARGET_ENE_0, 9999, 0, 0)
        f3_local15:TimingSetNumber(0, 1, AI_TIMING_SET__ACTIVATE)
    else
        arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local7, TARGET_ENE_0, f3_local10, f3_local12, f3_local13, 0, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f3_local8, TARGET_ENE_0, f3_local11, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f3_local9, TARGET_ENE_0, f3_local10, 0)
        local f3_local15 = arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local8, TARGET_ENE_0, 9999, 0, 0)
        f3_local15:TimingSetNumber(0, 1, AI_TIMING_SET__ACTIVATE)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (arg0, arg1, arg2)
    local f4_local0 = 7 - arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 7 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f4_local2 = 7 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f4_local3 = 3002
    local f4_local4 = 3003
    local f4_local5 = 3004
    local f4_local6 = 0
    local f4_local7 = 0
    local f4_local8 = 9999
    local f4_local9 = 90
    local f4_local10 = 7 - arg0:GetMapHitRadius(TARGET_SELF)
    arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f4_local9, f4_local10)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f4_local3, TARGET_ENE_0, f4_local8, f4_local6, f4_local7, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f4_local4, TARGET_ENE_0, f4_local8, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f4_local4, TARGET_ENE_0, f4_local8, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f4_local4, TARGET_ENE_0, f4_local8, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f4_local4, TARGET_ENE_0, f4_local8, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f4_local5, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (arg0, arg1, arg2)
    local f5_local0 = 4.4 - arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 4.4 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f5_local2 = 4.4 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 10
    local f5_local6 = 10
    Approach_Act_Flex(arg0, arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 3005
    local f5_local8 = 0
    local f5_local9 = 0
    local f5_local10 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local7, TARGET_ENE_0, 9999, f5_local8, f5_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (arg0, arg1, arg2)
    local f6_local0 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f6_local2 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f6_local3 = 0
    local f6_local4 = 0
    local f6_local5 = 10
    local f6_local6 = 10
    Approach_Act_Flex(arg0, arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 3006
    local f6_local8 = 0
    local f6_local9 = 0
    local f6_local10 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local7, TARGET_ENE_0, 9999, f6_local8, f6_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (arg0, arg1, arg2)
    local f7_local0 = 4.3 - arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 4.3 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f7_local2 = 4.3 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f7_local3 = 0
    local f7_local4 = 0
    local f7_local5 = 10
    local f7_local6 = 10
    Approach_Act_Flex(arg0, arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 3007
    local f7_local8 = 3008
    local f7_local9 = 3010
    local f7_local10 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local11 = 4.3 - arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local12 = 0
    local f7_local13 = 0
    local f7_local14 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f7_local7, TARGET_ENE_0, f7_local10, f7_local12, f7_local13, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f7_local8, TARGET_ENE_0, f7_local11, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f7_local9, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (arg0, arg1, arg2)
    local f8_local0 = 3.7 - arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 3.7 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f8_local2 = 3.7 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f8_local3 = 0
    local f8_local4 = 0
    local f8_local5 = 10
    local f8_local6 = 10
    Approach_Act_Flex(arg0, arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 3014
    local f8_local8 = 0
    local f8_local9 = 0
    local f8_local10 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local7, TARGET_ENE_0, 9999, f8_local8, f8_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (arg0, arg1, arg2)
    arg0:SetNumber(5, 1)
    local f9_local0 = 9.2 - arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 9.2 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f9_local2 = 9.2 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f9_local3 = 0
    local f9_local4 = 0
    local f9_local5 = 10
    local f9_local6 = 10
    Approach_Act_Flex(arg0, arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 3021
    local f9_local8 = 0
    local f9_local9 = 0
    local f9_local10 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local7, TARGET_ENE_0, 9999, f9_local8, f9_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (arg0, arg1, arg2)
    local f10_local0 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f10_local2 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f10_local3 = 0
    local f10_local4 = 0
    local f10_local5 = 10
    local f10_local6 = 10
    Approach_Act_Flex(arg0, arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    local f10_local7 = 3000
    local f10_local8 = 3001
    local f10_local9 = 3009
    local f10_local10 = 3011
    local f10_local11 = 3013
    local f10_local12 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local13 = 5.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local14 = 5.9 - arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local15 = 4 - arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local16 = 0
    local f10_local17 = 0
    local f10_local18 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f10_local7, TARGET_ENE_0, f10_local14, f10_local16, f10_local17, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f10_local10, TARGET_ENE_0, f10_local15, 0)
    local f10_local19 = arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f10_local11, TARGET_ENE_0, 9999, 0, 0)
    f10_local19:TimingSetNumber(0, 11, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (arg0, arg1, arg2)
    local f11_local0 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f11_local2 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f11_local3 = 0
    local f11_local4 = 0
    local f11_local5 = 10
    local f11_local6 = 10
    Approach_Act_Flex(arg0, arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    local f11_local7 = 3000
    local f11_local8 = 3001
    local f11_local9 = 3012
    local f11_local10 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local11 = 6.4 - arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local12 = 0
    local f11_local13 = 0
    local f11_local14 = arg0:GetRandam_Int(1, 100)
    local f11_local15 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f11_local7, TARGET_ENE_0, f11_local10, f11_local12, f11_local13, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f11_local8, TARGET_ENE_0, f11_local11, 0)
    local f11_local16 = arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f11_local9, TARGET_ENE_0, 9999, 0, 0)
    f11_local16:TimingSetNumber(0, 12, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (arg0, arg1, arg2)
    local f12_local0 = 0.5
    local f12_local1 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f12_local2 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f12_local3 = 100
    local f12_local4 = 0
    local f12_local5 = 10
    local f12_local6 = 10
    arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 0.5, TARGET_SELF, true, -1)
    arg0:SetNumber(6, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (arg0, arg1, arg2)
    local f13_local0 = 3
    local f13_local1 = 45
    arg1:AddSubGoal(GOAL_COMMON_Turn, f13_local0, TARGET_ENE_0, f13_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (arg0, arg1, arg2)
    local f14_local0 = 3
    local f14_local1 = 0
    if SpaceCheck(arg0, arg1, -45, 2) == true then
        if SpaceCheck(arg0, arg1, 45, 2) == true then
            if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local0, 5202, TARGET_ENE_0, f14_local1, AI_DIR_TYPE_L, 0)
            else
                arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local0, 5203, TARGET_ENE_0, f14_local1, AI_DIR_TYPE_R, 0)
            end
        else
            arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local0, 5202, TARGET_ENE_0, f14_local1, AI_DIR_TYPE_L, 0)
        end
    elseif SpaceCheck(arg0, arg1, 45, 2) == true then
        arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local0, 5203, TARGET_ENE_0, f14_local1, AI_DIR_TYPE_R, 0)
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (arg0, arg1, arg2)
    arg0:SetNumber(6, 1)
    local f15_local0 = arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = arg0:GetSp(TARGET_SELF)
    local f15_local2 = 20
    local f15_local3 = arg0:GetRandam_Int(1, 100)
    local f15_local4 = -1
    local f15_local5 = 0
    if SpaceCheck(arg0, arg1, -90, 1) == true then
        if SpaceCheck(arg0, arg1, 90, 1) == true then
            if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f15_local5 = 0
            else
                f15_local5 = 1
            end
        else
            f15_local5 = 0
        end
    elseif SpaceCheck(arg0, arg1, 90, 1) == true then
        f15_local5 = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    local f15_local6 = 2
    local f15_local7 = arg0:GetRandam_Int(5, 7)
    arg0:SetNumber(10, f15_local5)
    local f15_local8 = arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f15_local6, TARGET_ENE_0, f15_local5, f15_local7, true, true, f15_local4)
    f15_local8:TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (arg0, arg1, arg2)
    local f16_local0 = arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = 3
    local f16_local2 = 0
    local f16_local3 = 5201
    if SpaceCheck(arg0, arg1, 180, 2) == true then
        if SpaceCheck(arg0, arg1, 180, 4) == true then
            if f16_local0 > 4 then

            else
                f16_local3 = 5211
            end
        end
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local1, f16_local3, TARGET_ENE_0, f16_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (arg0, arg1, arg2)
    local f17_local0 = arg0:GetRandam_Float(2, 4)
    local f17_local1 = arg0:GetRandam_Float(1, 3)
    local f17_local2 = arg0:GetDist(TARGET_ENE_0)
    local f17_local3 = -1
    if SpaceCheck(arg0, arg1, 180, 1) == true then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f17_local0, TARGET_ENE_0, f17_local1, TARGET_ENE_0, true, f17_local3)
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (arg0, arg1, arg2)
    local f19_local0 = arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(arg0, arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f19_local1 = 0
    local f19_local2 = SpaceCheck_SidewayMove(arg0, arg1, 1)
    if f19_local2 == 0 then
        f19_local1 = 0
    elseif f19_local2 == 1 then
        f19_local1 = 1
    elseif f19_local2 == 2 then
        if f19_local0 <= 50 then
            f19_local1 = 0
        else
            f19_local1 = 1
        end
    else
        arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    arg0:SetNumber(10, f19_local1)
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f19_local1, arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (arg0, arg1, arg2)
    local f20_local0 = arg0:GetDist(TARGET_ENE_0)
    local f20_local1 = 1.5
    local f20_local2 = 1.5
    local f20_local3 = arg0:GetRandam_Int(30, 45)
    local f20_local4 = -1
    local f20_local5 = arg0:GetRandam_Int(0, 1)
    if f20_local0 <= 3 then
        arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f20_local1, TARGET_ENE_0, f20_local5, f20_local3, true, true, f20_local4)
    else
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f20_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (arg0, arg1, arg2)
    local f21_local0 = 1
    local f21_local1 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f21_local2 = 5.4 - arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f21_local3 = 100
    local f21_local4 = 0
    local f21_local5 = 10
    local f21_local6 = 10
    arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, f21_local0, TARGET_SELF, true, -1)
    arg0:SetNumber(6, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3004, TARGET_ENE_0, 9999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (arg0, arg1, arg2)
    arg0:SetNumber(5, 1)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (arg0, arg1, arg2)
    local f24_local0 = arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = 90
    local f24_local2 = 7 - arg0:GetMapHitRadius(TARGET_SELF)
    arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f24_local1, f24_local2)
    if f24_local0 <= 5 - arg0:GetMapHitRadius(TARGET_SELF) then
        arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    else
        arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3002, TARGET_ENE_0, 9999, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 9999, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 9999, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 9999, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 9999, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (arg0, arg1, arg2)
    local f25_local0 = 3.5
    local f25_local1 = arg0:GetRandam_Int(30, 45)
    local f25_local2 = 0
    if SpaceCheck(arg0, arg1, -90, 1) == true then
        if SpaceCheck(arg0, arg1, 90, 1) == true then
            if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f25_local2 = 0
            else
                f25_local2 = 1
            end
        else
            f25_local2 = 0
        end
    elseif SpaceCheck(arg0, arg1, 90, 1) == true then
        f25_local2 = 1
    else

    end
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f25_local0, TARGET_ENE_0, f25_local2, f25_local1, true, true, -1)
    return GETWELLSPACE_ODDS
    
end

Goal.Interrupt = function (arg0, arg1, arg2)
    local f26_local0 = arg1:GetDist(TARGET_ENE_0)
    local f26_local1 = arg1:GetSp(TARGET_SELF)
    local f26_local2 = arg1:GetSpecialEffectActivateInterruptType(0)
    if arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if arg1:IsInterupt(INTERUPT_Damaged) and arg1:GetNumber(6) == 1 then
        arg1:SetNumber(6, 0)
        arg1:Replanning()
        return true
    end
    if Interupt_PC_Break(arg1) then
        arg1:Replanning()
        return true
    end
    if arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then

    else

    end
    if arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and arg1:IsInsideObserve(0) then
        arg1:Replanning()
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (arg0, arg1, arg2)
    
end

Goal.Update = function (arg0, arg1, arg2)
    return default_update(arg0, arg1, arg2)
    
end

Goal.Terminate = function (arg0, arg1, arg2)
    
end


