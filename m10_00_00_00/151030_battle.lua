RegisterTableGoal(GOAL_MurabitoZombie_kuwa_genkaku_151030_Battle, "GOAL_MurabitoZombie_kuwa_genkaku_151030_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_MurabitoZombie_kuwa_genkaku_151030_Battle, true)
Goal.Initialize = function (arg0, arg1, arg2, arg3)
    
end

Goal.Activate = function (arg0, arg1, arg2)
    Init_Pseudo_Global(arg1, arg2)
    arg1:SetStringIndexedNumber("Warp_Point_Back", arg1:GetRandam_Int(1002850, 1002857))
    arg1:SetStringIndexedNumber("Warp_Point_Center", arg1:GetRandam_Int(1002860, 1002867))
    arg1:SetStringIndexedNumber("Warp_Point_Front", arg1:GetRandam_Int(1002870, 1002877))
    arg1:SetStringIndexedNumber("Warp_Region_Back", 1002840)
    arg1:SetStringIndexedNumber("Warp_Region_Front", 1002841)
    if arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
        arg1:SetStringIndexedNumber("Warp_Point_Back", arg1:GetRandam_Int(9992900, 9992907))
        arg1:SetStringIndexedNumber("Warp_Point_Center", arg1:GetRandam_Int(9992910, 9992917))
        arg1:SetStringIndexedNumber("Warp_Point_Front", arg1:GetRandam_Int(9992920, 9992927))
        arg1:SetStringIndexedNumber("Warp_Region_Back", 9992980)
        arg1:SetStringIndexedNumber("Warp_Region_Front", 9992982)
    elseif arg1:GetNpcThinkParamID() == 15109300 and not arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
        arg1:SetStringIndexedNumber("Warp_Point_Back", arg1:GetRandam_Int(9992800, 9992807))
        arg1:SetStringIndexedNumber("Warp_Point_Center", arg1:GetRandam_Int(9992810, 9992817))
        arg1:SetStringIndexedNumber("Warp_Point_Front", arg1:GetRandam_Int(9992820, 9992827))
        arg1:SetStringIndexedNumber("Warp_Region_Back", 9992880)
        arg1:SetStringIndexedNumber("Warp_Region_Front", 9992882)
    end
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local5 = arg1:GetEventRequest()
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110124)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3509070)
    if arg1:GetNumber(1) == 0 then
        if arg1:IsInsideTargetRegion(TARGET_EVENT, arg1:GetStringIndexedNumber("Warp_Region_Back")) == true then
            f2_local0[36] = 100
            arg1:SetNumber(1, 36)
        elseif arg1:IsInsideTargetRegion(TARGET_EVENT, arg1:GetStringIndexedNumber("Warp_Region_Front")) == true then
            f2_local0[38] = 100
            arg1:SetNumber(1, 38)
        elseif arg1:IsInsideTargetRegion(TARGET_EVENT, arg1:GetStringIndexedNumber("Warp_Region_Back")) == false and arg1:IsInsideTargetRegion(TARGET_EVENT, arg1:GetStringIndexedNumber("Warp_Region_Front")) == false then
            f2_local0[37] = 100
            arg1:SetNumber(1, 37)
        end
    elseif arg1:HasSpecialEffectId(TARGET_ENE_0, SP_PRETEND_DEAD) then
        KankyakuAct(arg1, arg2, 0)
    elseif Common_ActivateAct(arg1, arg2) then

    elseif f2_local4 == 1 and arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        if f2_local3 >= 7 then
            f2_local0[5] = 100
            f2_local0[7] = 400
            f2_local0[23] = 100
            f2_local0[28] = 100
            f2_local0[29] = 0
        elseif f2_local3 >= 3 then
            f2_local0[5] = 100
            f2_local0[23] = 500
            f2_local0[24] = 100
            f2_local0[28] = 100
            f2_local0[29] = 100
        else
            f2_local0[23] = 100
            f2_local0[24] = 300
            f2_local0[28] = 200
            f2_local0[29] = 300
        end
    elseif f2_local4 == 1 and arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if f2_local3 >= 7 then
            f2_local0[1] = 0
            f2_local0[2] = 0
            f2_local0[5] = 100
            f2_local0[7] = 300
            f2_local0[23] = 100
            f2_local0[28] = 100
            f2_local0[29] = 0
        elseif f2_local3 >= 3 then
            f2_local0[5] = 100
            f2_local0[23] = 100
            f2_local0[24] = 1
            f2_local0[28] = 100
        else
            f2_local0[5] = 100
            f2_local0[23] = 100
            f2_local0[24] = 1
            f2_local0[28] = 100
        end
    elseif arg1:HasSpecialEffectId(TARGET_ENE_0, SP_ENEMY_AI_REFERENCE_SHINOBI) then
        f2_local0[28] = 100
    elseif arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 1
    elseif f2_local3 >= 10 then
        f2_local0[1] = 500
        f2_local0[2] = 500
    elseif f2_local3 > 3 then
        f2_local0[1] = 600
        f2_local0[2] = 400
    else
        f2_local0[1] = 500
        f2_local0[2] = 400
        f2_local0[24] = 100
    end
    if SpaceCheck(arg1, arg2, 45, 2) == false and SpaceCheck(arg1, arg2, -45, 2) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(arg1, arg2, 90, 1) == false and SpaceCheck(arg1, arg2, -45, 1) == false then
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
    f2_local0[5] = get_weight_base_on_cooldown(arg1, arg2, 3025, 10, f2_local0[5], 1)
    f2_local1[1] = REGIST_FUNC(arg1, arg2, arg0.Act01)
    f2_local1[2] = REGIST_FUNC(arg1, arg2, arg0.Act02)
    f2_local1[5] = REGIST_FUNC(arg1, arg2, arg0.Act05)
    f2_local1[6] = REGIST_FUNC(arg1, arg2, arg0.Act06)
    f2_local1[7] = REGIST_FUNC(arg1, arg2, arg0.Act07)
    f2_local1[15] = REGIST_FUNC(arg1, arg2, arg0.Act15)
    f2_local1[21] = REGIST_FUNC(arg1, arg2, arg0.Act21)
    f2_local1[22] = REGIST_FUNC(arg1, arg2, arg0.Act22)
    f2_local1[23] = REGIST_FUNC(arg1, arg2, arg0.Act23)
    f2_local1[24] = REGIST_FUNC(arg1, arg2, arg0.Act24)
    f2_local1[25] = REGIST_FUNC(arg1, arg2, arg0.Act25)
    f2_local1[26] = REGIST_FUNC(arg1, arg2, arg0.Act26)
    f2_local1[27] = REGIST_FUNC(arg1, arg2, arg0.Act27)
    f2_local1[28] = REGIST_FUNC(arg1, arg2, arg0.Act28)
    f2_local1[29] = REGIST_FUNC(arg1, arg2, arg0.Act29)
    f2_local1[35] = REGIST_FUNC(arg1, arg2, arg0.Act35)
    f2_local1[36] = REGIST_FUNC(arg1, arg2, arg0.Act36)
    f2_local1[37] = REGIST_FUNC(arg1, arg2, arg0.Act37)
    f2_local1[38] = REGIST_FUNC(arg1, arg2, arg0.Act38)
    f2_local1[40] = REGIST_FUNC(arg1, arg2, arg0.Act40)
    f2_local1[41] = REGIST_FUNC(arg1, arg2, arg0.Act41)
    f2_local1[42] = REGIST_FUNC(arg1, arg2, arg0.Act42)
    f2_local1[43] = REGIST_FUNC(arg1, arg2, arg0.Act43)
    f2_local1[44] = REGIST_FUNC(arg1, arg2, arg0.Act44)
    local f2_local6 = REGIST_FUNC(arg1, arg2, arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(arg1, arg2, f2_local0, f2_local1, f2_local6, f2_local2)
    
end

Goal.Act01 = function (arg0, arg1, arg2)
    local f3_local0 = 4.7 - arg0:GetMapHitRadius(TARGET_SELF) + arg0:GetRandam_Float(0, 2.5) - 0.8
    local f3_local1 = f3_local0
    local f3_local2 = f3_local0 + 7
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 2
    Approach_Act_Flex(arg0, arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 2.6 - arg0:GetMapHitRadius(TARGET_SELF) + 0.5
    local f3_local8 = 3.5 - arg0:GetMapHitRadius(TARGET_SELF) + 0.5
    local f3_local9 = 0
    local f3_local10 = 0
    local f3_local11 = arg0:GetRandam_Int(1, 100)
    if f3_local11 <= 60 then
        arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local7, f3_local9, f3_local10, 0, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    else
        arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local9, f3_local10, 0, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (arg0, arg1, arg2)
    local f4_local0 = 5 - arg0:GetMapHitRadius(TARGET_SELF) + arg0:GetRandam_Float(0, 2.5) - 0.8
    local f4_local1 = f4_local0
    local f4_local2 = f4_local0 + 7
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 2
    Approach_Act_Flex(arg0, arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (arg0, arg1, arg2)
    local f5_local0 = 0
    local f5_local1 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3025, TARGET_ENE_0, 9999, f5_local0, f5_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (arg0, arg1, arg2)
    local f6_local0 = -1
    local f6_local1 = arg0:GetRandam_Int(1, 2)
    local f6_local2 = arg0:GetRandam_Int(0, 1)
    local f6_local3 = 3
    local f6_local4 = arg0:GetRandam_Int(30, 45)
    if SpaceCheck(arg0, arg1, 180, 1) == true then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, 8, TARGET_ENE_0, true, f6_local0)
    else
        arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f6_local3, TARGET_ENE_0, f6_local2, f6_local4, true, true, f6_local0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (arg0, arg1, arg2)
    local f7_local0 = 7
    local f7_local1 = 10
    local f7_local2 = 15
    local f7_local3 = 0
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 2
    arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 6, TARGET_SELF, false, -1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (arg0, arg1, arg2)
    local f8_local0 = 0
    local f8_local1 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3031, TARGET_ENE_0, 9999, f8_local0, f8_local1, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (arg0, arg1, arg2)
    local f9_local0 = 3
    local f9_local1 = 45
    arg1:AddSubGoal(GOAL_COMMON_Turn, f9_local0, TARGET_ENE_0, f9_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (arg0, arg1, arg2)
    local f10_local0 = 3
    local f10_local1 = 0
    local f10_local2 = arg0:GetDist(TARGET_FRI_0)
    local f10_local3 = arg0:GetRandam_Int(1, 100)
    if SpaceCheck(arg0, arg1, -45, 2) == true and SpaceCheck(arg0, arg1, 45, 2) == true and f10_local2 >= 2.5 then
        if f10_local3 <= 50 then
            arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5212, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_L, 0)
        else
            arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5213, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_R, 0)
        end
    elseif arg0:IsInsideTarget(TARGET_FRI_0, AI_DIR_TYPE_R, 100) and SpaceCheck(arg0, arg1, -45, 2) == true and f10_local2 <= 2.5 then
        arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5212, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_L, 0)
    elseif arg0:IsInsideTarget(TARGET_FRI_0, AI_DIR_TYPE_L, 100) and SpaceCheck(arg0, arg1, 45, 2) == true and f10_local2 <= 2.5 then
        arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5213, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_R, 0)
    elseif SpaceCheck(arg0, arg1, -45, 2) == true and SpaceCheck(arg0, arg1, 45, 2) == true then
        if f10_local3 <= 50 then
            arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5212, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_L, 0)
        else
            arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5213, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_R, 0)
        end
    elseif SpaceCheck(arg0, arg1, -45, 2) == true then
        arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5212, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_L, 0)
    elseif SpaceCheck(arg0, arg1, 45, 2) == true then
        arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5213, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_R, 0)
    else

    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (arg0, arg1, arg2)
    local f11_local0 = arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = arg0:GetDist(TARGET_FRI_0)
    local f11_local2 = arg0:GetSp(TARGET_SELF)
    local f11_local3 = 20
    local f11_local4 = arg0:GetRandam_Int(1, 100)
    local f11_local5 = -1
    local f11_local6 = arg0:GetRandam_Int(0, 1)
    if arg0:IsInsideTarget(TARGET_FRI_0, AI_DIR_TYPE_R, 100) and SpaceCheck(arg0, arg1, -90, 1) == true and f11_local1 <= 2.5 then
        f11_local6 = 0
    elseif arg0:IsInsideTarget(TARGET_FRI_0, AI_DIR_TYPE_L, 100) and SpaceCheck(arg0, arg1, 90, 1) == true and f11_local1 <= 2.5 then
        f11_local6 = 1
    end
    local f11_local7 = 3
    local f11_local8 = arg0:GetRandam_Int(30, 45)
    arg0:SetNumber(10, f11_local6)
    local f11_local9 = arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f11_local7, TARGET_ENE_0, f11_local6, f11_local8, true, true, f11_local5)
    f11_local9:TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (arg0, arg1, arg2)
    local f12_local0 = arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = 3
    local f12_local2 = 0
    local f12_local3 = 5211
    if SpaceCheck(arg0, arg1, 180, 2) == true and SpaceCheck(arg0, arg1, 180, 4) == true then
        if f12_local0 > 4 then

        else
            f12_local3 = 5211
        end
    end
    arg1:AddSubGoal(GOAL_COMMON_SpinStep, f12_local1, f12_local3, TARGET_ENE_0, f12_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (arg0, arg1, arg2)
    local f13_local0 = arg0:GetRandam_Float(2, 4)
    local f13_local1 = arg0:GetRandam_Float(1, 3)
    local f13_local2 = arg0:GetDist(TARGET_ENE_0)
    local f13_local3 = -1
    if SpaceCheck(arg0, arg1, 180, 1) == true then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f13_local0, TARGET_ENE_0, f13_local1, TARGET_ENE_0, true, f13_local3)
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
    local f15_local0 = arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = arg0:GetDistYSigned(TARGET_ENE_0)
    local f15_local2 = f15_local1 / math.tan(math.deg(30))
    local f15_local3 = arg0:GetRandam_Int(0, 1)
    if f15_local1 >= 3 then
        if f15_local2 + 1 <= f15_local0 then
            if SpaceCheck(arg0, arg1, 0, 4) == true then
                arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f15_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(arg0, arg1, 0, 3) == true then
                arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f15_local2, TARGET_SELF, true, -1)
            end
        elseif f15_local0 <= f15_local2 - 1 then
            arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f15_local2, TARGET_ENE_0, true, -1)
        end
    elseif SpaceCheck(arg0, arg1, 0, 4) == true then
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(arg0, arg1, 0, 3) == true then
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(arg0, arg1, 0, 1) == false then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    end
    arg0:SetNumber(10, f15_local3)
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f15_local3, arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (arg0, arg1, arg2)
    local f16_local0 = arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = arg0:GetRandam_Float(1, 3.5)
    local f16_local2 = 1.5
    local f16_local3 = arg0:GetRandam_Int(30, 45)
    local f16_local4 = -1
    local f16_local5 = arg0:GetRandam_Int(0, 1)
    if f16_local0 <= 7 then
        arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f16_local1, TARGET_ENE_0, f16_local5, f16_local3, true, true, f16_local4)
    elseif f16_local0 <= 10 then
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f16_local2, TARGET_ENE_0, 7.9, TARGET_SELF, true, -1)
    else
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f16_local2, TARGET_ENE_0, 9.9, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (arg0, arg1, arg2)
    local f17_local0 = arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = 7
    local f17_local2 = 0
    local f17_local3 = arg0:GetRandam_Float(1, 3.5)
    arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f17_local3, TARGET_ENE_0, f17_local1, TARGET_ENE_0, true, -1)
    
