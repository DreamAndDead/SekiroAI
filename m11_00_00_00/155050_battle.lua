RegisterTableGoal(GOAL_Yatou_KatanaMain_155050_Battle, "GOAL_Yatou_KatanaMain_155050_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Yatou_KatanaMain_155050_Battle, true)
Goal.Initialize = function (arg0, arg1, arg2, arg3)
    
end

Goal.Activate = function (arg0, arg1, arg2)
    Init_Pseudo_Global(arg1, arg2)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200200)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200201)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200205)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200206)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200210)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200211)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200215)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200216)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3155020)
    if arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) then
        if arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[26] = 100
        else
            f2_local0[21] = 100
        end
    elseif arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[27] = 100
    elseif f2_local4 == 1 and arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        f2_local0[28] = 200
    elseif f2_local4 == 1 and arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        f2_local0[28] = 200
    elseif arg1:HasSpecialEffectId(TARGET_ENE_0, 110030) then
        f2_local0[28] = 100
    elseif arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 1
    elseif f2_local3 >= 10 then
        f2_local0[7] = 100
        f2_local0[8] = 100
    elseif f2_local3 >= 7 then
        f2_local0[1] = 50
        f2_local0[2] = 50
        f2_local0[3] = 200
        f2_local0[4] = 50
        f2_local0[5] = 0
        f2_local0[7] = 100
        f2_local0[8] = 100
        f2_local0[15] = 100
    elseif f2_local3 >= 5 then
        f2_local0[1] = 50
        f2_local0[2] = 50
        f2_local0[3] = 100
        f2_local0[4] = 50
        f2_local0[5] = 0
        f2_local0[7] = 100
        f2_local0[8] = 100
        f2_local0[15] = 100
    elseif f2_local3 > 3 then
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[3] = 100
        f2_local0[4] = 50
        f2_local0[5] = 0
        f2_local0[7] = 0
        f2_local0[8] = 100
        f2_local0[15] = 100
    else
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[3] = 0
        f2_local0[4] = 100
        f2_local0[5] = 100
        f2_local0[7] = 0
        f2_local0[8] = 100
    end
    if SpaceCheck(arg1, arg2, 45, 2) == false and SpaceCheck(arg1, arg2, -45, 2) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(arg1, arg2, 90, 1) == false and SpaceCheck(arg1, arg2, -90, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(arg1, arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(arg1, arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = get_weight_base_on_cooldown(arg1, arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[2] = get_weight_base_on_cooldown(arg1, arg2, 3003, 5, f2_local0[2], 1)
    f2_local0[3] = get_weight_base_on_cooldown(arg1, arg2, 3005, 5, f2_local0[3], 1)
    f2_local0[4] = get_weight_base_on_cooldown(arg1, arg2, 3006, 5, f2_local0[4], 1)
    f2_local0[5] = get_weight_base_on_cooldown(arg1, arg2, 3008, 5, f2_local0[5], 1)
    f2_local0[6] = get_weight_base_on_cooldown(arg1, arg2, 3009, 5, f2_local0[6], 1)
    f2_local0[7] = get_weight_base_on_cooldown(arg1, arg2, 3010, 5, f2_local0[7], 1)
    f2_local0[8] = get_weight_base_on_cooldown(arg1, arg2, 3000, 5, f2_local0[8], 1)
    f2_local0[10] = get_weight_base_on_cooldown(arg1, arg2, 3030, 8, f2_local0[10], 1)
    f2_local0[11] = get_weight_base_on_cooldown(arg1, arg2, 3030, 8, f2_local0[11], 1)
    f2_local0[12] = get_weight_base_on_cooldown(arg1, arg2, 3000, 2, f2_local0[12], 1)
    f2_local0[13] = get_weight_base_on_cooldown(arg1, arg2, 3002, 2, f2_local0[12], 1)
    f2_local0[15] = get_weight_base_on_cooldown(arg1, arg2, 3007, 2, f2_local0[15], 1)
    f2_local1[1] = REGIST_FUNC(arg1, arg2, arg0.Act01)
    f2_local1[2] = REGIST_FUNC(arg1, arg2, arg0.Act02)
    f2_local1[3] = REGIST_FUNC(arg1, arg2, arg0.Act03)
    f2_local1[4] = REGIST_FUNC(arg1, arg2, arg0.Act04)
    f2_local1[5] = REGIST_FUNC(arg1, arg2, arg0.Act05)
    f2_local1[6] = REGIST_FUNC(arg1, arg2, arg0.Act06)
    f2_local1[7] = REGIST_FUNC(arg1, arg2, arg0.Act07)
    f2_local1[8] = REGIST_FUNC(arg1, arg2, arg0.Act08)
    f2_local1[10] = REGIST_FUNC(arg1, arg2, arg0.Act10)
    f2_local1[11] = REGIST_FUNC(arg1, arg2, arg0.Act11)
    f2_local1[12] = REGIST_FUNC(arg1, arg2, arg0.Act12)
    f2_local1[13] = REGIST_FUNC(arg1, arg2, arg0.Act13)
    f2_local1[15] = REGIST_FUNC(arg1, arg2, arg0.Act15)
    f2_local1[21] = REGIST_FUNC(arg1, arg2, arg0.Act21)
    f2_local1[22] = REGIST_FUNC(arg1, arg2, arg0.Act22)
    f2_local1[23] = REGIST_FUNC(arg1, arg2, arg0.Act23)
    f2_local1[24] = REGIST_FUNC(arg1, arg2, arg0.Act24)
    f2_local1[25] = REGIST_FUNC(arg1, arg2, arg0.Act25)
    f2_local1[26] = REGIST_FUNC(arg1, arg2, arg0.Act26)
    f2_local1[27] = REGIST_FUNC(arg1, arg2, arg0.Act27)
    f2_local1[28] = REGIST_FUNC(arg1, arg2, arg0.Act28)
    local f2_local5 = REGIST_FUNC(arg1, arg2, arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(arg1, arg2, f2_local0, f2_local1, f2_local5, f2_local2)
    
end

Goal.Act01 = function (arg0, arg1, arg2)
    local f3_local0 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f3_local2 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    local f3_local7 = arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(arg0, arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local8 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local9 = 3 - arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local10 = 0
    local f3_local11 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local10, f3_local11, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (arg0, arg1, arg2)
    local f4_local0 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(arg0, arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local8 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f4_local9 = 0
    local f4_local10 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, f4_local8, f4_local9, f4_local10, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (arg0, arg1, arg2)
    local f5_local0 = 6 - arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 6 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local2 = 6 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(arg0, arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (arg0, arg1, arg2)
    local f6_local0 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local2 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    Approach_Act_Flex(arg0, arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local8 = 3 - arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f6_local9 = 0
    local f6_local10 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3006, TARGET_ENE_0, f6_local8, f6_local9, f6_local10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (arg0, arg1, arg2)
    local f7_local0 = arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local4 = 100
    local f7_local5 = 0
    local f7_local6 = 1.5
    local f7_local7 = 3
    Approach_Act_Flex(arg0, arg1, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7)
    local f7_local8 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local9 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f7_local10 = 0
    local f7_local11 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3008, TARGET_ENE_0, f7_local9, f7_local10, f7_local11, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (arg0, arg1, arg2)
    local f8_local0 = arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 6.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 6.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local3 = 6.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local4 = 100
    local f8_local5 = 0
    local f8_local6 = 1.5
    local f8_local7 = 3
    Approach_Act_Flex(arg0, arg1, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6, f8_local7)
    local f8_local8 = 6.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local9 = 6.5 - arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f8_local10 = 0
    local f8_local11 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, f8_local9, f8_local10, f8_local11, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (arg0, arg1, arg2)
    local f9_local0 = arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 10 - arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 10 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local3 = 10 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local4 = 100
    local f9_local5 = 0
    local f9_local6 = 1.5
    local f9_local7 = 3
    local f9_local8 = 3010
    Approach_Act_Flex(arg0, arg1, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6, f9_local7)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (arg0, arg1, arg2)
    local f10_local0 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f10_local2 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    local f10_local7 = arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(arg0, arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    local f10_local8 = 3 - arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local9 = 0
    local f10_local10 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, DistToAtt1, f10_local9, f10_local10, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3012, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (arg0, arg1, arg2)
    local f11_local0 = 0
    local f11_local1 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, f11_local0, f11_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (arg0, arg1, arg2)
    local f12_local0 = 0
    local f12_local1 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, f12_local0, f12_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (arg0, arg1, arg2)
    local f13_local0 = arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 35 - arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local2 = 35 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local3 = 35 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local4 = 100
    local f13_local5 = 0
    local f13_local6 = 1.5
    local f13_local7 = 3
    Approach_Act_Flex(arg0, arg1, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6, f13_local7)
    local f13_local8 = 35 - arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local9 = 35 - arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f13_local10 = 0
    local f13_local11 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f13_local9, f13_local10, f13_local11, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (arg0, arg1, arg2)
    local f14_local0 = arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 35 - arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local2 = 35 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f14_local3 = 35 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f14_local4 = 100
    local f14_local5 = 0
    local f14_local6 = 1.5
    local f14_local7 = 3
    Approach_Act_Flex(arg0, arg1, f14_local1, f14_local2, f14_local3, f14_local4, f14_local5, f14_local6, f14_local7)
    local f14_local8 = 35 - arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local9 = 0
    local f14_local10 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3002, TARGET_ENE_0, DistToAtt2, f14_local9, f14_local10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (arg0, arg1, arg2)
    local f15_local0 = 0
    local f15_local1 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f15_local0, f15_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (arg0, arg1, arg2)
    local f16_local0 = 3
    local f16_local1 = 45
    arg1:AddSubGoal(GOAL_COMMON_Turn, f16_local0, TARGET_ENE_0, f16_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (arg0, arg1, arg2)
    local f17_local0 = 3
    local f17_local1 = 0
    if SpaceCheck(arg0, arg1, -45, 2) == true then
        if SpaceCheck(arg0, arg1, 45, 2) == true then
            if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local0, 5202, TARGET_ENE_0, f17_local1, AI_DIR_TYPE_L, 0)
            else
                arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local0, 5203, TARGET_ENE_0, f17_local1, AI_DIR_TYPE_R, 0)
            end
        else
            arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local0, 5202, TARGET_ENE_0, f17_local1, AI_DIR_TYPE_L, 0)
        end
    elseif SpaceCheck(arg0, arg1, 45, 2) == true then
        arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local0, 5203, TARGET_ENE_0, f17_local1, AI_DIR_TYPE_R, 0)
    else

    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (arg0, arg1, arg2)
    local f18_local0 = arg0:GetSp(TARGET_SELF)
    local f18_local1 = 0
    local f18_local2 = arg0:GetRandam_Int(1, 100)
    local f18_local3 = 9910
    local f18_local4 = 0
    if SpaceCheck(arg0, arg1, -90, 1) == true then
        if SpaceCheck(arg0, arg1, 90, 1) == true then
            if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f18_local4 = 1
            else
                f18_local4 = 0
            end
        else
            f18_local4 = 0
        end
    elseif SpaceCheck(arg0, arg1, 90, 1) == true then
        f18_local4 = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    local f18_local5 = 1.8
    local f18_local6 = arg0:GetRandam_Int(30, 45)
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f18_local5, TARGET_ENE_0, f18_local4, f18_local6, true, true, f18_local3)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (arg0, arg1, arg2)
    local f19_local0 = arg0:GetDist(TARGET_ENE_0)
    local f19_local1 = 3
    local f19_local2 = 0
    local f19_local3 = 5211
    if SpaceCheck(arg0, arg1, 180, 2) == true and SpaceCheck(arg0, arg1, 180, 4) == true then
        if f19_local0 > 4 then

        else
            f19_local3 = 5211
        end
    end
    arg1:AddSubGoal(GOAL_COMMON_SpinStep, f19_local1, f19_local3, TARGET_ENE_0, f19_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (arg0, arg1, arg2)
    local f20_local0 = arg0:GetRandam_Float(2, 4)
    local f20_local1 = arg0:GetRandam_Float(1, 3)
    local f20_local2 = arg0:GetDist(TARGET_ENE_0)
    local f20_local3 = -1
    if SpaceCheck(arg0, arg1, 180, 1) == true then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f20_local0, TARGET_ENE_0, f20_local1, TARGET_ENE_0, true, f20_local3)
    else

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
    local f22_local0 = arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = arg0:GetDistYSigned(TARGET_ENE_0)
    local f22_local2 = f22_local1 / math.tan(math.deg(30))
    local f22_local3 = arg0:GetRandam_Int(0, 1)
    if f22_local1 >= 3 then
        if f22_local2 + 1 <= f22_local0 then
            if SpaceCheck(arg0, arg1, 0, 4) == true then
                arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f22_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(arg0, arg1, 0, 3) == true then
                arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f22_local2, TARGET_SELF, true, -1)
            end
        elseif f22_local0 <= f22_local2 - 1 then
            arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f22_local2, TARGET_ENE_0, true, -1)
        end
    elseif SpaceCheck(arg0, arg1, 0, 4) == true then
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(arg0, arg1, 0, 3) == true then
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(arg0, arg1, 0, 1) == false then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    end
    arg0:SetNumber(10, f22_local3)
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f22_local3, arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (arg0, arg1, arg2)
    local f23_local0 = arg0:GetDist(TARGET_ENE_0)
    local f23_local1 = 1.5
    local f23_local2 = 1.5
    local f23_local3 = arg0:GetRandam_Int(30, 45)
    local f23_local4 = -1
    local f23_local5 = arg0:GetRandam_Int(0, 1)
    if f23_local0 <= 3 then
        arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f23_local1, TARGET_ENE_0, f23_local5, f23_local3, true, true, f23_local4)
    elseif f23_local0 <= 8 then
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f23_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f23_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (arg0, arg1, arg2)
    local f24_local0 = arg1:GetSpecialEffectActivateInterruptType(0)
    if arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if arg1:IsInterupt(INTERUPT_ParryTiming) then
        return arg0.Parry(arg1, arg2)
    end
    if arg1:IsInterupt(INTERUPT_Damaged) then
        return arg0.Damaged(arg1, arg2)
    end
    if arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if arg1:GetSpecialEffectActivateInterruptType(0) == 3155020 and arg1:HasSpecialEffectId(TARGET_SELF, 3155010) and not arg1:HasSpecialEffectId(TARGET_SELF, 200200) then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 0.1, 3011, TARGET_ENE_0, 9999, 0, 0)
            return true
        end
        return false
    end
    if arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and is_kengeki_sp(arg1, arg2, f24_local0) then
        arg0:Kengeki(arg1, arg2, f24_local0)
        return true
    end
    return false
    
end

Goal.Parry = function (arg0, arg1, arg2)
    local f25_local0 = arg0:GetHpRate(TARGET_SELF)
    local f25_local1 = arg0:GetDist(TARGET_ENE_0)
    local f25_local2 = arg0:GetSp(TARGET_SELF)
    local f25_local3 = arg0:GetRandam_Int(1, 100)
    local f25_local4 = 0
    if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 3) then
        if arg0:HasSpecialEffectId(TARGET_ENE_0, 109012) then

        elseif arg0:IsTargetGuard(TARGET_SELF) then
            if arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then

            else
                arg1:ClearSubGoal()
                arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
            arg1:ClearSubGoal()
            arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3101, TARGET_ENE_0, 9999, 0)
            return true
        else
            arg1:ClearSubGoal()
            arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    end
    return false
    
