RegisterTableGoal(GOAL_Iseinomusume_740000_Battle, "GOAL_Iseinomusume_740000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Iseinomusume_740000_Battle, true)
Goal.Initialize = function (arg0, arg1, arg2, arg3)
    
end

Goal.Activate = function (arg0, arg1, arg2)
    Init_Pseudo_Global(arg1, arg2)
    arg1:DeleteObserve(0)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local5 = 0
    if arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) == true or arg1:HasSpecialEffectId(TARGET_ENE_0, 110125) == true then
        f2_local5 = 1
    else
        f2_local5 = 0
    end
    local f2_local6 = 0
    if arg1:GetHpRate(TARGET_ENE_0) < 0.6 or arg1:GetSpRate(TARGET_ENE_0) < 0.6 or arg1:GetHpRate(TARGET_SELF) < 0.6 or arg1:GetSpRate(TARGET_SELF) < 0.6 then
        f2_local6 = 1
    else
        f2_local6 = 0
    end
    arg1:DeleteObserve(1)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110111)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110125)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3740000)
    Set_ConsecutiveGuardCount_Interrupt(arg1)
    if arg0:Kengeki_Activate(arg1, arg2) then
        return 
    end
    if arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        if arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[21] = 1
            f2_local0[28] = 100
        else
            f2_local0[21] = 100
        end
    elseif Common_ActivateAct(arg1, arg2, 0, 1) then

    elseif arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[27] = 100
    elseif arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
    elseif arg1:HasSpecialEffectId(TARGET_ENE_0, 110120) and f2_local3 <= 6 then
        f2_local0[7] = 1000
    elseif f2_local5 == 1 and arg1:GetTimer(2) <= 0 then
        arg1:SetTimer(2, 10)
        f2_local0[42] = 100
    elseif f2_local3 >= 7 then
        f2_local0[29] = 100
        if f2_local6 == 1 and f2_local3 < 10 then
            f2_local0[42] = 500
        end
    elseif f2_local3 >= 5 then
        f2_local0[8] = 100
        f2_local0[16] = 100
        if f2_local6 == 1 then
            f2_local0[42] = 150
        end
    elseif f2_local3 > 3 then
        f2_local0[1] = 200
        f2_local0[4] = 100
        f2_local0[8] = 0
        f2_local0[10] = 0
        f2_local0[15] = 0
        f2_local0[16] = 100
    elseif f2_local3 > 1 then
        f2_local0[1] = 150
        f2_local0[4] = 100
        f2_local0[10] = 100
        f2_local0[15] = 150
        f2_local0[16] = 100
    else
        f2_local0[1] = 150
        f2_local0[4] = 100
        f2_local0[10] = 100
        f2_local0[15] = 150
        f2_local0[16] = 100
    end
    if SpaceCheck(arg1, arg2, 45, 2) == false and SpaceCheck(arg1, arg2, -45, 2) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(arg1, arg2, 90, 1) == false and SpaceCheck(arg1, arg2, -90, 1) == false then
        f2_local0[23] = 0
    elseif arg1:GetNumber(5) == 1 and f2_local3 > 3 then
        f2_local0[23] = 10000
    end
    if SpaceCheck(arg1, arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(arg1, arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = get_weight_base_on_cooldown(arg1, arg2, 3000, 15, f2_local0[1], 1)
    f2_local0[2] = get_weight_base_on_cooldown(arg1, arg2, 3003, 6, f2_local0[2], 1)
    f2_local0[3] = get_weight_base_on_cooldown(arg1, arg2, 3016, 7, f2_local0[3], 1)
    f2_local0[4] = get_weight_base_on_cooldown(arg1, arg2, 3006, 15, f2_local0[4], 1)
    f2_local0[5] = get_weight_base_on_cooldown(arg1, arg2, 3015, 7, f2_local0[5], 1)
    f2_local0[6] = get_weight_base_on_cooldown(arg1, arg2, 3015, 7, f2_local0[6], 1)
    f2_local0[8] = get_weight_base_on_cooldown(arg1, arg2, 3013, 30, f2_local0[8], 0)
    f2_local0[10] = get_weight_base_on_cooldown(arg1, arg2, 3005, 15, f2_local0[10], 1)
    f2_local0[11] = get_weight_base_on_cooldown(arg1, arg2, 3011, 10, f2_local0[11], 1)
    f2_local0[12] = get_weight_base_on_cooldown(arg1, arg2, 3010, 7, f2_local0[12], 1)
    f2_local0[13] = get_weight_base_on_cooldown(arg1, arg2, 3015, 7, f2_local0[13], 1)
    f2_local0[14] = get_weight_base_on_cooldown(arg1, arg2, 3012, 7, f2_local0[14], 1)
    f2_local0[15] = get_weight_base_on_cooldown(arg1, arg2, 3027, 5, f2_local0[15], 1)
    f2_local0[16] = get_weight_base_on_cooldown(arg1, arg2, 3027, 5, f2_local0[16], 1)
    f2_local0[17] = get_weight_base_on_cooldown(arg1, arg2, 3025, 5, f2_local0[17], 1)
    f2_local0[18] = get_weight_base_on_cooldown(arg1, arg2, 3000, 10, f2_local0[18], 1)
    f2_local0[19] = get_weight_base_on_cooldown(arg1, arg2, 3010, 10, f2_local0[19], 1)
    f2_local0[42] = get_weight_base_on_cooldown(arg1, arg2, 3004, 15, f2_local0[42], 1)
    f2_local0[42] = get_weight_base_on_cooldown(arg1, arg2, 3019, 15, f2_local0[42], 1)
    f2_local1[1] = REGIST_FUNC(arg1, arg2, arg0.Act01)
    f2_local1[2] = REGIST_FUNC(arg1, arg2, arg0.Act02)
    f2_local1[3] = REGIST_FUNC(arg1, arg2, arg0.Act03)
    f2_local1[4] = REGIST_FUNC(arg1, arg2, arg0.Act04)
    f2_local1[5] = REGIST_FUNC(arg1, arg2, arg0.Act05)
    f2_local1[6] = REGIST_FUNC(arg1, arg2, arg0.Act06)
    f2_local1[7] = REGIST_FUNC(arg1, arg2, arg0.Act07)
    f2_local1[8] = REGIST_FUNC(arg1, arg2, arg0.Act08)
    f2_local1[9] = REGIST_FUNC(arg1, arg2, arg0.Act09)
    f2_local1[10] = REGIST_FUNC(arg1, arg2, arg0.Act10)
    f2_local1[11] = REGIST_FUNC(arg1, arg2, arg0.Act11)
    f2_local1[12] = REGIST_FUNC(arg1, arg2, arg0.Act12)
    f2_local1[13] = REGIST_FUNC(arg1, arg2, arg0.Act13)
    f2_local1[14] = REGIST_FUNC(arg1, arg2, arg0.Act14)
    f2_local1[15] = REGIST_FUNC(arg1, arg2, arg0.Act15)
    f2_local1[16] = REGIST_FUNC(arg1, arg2, arg0.Act16)
    f2_local1[17] = REGIST_FUNC(arg1, arg2, arg0.Act17)
    f2_local1[18] = REGIST_FUNC(arg1, arg2, arg0.Act18)
    f2_local1[19] = REGIST_FUNC(arg1, arg2, arg0.Act19)
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
    f2_local1[35] = REGIST_FUNC(arg1, arg2, arg0.Act35)
    f2_local1[36] = REGIST_FUNC(arg1, arg2, arg0.Act36)
    f2_local1[40] = REGIST_FUNC(arg1, arg2, arg0.Act40)
    f2_local1[41] = REGIST_FUNC(arg1, arg2, arg0.Act41)
    f2_local1[42] = REGIST_FUNC(arg1, arg2, arg0.Act42)
    local f2_local7 = REGIST_FUNC(arg1, arg2, arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(arg1, arg2, f2_local0, f2_local1, f2_local7, f2_local2)
    
end

Goal.Act01 = function (arg0, arg1, arg2)
    local f3_local0 = 3 - arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 5
    local f3_local2 = 5
    local f3_local3 = 0
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(arg0, arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 10
    local f3_local8 = 10
    local f3_local9 = 0
    local f3_local10 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local7, f3_local9, f3_local10, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, f3_local8, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (arg0, arg1, arg2)
    local f4_local0 = 2 - arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 5
    local f4_local2 = 5
    local f4_local3 = 0
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(arg0, arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    local f4_local9 = arg0:GetDist(TARGET_ENE_0)
    local f4_local10 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, 999, f4_local7, f4_local8, 0, 0)
    if f4_local10 > 50 then
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 999, 0, 0)
    else
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (arg0, arg1, arg2)
    local f5_local0 = 3
    local f5_local1 = 5
    local f5_local2 = 5
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(arg0, arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    local f5_local9 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3016, TARGET_ENE_0, 7, f5_local7, f5_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3004, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (arg0, arg1, arg2)
    local f6_local0 = 2
    local f6_local1 = 5
    local f6_local2 = 5
    local f6_local3 = 0
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    Approach_Act_Flex(arg0, arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    local f6_local9 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3016, TARGET_ENE_0, 5, f6_local7, f6_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (arg0, arg1, arg2)
    local f7_local0 = 3
    local f7_local1 = 5
    local f7_local2 = 5
    local f7_local3 = 0
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(arg0, arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    local f7_local9 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3015, TARGET_ENE_0, 5, f7_local7, f7_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (arg0, arg1, arg2)
    local f8_local0 = 3
    local f8_local1 = 5
    local f8_local2 = 5
    local f8_local3 = 0
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(arg0, arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 0
    local f8_local8 = 0
    local f8_local9 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3015, TARGET_ENE_0, 5, f8_local7, f8_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3008, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (arg0, arg1, arg2)
    local f10_local0 = 6
    local f10_local1 = 6
    local f10_local2 = 6
    local f10_local3 = 0
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    Approach_Act_Flex(arg0, arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3013, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (arg0, arg1, arg2)
    local f11_local0 = 3
    local f11_local1 = 5
    local f11_local2 = 5
    local f11_local3 = 0
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    Approach_Act_Flex(arg0, arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3010, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, 10, 0, 0, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, 10, 0, 0, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3010, TARGET_ENE_0, 999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3023, TARGET_ENE_0, 999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3004, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 5, 0, 0, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 10, 0, 0, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (arg0, arg1, arg2)
    local f16_local0 = 0
    local f16_local1 = 0
    local f16_local2 = arg0:GetRandam_Int(1, 100)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3012, TARGET_ENE_0, 10, 0, 0, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5201, TARGET_ENE_0, 999, 0, 0, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3027, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (arg0, arg1, arg2)
    local f18_local0 = 6
    local f18_local1 = 6
    local f18_local2 = 6
    local f18_local3 = 0
    local f18_local4 = 0
    local f18_local5 = 1.5
    local f18_local6 = 3
    Approach_Act_Flex(arg0, arg1, f18_local0, f18_local1, f18_local2, f18_local3, f18_local4, f18_local5, f18_local6)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 3, 3027, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 5202, TARGET_ENE_0, 7, 0, 0, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3025, TARGET_ENE_0, 999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 10, 0, 0, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3004, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 10, 0, 0, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3024, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3002, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (arg0, arg1, arg2)
    local f23_local0 = 3
    local f23_local1 = 45
    arg1:AddSubGoal(GOAL_COMMON_Turn, f23_local0, TARGET_ENE_0, f23_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (arg0, arg1, arg2)
    local f24_local0 = 3
    local f24_local1 = 0
    local f24_local2 = 5202
    if SpaceCheck(arg0, arg1, -45, 2) == true then
        if SpaceCheck(arg0, arg1, 45, 2) == true then
            if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f24_local2 = 5202
            else
                f24_local2 = 5203
            end
        else
            f24_local2 = 5202
        end
    elseif SpaceCheck(arg0, arg1, 45, 2) == true then
        f24_local2 = 5203
    else

    end
    arg1:AddSubGoal(GOAL_COMMON_SpinStep, f24_local0, f24_local2, TARGET_ENE_0, f24_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (arg0, arg1, arg2)
    arg0:SetNumber(5, 0)
    local f25_local0 = arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = arg0:GetRandam_Int(1, 100)
    local f25_local2 = -1
    local f25_local3 = 0
    if SpaceCheck(arg0, arg1, -90, 1) == true then
        if SpaceCheck(arg0, arg1, 90, 1) == true then
            if arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f25_local3 = 1
            else
                f25_local3 = 0
            end
        else
            f25_local3 = 0
        end
    elseif SpaceCheck(arg0, arg1, 90, 1) == true then
        f25_local3 = 1
    else

    end
    local f25_local4 = 4
    local f25_local5 = arg0:GetRandam_Int(90, 120)
    arg0:SetNumber(10, f25_local3)
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f25_local4, TARGET_ENE_0, f25_local3, f25_local5, true, true, f25_local2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (arg0, arg1, arg2)
    local f26_local0 = arg0:GetDist(TARGET_ENE_0)
    local f26_local1 = 3
    local f26_local2 = 0
    local f26_local3 = 5201
    if SpaceCheck(arg0, arg1, 180, 2) == true and SpaceCheck(arg0, arg1, 180, 4) == true then
        if f26_local0 > 4 then

        else
            f26_local3 = 5211
        end
    end
    arg1:AddSubGoal(GOAL_COMMON_SpinStep, f26_local1, f26_local3, TARGET_ENE_0, f26_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (arg0, arg1, arg2)
    local f27_local0 = arg0:GetRandam_Float(2, 4)
    local f27_local1 = arg0:GetRandam_Float(5, 7)
    local f27_local2 = arg0:GetDist(TARGET_ENE_0)
    local f27_local3 = -1
    arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f27_local0, TARGET_ENE_0, f27_local1, TARGET_ENE_0, true, f27_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (arg0, arg1, arg2)
    local f29_local0 = arg0:GetDist(TARGET_ENE_0)
    local f29_local1 = arg0:GetDistYSigned(TARGET_ENE_0)
    local f29_local2 = f29_local1 / math.tan(math.deg(30))
    local f29_local3 = arg0:GetRandam_Int(0, 1)
    if f29_local1 >= 3 then
        if f29_local2 + 1 <= f29_local0 then
            if SpaceCheck(arg0, arg1, 0, 4) == true then
                arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f29_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(arg0, arg1, 0, 3) == true then
                arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f29_local2, TARGET_SELF, true, -1)
            end
        elseif f29_local0 <= f29_local2 - 1 then
            arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f29_local2, TARGET_ENE_0, true, -1)
        else
            arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f29_local3, arg0:GetRandam_Int(30, 45), true, true, -1)
            arg0:SetNumber(10, f29_local3)
        end
    elseif SpaceCheck(arg0, arg1, 0, 4) == true then
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(arg0, arg1, 0, 3) == true then
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(arg0, arg1, 0, 1) == false then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    else
        arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f29_local3, arg0:GetRandam_Int(30, 45), true, true, -1)
        arg0:SetNumber(10, f29_local3)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (arg0, arg1, arg2)
    local f30_local0 = arg0:GetDist(TARGET_ENE_0)
    local f30_local1 = 1.5
    local f30_local2 = 1.5
    local f30_local3 = arg0:GetRandam_Int(30, 45)
    local f30_local4 = -1
    local f30_local5 = arg0:GetRandam_Int(0, 1)
    if f30_local0 <= 3 then
        arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f30_local1, TARGET_ENE_0, f30_local5, f30_local3, true, true, f30_local4)
    elseif f30_local0 <= 8 then
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f30_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f30_local2, TARGET_ENE_0, 8, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (arg0, arg1, arg2)
    local f31_local0 = 2
    arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f31_local0, TARGET_ENE_0, 3.9, TARGET_SELF, false, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (arg0, arg1, arg2)
    local f32_local0 = arg0:GetDist(TARGET_ENE_0)
    local f32_local1 = arg0:GetRandam_Int(1, 100)
    local f32_local2 = 9910
    local f32_local3 = 0
    if SpaceCheck(arg0, arg1, -90, 1) == true then
        if SpaceCheck(arg0, arg1, 90, 1) == true then
            if arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f32_local3 = 1
            else
                f32_local3 = 0
            end
        else
            f32_local3 = 0
        end
    elseif SpaceCheck(arg0, arg1, 90, 1) == true then
        f32_local3 = 1
    else

    end
    local f32_local4 = 3
    local f32_local5 = arg0:GetRandam_Int(30, 45)
    arg0:SetNumber(10, f32_local3)
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f32_local4, TARGET_ENE_0, f32_local3, f32_local5, true, true, f32_local2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (arg0, arg1, arg2)
    local f33_local0 = 3.5
    local f33_local1 = arg0:GetRandam_Int(30, 45)
    local f33_local2 = arg0:GetDist(TARGET_ENE_0)
    local f33_local3 = 0
    if SpaceCheck(arg0, arg1, -90, 1) == true then
        if SpaceCheck(arg0, arg1, 90, 1) == true then
            if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f33_local3 = 0
            else
                f33_local3 = 1
            end
        else
            f33_local3 = 0
        end
    elseif SpaceCheck(arg0, arg1, 90, 1) == true then
        f33_local3 = 1
    else

    end
    if f33_local2 <= 2 then
        arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 5201, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f33_local0, TARGET_ENE_0, f33_local3, f33_local1, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (arg0, arg1, arg2)
    local f34_local0 = 7
    local f34_local1 = 5
    local f34_local2 = 5
    local f34_local3 = 0
    local f34_local4 = 0
    local f34_local5 = 1.5
    local f34_local6 = 3
    Approach_Act_Flex(arg0, arg1, f34_local0, f34_local1, f34_local2, f34_local3, f34_local4, f34_local5, f34_local6)
    local f34_local7 = 10
    local f34_local8 = 10
    local f34_local9 = 0
    local f34_local10 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5202, TARGET_ENE_0, f34_local7, f34_local9, f34_local10, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3027, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (arg0, arg1, arg2)
    local f35_local0 = 7
    local f35_local1 = 5
    local f35_local2 = 5
    local f35_local3 = 0
    local f35_local4 = 0
    local f35_local5 = 1.5
    local f35_local6 = 3
    Approach_Act_Flex(arg0, arg1, f35_local0, f35_local1, f35_local2, f35_local3, f35_local4, f35_local5, f35_local6)
    local f35_local7 = 10
    local f35_local8 = 10
    local f35_local9 = 0
    local f35_local10 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5203, TARGET_ENE_0, f35_local7, f35_local9, f35_local10, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3027, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, 3004, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (arg0, arg1, arg2)
    local f37_local0 = arg1:GetSpecialEffectActivateInterruptType(0)
    local f37_local1 = arg1:GetDist(TARGET_ENE_0)
    if arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then
        return false
    end
    if arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f37_local0 == 5028 then
        arg2:ClearSubGoal()
        arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3026, TARGET_ENE_0, 999, 0, 0, 0, 0)
        return true
    end
    if arg1:IsInterupt(INTERUPT_ParryTiming) then
        return arg0.Parry(arg1, arg2, 50, 0)
    end
    if arg1:IsInterupt(INTERUPT_ShootImpact) then
        return arg0.ShootReaction(arg1, arg2)
    end
    if arg1:IsInterupt(INTERUPT_Damaged) then
        return arg0.Damaged(arg1, arg2)
    end
    if Interupt_PC_Break(arg1) then
        arg1:Replanning()
        return true
    end
    if Interupt_Use_Item(arg1, 4, 10) and arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 180) then
        if f37_local1 < 8 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3027, TARGET_ENE_0, 9999, 0)
            return true
        elseif f37_local1 < 11 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3013, TARGET_ENE_0, 9999, 0)
            return true
        else
            arg1:Replanning()
            return true
        end
    end
    if arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f37_local0 == 5029 then
            if f37_local1 < 6.5 then
                arg1:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 7)
                return true
            else
                arg2:ClearSubGoal()
                arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3018, TARGET_ENE_0, 9999, 0)
                arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, 3019, TARGET_ENE_0, 7, 0, 0, 0, 0)
                return true
            end
        end
        if f37_local0 == 5025 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3020, TARGET_ENE_0, 9999, 0, 0)
            return true
        elseif f37_local0 == 5027 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 2, 3010, TARGET_ENE_0, 999, 0, 0, 0, 0)
            return true
        elseif f37_local0 == 110111 then
            arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 120, 4)
            return true
        elseif f37_local0 == 109031 or f37_local0 == 110125 then
            arg2:ClearSubGoal()
            arg1:Replanning()
            return true
        end
    end
    if arg1:IsInterupt(INTERUPT_Outside_ObserveArea) then
        if arg1:HasSpecialEffectId(TARGET_SELF, 5029) then
            arg1:DeleteObserve(1)
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3018, TARGET_ENE_0, 9999, 0)
            arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, 3019, TARGET_ENE_0, 7, 0, 0, 0, 0)
            return true
        else
            arg1:DeleteObserve(1)
            return false
        end
    end
    if arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and arg1:IsInsideObserve(0) then
        arg1:DeleteObserve(0)
        arg2:ClearSubGoal()
        arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3008, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.Parry = function (arg0, arg1, arg2, arg3)
    local f38_local0 = arg0:GetDist(TARGET_ENE_0)
    local f38_local1 = GetDist_Parry(arg0)
    local f38_local2 = arg0:GetRandam_Int(1, 100)
    local f38_local3 = arg0:GetRandam_Int(1, 100)
    local f38_local4 = arg0:GetRandam_Int(1, 100)
    local f38_local5 = arg0:HasSpecialEffectId(TARGET_ENE_0, 109970)
    local f38_local6 = arg0:HasSpecialEffectId(TARGET_ENE_0, SP_CONTINUOUS_ATTACK)
    local f38_local7 = 2
    if arg0:HasSpecialEffectId(TARGET_SELF, 221000) then
        f38_local7 = 0
    elseif arg0:HasSpecialEffectId(TARGET_SELF, 221001) then
        f38_local7 = 1
    end
    if arg0:IsFinishTimer(AI_TIMER_PARRY_INTERVAL) == false then
        return false
    end
    if arg0:HasSpecialEffectId(TARGET_ENE_0, 110450) or arg0:HasSpecialEffectId(TARGET_ENE_0, 110501) or arg0:HasSpecialEffectId(TARGET_ENE_0, 110500) then
        return false
    end
    arg0:SetTimer(AI_TIMER_PARRY_INTERVAL, 0.1)
    if arg2 == nil then
        arg2 = 50
    end
    if arg3 == nil then
        arg3 = 0
    end
    if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 180, f38_local1) then
        if f38_local6 then
            arg1:ClearSubGoal()
            arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        elseif f38_local5 then
            if arg0:IsTargetGuard(TARGET_SELF) and get_kengeki_sp(arg0) == false then
                return false
            elseif arg0:HasSpecialEffectId(TARGET_SELF, 5026) then
                arg1:ClearSubGoal()
                arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                return true
            elseif f38_local7 == 2 then
                return false
            elseif f38_local7 == 1 then
                if f38_local2 <= 50 then
                    arg1:ClearSubGoal()
                    arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                    return true
                end
            elseif f38_local7 == 0 and f38_local2 <= 100 then
                arg1:ClearSubGoal()
                arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif arg0:HasSpecialEffectId(TARGET_SELF, 5026) then
            arg1:ClearSubGoal()
            arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
            return true
        elseif arg0:HasSpecialEffectId(TARGET_ENE_0, 109980) then
            arg1:ClearSubGoal()
            arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        elseif f38_local3 <= Get_ConsecutiveGuardCount(arg0) * arg2 then
            arg1:ClearSubGoal()
            arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
            return true
        else
            arg1:ClearSubGoal()
            arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f38_local1 + 1) then
        if f38_local4 <= arg3 then
            arg1:ClearSubGoal()
            arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        else
            return false
        end
    else
        return false
    end
    