end

Goal.Act35 = function (arg0, arg1, arg2)
    local f18_local0 = arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = arg0:GetRandam_Int(1, 100)
    local f18_local2 = arg0:GetRandam_Int(0, 1)
    local f18_local3 = arg0:GetRandam_Float(2, 3.5)
    local f18_local4 = 3
    local f18_local5 = 0
    local f18_local6 = arg0:GetDist(TARGET_FRI_0)
    local f18_local7 = arg0:GetRandam_Int(1, 100)
    local f18_local8 = arg0:GetRandam_Float(6.5, 7.5)
    local f18_local9 = arg0:GetRandam_Float(5.5, 6.5)
    local f18_local10 = 999
    local f18_local11 = 100
    if f18_local0 >= 10 then
        Approach_Act(arg0, arg1, f18_local8, f18_local10, 0, 3)
    elseif f18_local0 >= 5 then

    elseif f18_local0 >= 3.5 then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 3, TARGET_ENE_0, f18_local8, TARGET_ENE_0, false, 9910)
    else
        arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 2)
    end
    local f18_local12 = arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f18_local3, TARGET_ENE_0, f18_local2, arg0:GetRandam_Int(30, 45), true, true, 9910)
    f18_local12:TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act36 = function (arg0, arg1, arg2)
    local f19_local0 = arg0:GetStringIndexedNumber("Warp_Point_Back")
    arg0:SetNumber(2, f19_local0)
    arg0:SetEventMoveTarget(f19_local0)
    arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, 0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act37 = function (arg0, arg1, arg2)
    local f20_local0 = arg0:GetStringIndexedNumber("Warp_Point_Center")
    arg0:SetNumber(2, f20_local0)
    arg0:SetEventMoveTarget(f20_local0)
    arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, 0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act38 = function (arg0, arg1, arg2)
    local f21_local0 = arg0:GetStringIndexedNumber("Warp_Point_Front")
    arg0:SetNumber(2, f21_local0)
    arg0:SetEventMoveTarget(f21_local0)
    arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, 0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (arg0, arg1, arg2)
    local f22_local0 = arg0:GetRandam_Int(9992960, 9992967)
    arg0:SetNumber(2, f22_local0)
    arg0:SetEventMoveTarget(f22_local0)
    arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, 0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (arg0, arg1, arg2)
    local f23_local0 = arg0:GetRandam_Int(9992964, 9992971)
    arg0:SetNumber(2, f23_local0)
    arg0:SetEventMoveTarget(f23_local0)
    arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, 0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (arg0, arg1, arg2)
    local f24_local0 = arg0:GetRandam_Int(9992968, 9992975)
    arg0:SetNumber(2, f24_local0)
    arg0:SetEventMoveTarget(f24_local0)
    arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, 0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act43 = function (arg0, arg1, arg2)
    local f25_local0 = arg0:GetRandam_Float(0, 1)
    local f25_local1 = arg0:GetRandam_Int(9992810, 9992817)
    arg0:SetNumber(2, f25_local1)
    arg0:SetEventMoveTarget(f25_local1)
    arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, f25_local0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act44 = function (arg0, arg1, arg2)
    local f26_local0 = arg0:GetRandam_Int(0, 1)
    local f26_local1 = arg0:GetRandam_Int(9992800, 9992807)
    arg0:SetNumber(2, f26_local1)
    arg0:SetEventMoveTarget(f26_local1)
    arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, f26_local0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (arg0, arg1, arg2)
    local f27_local0 = arg1:GetSpecialEffectActivateInterruptType(0)
    if arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then
        return false
    end
    if arg1:IsInterupt(INTERUPT_Damaged) then
        return arg0.Damaged(arg1, arg2)
    end
    if arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f27_local0 == 3509070 then
        arg2:ClearSubGoal()
        arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 1, 3031, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    end
    if arg1:GetSpecialEffectActivateInterruptType(0) == 110124 then
        arg2:ClearSubGoal()
        arg1:Replaning()
        return false
    end
    return false
    