end

Goal.Damaged = function (arg0, arg1, arg2)
    local f26_local0 = arg0:GetHpRate(TARGET_SELF)
    local f26_local1 = arg0:GetDist(TARGET_ENE_0)
    local f26_local2 = arg0:GetSp(TARGET_SELF)
    local f26_local3 = arg0:GetRandam_Int(1, 100)
    local f26_local4 = 0
    if f26_local3 <= 33 then
        arg1:ClearSubGoal()
        local f26_local5 = arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5211, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0)
        f26_local5:TimingSetTimer(3, 6, UPDATE_SUCCESS)
        return true
    elseif f26_local3 <= 67 then

    else

    end
    return false
    
end

Goal.Kengeki = function (arg0, arg1, arg2, arg3)
    local f27_local0 = {}
    local f27_local1 = {}
    local f27_local2 = {}
    Common_Clear_Param(f27_local0, f27_local1, f27_local2)
    local f27_local3 = arg1:GetDist(TARGET_ENE_0)
    local f27_local4 = arg1:GetSp(TARGET_SELF)
    if f27_local4 <= 0 then
        f27_local0[50] = 100
    elseif arg3 == 200200 then
        if f27_local3 >= 2 then
            f27_local0[50] = 100
        elseif f27_local3 <= 0.2 then
            f27_local0[50] = 100
        else
            f27_local0[3] = 100
        end
    elseif arg3 == 200201 then
        if f27_local3 >= 2 then
            f27_local0[50] = 100
        elseif f27_local3 <= 0.2 then
            f27_local0[50] = 100
        else
            f27_local0[4] = 100
        end
    elseif arg3 == 200205 then
        if f27_local3 >= 2 then
            f27_local0[50] = 100
        elseif f27_local3 <= 0.2 then
            f27_local0[50] = 100
        else
            f27_local0[1] = 100
        end
    elseif arg3 == 200206 then
        if f27_local3 >= 2 then
            f27_local0[50] = 100
        elseif f27_local3 <= 0.2 then
            f27_local0[50] = 100
        else
            f27_local0[2] = 100
        end
    elseif arg3 == 200210 then
        if f27_local3 >= 2 then
            f27_local0[50] = 100
        elseif f27_local3 <= 0.2 then
            f27_local0[50] = 100
        else
            f27_local0[7] = 100
        end
    elseif arg3 == 200211 then
        if f27_local3 >= 2 then
            f27_local0[50] = 100
        elseif f27_local3 <= 0.2 then
            f27_local0[50] = 100
        else
            f27_local0[8] = 100
        end
    elseif arg3 == 200215 then
        if f27_local3 >= 2 then
            f27_local0[50] = 100
        elseif f27_local3 <= 0.2 then
            f27_local0[50] = 100
        else
            f27_local0[5] = 100
        end
    elseif arg3 == 200216 then
        if f27_local3 >= 2 then
            f27_local0[50] = 100
        elseif f27_local3 <= 0.2 then
            f27_local0[50] = 100
        else
            f27_local0[6] = 100
        end
    end
    f27_local1[1] = REGIST_FUNC(arg1, arg2, arg0.Kengeki01)
    f27_local1[2] = REGIST_FUNC(arg1, arg2, arg0.Kengeki02)
    f27_local1[3] = REGIST_FUNC(arg1, arg2, arg0.Kengeki03)
    f27_local1[4] = REGIST_FUNC(arg1, arg2, arg0.Kengeki04)
    f27_local1[5] = REGIST_FUNC(arg1, arg2, arg0.Kengeki05)
    f27_local1[6] = REGIST_FUNC(arg1, arg2, arg0.Kengeki06)
    f27_local1[7] = REGIST_FUNC(arg1, arg2, arg0.Kengeki07)
    f27_local1[8] = REGIST_FUNC(arg1, arg2, arg0.Kengeki08)
    f27_local1[50] = REGIST_FUNC(arg1, arg2, arg0.NoAction)
    local f27_local5 = REGIST_FUNC(arg1, arg2, arg0.ActAfter_AdjustSpace)
    Common_Kengeki_Activate(arg1, arg2, f27_local0, f27_local1, f27_local5, f27_local2)
    
end

Goal.Kengeki01 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3050, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3055, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3065, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3070, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3075, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3085, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3085, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (arg0, arg1, arg2)
    arg0:Replanning()
    
end

Goal.ActAfter_AdjustSpace = function (arg0, arg1, arg2)
    
end

Goal.Update = function (arg0, arg1, arg2)
    return default_update(arg0, arg1, arg2)
    
end

Goal.Terminate = function (arg0, arg1, arg2)
    
end