end

Goal.Damaged = function (arg0, arg1, arg2)
    local f39_local0 = arg0:GetRandam_Int(1, 100)
    local f39_local1 = 3
    if f39_local0 <= 70 then
        if SpaceCheck(arg0, arg1, 90, 2) then
            arg1:ClearSubGoal()
            arg1:AddSubGoal(GOAL_COMMON_SpinStep, f39_local1, 5203, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 0)
            return true
        elseif SpaceCheck(arg0, arg1, -90, 2) then
            arg1:ClearSubGoal()
            arg1:AddSubGoal(GOAL_COMMON_SpinStep, f39_local1, 5202, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 0)
            return true
        end
    else
        return false
    end
    return false
    
end

Goal.ShootReaction = function (arg0, arg1)
    local f40_local0 = arg0:GetDist(TARGET_ENE_0)
    if arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 20, 999) then
        if f40_local0 <= 30 then
            arg1:ClearSubGoal()
            arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        else
            arg1:ClearSubGoal()
            arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_SELF, 0, 0, 0)
            arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    end
    return false
    
end

Goal.Kengeki_Activate = function (arg0, arg1, arg2, arg3)
    local f41_local0 = get_kengeki_sp(arg1)
    if f41_local0 == 0 then
        return false
    end
    local f41_local1 = {}
    local f41_local2 = {}
    local f41_local3 = {}
    Common_Clear_Param(f41_local1, f41_local2, f41_local3)
    local f41_local4 = arg1:GetDist(TARGET_ENE_0)
    local f41_local5 = arg1:GetSp(TARGET_SELF)
    if f41_local0 == 200200 or f41_local0 == 200205 then
        arg1:SetNumber(0, arg1:GetNumber(0) + 1)
        if arg1:GetNumber(0) >= 5 then
            f41_local1[3] = 100
            arg1:SetNumber(0, 0)
        elseif f41_local4 >= 4 then
            f41_local1[50] = 100
        else
            f41_local1[12] = 200
            f41_local1[40] = 100
            f41_local1[9] = 100
            f41_local1[21] = 100
            f41_local1[42] = 200
        end
    elseif f41_local0 == 200201 or f41_local0 == 200206 then
        arg1:SetNumber(0, arg1:GetNumber(0) + 1)
        if arg1:GetNumber(0) >= 5 then
            f41_local1[3] = 100
            arg1:SetNumber(0, 0)
        elseif f41_local4 >= 4 then
            f41_local1[50] = 100
        else
            f41_local1[4] = 100
            f41_local1[12] = 200
            f41_local1[21] = 150
            f41_local1[41] = 100
            f41_local1[9] = 100
        end
    elseif f41_local0 == SP_PARRY_COUNT_RIGHT then
        arg1:SetNumber(0, arg1:GetNumber(0) + 1)
        if arg1:GetNumber(0) >= 5 then
            f41_local1[3] = 100
            arg1:SetNumber(0, 0)
        elseif f41_local4 >= 4 then

        else
            arg1:SetNumber(0, arg1:GetNumber(0) + 1)
            f41_local1[7] = 150
            f41_local1[12] = 200
            f41_local1[40] = 150
            f41_local1[9] = 150
            f41_local1[21] = 150
        end
    elseif f41_local0 == SP_PARRY_COUNT_LEFT then
        arg1:SetNumber(0, arg1:GetNumber(0) + 1)
        if arg1:GetNumber(0) >= 5 then
            f41_local1[3] = 100
            arg1:SetNumber(0, 0)
        elseif f41_local4 >= 4 then

        else
            arg1:SetNumber(0, arg1:GetNumber(0) + 1)
            f41_local1[2] = 150
            f41_local1[4] = 100
            f41_local1[12] = 200
            f41_local1[42] = 200
            f41_local1[9] = 150
        end
    elseif f41_local0 == 200215 then
        if f41_local4 >= 4 then
            f41_local1[50] = 100
        else
            f41_local1[6] = 100
            f41_local1[12] = 100
            f41_local1[42] = 200
        end
    elseif f41_local0 == 200216 then
        if f41_local4 >= 4 then
            f41_local1[50] = 100
        else
            f41_local1[5] = 100
            f41_local1[7] = 100
        end
    end
    f41_local1[2] = get_weight_base_on_cooldown(arg1, arg2, 3067, 8, f41_local1[2], 1)
    f41_local1[4] = get_weight_base_on_cooldown(arg1, arg2, 3066, 15, f41_local1[4], 1)
    f41_local1[7] = get_weight_base_on_cooldown(arg1, arg2, 3070, 8, f41_local1[7], 1)
    f41_local1[9] = get_weight_base_on_cooldown(arg1, arg2, 5201, 15, f41_local1[9], 1)
    f41_local1[12] = get_weight_base_on_cooldown(arg1, arg2, 3027, 15, f41_local1[12], 1)
    f41_local1[21] = get_weight_base_on_cooldown(arg1, arg2, 3025, 20, f41_local1[21], 1)
    f41_local1[40] = get_weight_base_on_cooldown(arg1, arg2, 3005, 15, f41_local1[40], 1)
    f41_local1[41] = get_weight_base_on_cooldown(arg1, arg2, 3024, 15, f41_local1[41], 1)
    f41_local1[42] = get_weight_base_on_cooldown(arg1, arg2, 3003, 15, f41_local1[42], 1)
    f41_local2[1] = REGIST_FUNC(arg1, arg2, arg0.Kengeki01)
    f41_local2[2] = REGIST_FUNC(arg1, arg2, arg0.Kengeki02)
    f41_local2[3] = REGIST_FUNC(arg1, arg2, arg0.Kengeki03)
    f41_local2[4] = REGIST_FUNC(arg1, arg2, arg0.Kengeki04)
    f41_local2[5] = REGIST_FUNC(arg1, arg2, arg0.Kengeki05)
    f41_local2[6] = REGIST_FUNC(arg1, arg2, arg0.Kengeki06)
    f41_local2[7] = REGIST_FUNC(arg1, arg2, arg0.Kengeki07)
    f41_local2[8] = REGIST_FUNC(arg1, arg2, arg0.Kengeki08)
    f41_local2[9] = REGIST_FUNC(arg1, arg2, arg0.Kengeki09)
    f41_local2[10] = REGIST_FUNC(arg1, arg2, arg0.Kengeki10)
    f41_local2[11] = REGIST_FUNC(arg1, arg2, arg0.Kengeki11)
    f41_local2[12] = REGIST_FUNC(arg1, arg2, arg0.Kengeki12)
    f41_local2[13] = REGIST_FUNC(arg1, arg2, arg0.Kengeki13)
    f41_local2[14] = REGIST_FUNC(arg1, arg2, arg0.Kengeki14)
    f41_local2[20] = REGIST_FUNC(arg1, arg2, arg0.Kengeki20)
    f41_local2[21] = REGIST_FUNC(arg1, arg2, arg0.Kengeki21)
    f41_local2[22] = REGIST_FUNC(arg1, arg2, arg0.Kengeki22)
    f41_local2[23] = REGIST_FUNC(arg1, arg2, arg0.Kengeki23)
    f41_local2[30] = REGIST_FUNC(arg1, arg2, arg0.Kengeki30)
    f41_local2[31] = REGIST_FUNC(arg1, arg2, arg0.Kengeki31)
    f41_local2[32] = REGIST_FUNC(arg1, arg2, arg0.Kengeki32)
    f41_local2[33] = REGIST_FUNC(arg1, arg2, arg0.Kengeki33)
    f41_local2[40] = REGIST_FUNC(arg1, arg2, arg0.Kengeki40)
    f41_local2[41] = REGIST_FUNC(arg1, arg2, arg0.Kengeki41)
    f41_local2[42] = REGIST_FUNC(arg1, arg2, arg0.Kengeki42)
    f41_local2[50] = REGIST_FUNC(arg1, arg2, arg0.NoAction)
    local f41_local6 = REGIST_FUNC(arg1, arg2, arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(arg1, arg2, f41_local1, f41_local2, f41_local6, f41_local3)
    
end

Goal.Kengeki01 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3062, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3067, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3061, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3066, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3070, TARGET_ENE_0, 9999, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3023, TARGET_ENE_0, 9999, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3075, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 5201, TARGET_ENE_0, 9999, 0, 0)
    if arg0:GetSpRate(TARGET_SELF) < 0.5 and arg0:GetDist(TARGET_ENE_0) > 4 and arg0:GetTimer(1) <= 0 then
        arg0:SetTimer(1, 30)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 3040, TARGET_ENE_0, 9999, 0, 0)
    else
        arg0:SetNumber(5, 1)
    end
    
end

Goal.Kengeki10 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3068, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki11 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki12 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 5201, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3027, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki13 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3013, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki14 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3080, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki20 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5202, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3010, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki21 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3025, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki22 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5202, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3012, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki23 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5202, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3027, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki30 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5203, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3010, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki31 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5203, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3011, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki32 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5203, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3012, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki33 = function (arg0, arg1, arg2)
    arg0:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5203, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3027, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki40 = function (arg0, arg1, arg2)
    arg0:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3021, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki41 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3022, TARGET_ENE_0, 9999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3024, TARGET_ENE_0, 10, 0, 0)
    
end

Goal.Kengeki42 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 999, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3024, TARGET_ENE_0, 10, 0, 0)
    
end

Goal.NoAction = function (arg0, arg1, arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (arg0, arg1, arg2)
    
end

Goal.Update = function (arg0, arg1, arg2)
    return default_update(arg0, arg1, arg2)
    
end

Goal.Terminate = function (arg0, arg1, arg2)
    
end