end

Goal.Parry = function (arg0, arg1, arg2)
    local f28_local0 = arg0:GetHpRate(TARGET_SELF)
    local f28_local1 = arg0:GetDist(TARGET_ENE_0)
    local f28_local2 = arg0:GetSp(TARGET_SELF)
    local f28_local3 = arg0:GetRandam_Int(1, 100)
    local f28_local4 = 0
    if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 3) then
        if arg0:HasSpecialEffectId(TARGET_ENE_0, 109012) then

        elseif arg0:IsTargetGuard(TARGET_SELF) then
            if arg0:HasSpecialEffectId(TARGET_ENE_0, SP_PUSH) then

            else
                arg1:ClearSubGoal()
                arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif arg0:HasSpecialEffectId(TARGET_ENE_0, SP_PUSH) then
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
    local f29_local0 = arg0:GetHpRate(TARGET_SELF)
    local f29_local1 = arg0:GetDist(TARGET_ENE_0)
    local f29_local2 = arg0:GetSp(TARGET_SELF)
    local f29_local3 = arg0:GetRandam_Int(1, 100)
    local f29_local4 = 0
    if f29_local3 <= 33 then
        arg1:ClearSubGoal()
        local f29_local5 = arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5211, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0)
        f29_local5:TimingSetTimer(3, 6, UPDATE_SUCCESS)
        return true
    elseif f29_local3 <= 67 then

    else

    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_MurabitoZombie_kuwa_genkaku_151030_AfterAttackAct, 10)
    
end

Goal.Update = function (arg0, arg1, arg2)
    return default_update(arg0, arg1, arg2)
    
end

Goal.Terminate = function (arg0, arg1, arg2)
    
end

RegisterTableGoal(GOAL_MurabitoZombie_kuwa_genkaku_151030_AfterAttackAct, "GOAL_MurabitoZombie_kuwa_genkaku_151030_AfterAttackAct")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_MurabitoZombie_kuwa_genkaku_151030_AfterAttackAct, true)
Goal.Activate = function (arg0, arg1, arg2)
    local f33_local0 = arg1:GetDist(TARGET_ENE_0)
    local f33_local1 = arg1:GetToTargetAngle(TARGET_ENE_0)
    local f33_local2 = arg1:GetHpRate(TARGET_SELF)
    local f33_local3 = {}
    if arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 160) then
        f33_local3[1] = 100
        f33_local3[2] = 0
        f33_local3[3] = 0
    elseif f33_local0 >= 7 then
        f33_local3[1] = 100
        f33_local3[2] = 0
        f33_local3[3] = 0
    elseif f33_local0 >= 3 then
        f33_local3[1] = 30
        f33_local3[2] = 45
        f33_local3[3] = 25
    else
        f33_local3[1] = 30
        f33_local3[2] = 20
        f33_local3[3] = 50
    end
    local f33_local4 = SelectOddsIndex(arg1, f33_local3)
    if f33_local4 == 1 then

    elseif f33_local4 == 2 then
        arg2:AddSubGoal(GOAL_COMMON_SidewayMove, arg1:GetRandam_Float(0, 1), TARGET_ENE_0, arg1:GetRandam_Int(1.5, 3), arg1:GetRandam_Int(30, 45), true, true, -1)
    elseif f33_local4 == 3 then
        arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, arg1:GetRandam_Int(1.5, 3), TARGET_ENE_0, 7, TARGET_ENE_0, true, -1)
    end
    
end

Goal.Update = function (arg0, arg1, arg2)
    return default_update(arg0, arg1, arg2)
    
end


