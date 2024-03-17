local act_list_max_size = 50

function Common_Clear_Param(weight_list, func_list, default_param_list)
    for i = 1, act_list_max_size, 1 do
        weight_list[i] = 0
        func_list[i] = nil
        default_param_list[i] = {}
    end
end

--[[
    主动计划，根据权重调用 act list 中的 act
]]
function Common_Battle_Activate(self, goal_manager, act_weight_list, act_list, act_after_adjust_space,
                                default_act_param_list)
    local merged_act_list = {}
    local merged_act_weight = {}
    local total_weight = 0
    local default_act_list = { function()
        return Default_Act_01(self, goal_manager, default_act_param_list[1])
    end
    , function()
        return defAct02(self, goal_manager, default_act_param_list[2])
    end
    , function()
        return defAct03(self, goal_manager, default_act_param_list[3])
    end
    , function()
        return defAct04(self, goal_manager, default_act_param_list[4])
    end
    , function()
        return defAct05(self, goal_manager, default_act_param_list[5])
    end
    , function()
        return defAct06(self, goal_manager, default_act_param_list[6])
    end
    , function()
        return defAct07(self, goal_manager, default_act_param_list[7])
    end
    , function()
        return defAct08(self, goal_manager, default_act_param_list[8])
    end
    , function()
        return defAct09(self, goal_manager, default_act_param_list[9])
    end
    , function()
        return defAct10(self, goal_manager, default_act_param_list[10])
    end
    , function()
        return defAct11(self, goal_manager, default_act_param_list[11])
    end
    , function()
        return defAct12(self, goal_manager, default_act_param_list[12])
    end
    , function()
        return defAct13(self, goal_manager, default_act_param_list[13])
    end
    , function()
        return defAct14(self, goal_manager, default_act_param_list[14])
    end
    , function()
        return defAct15(self, goal_manager, default_act_param_list[15])
    end
    , function()
        return defAct16(self, goal_manager, default_act_param_list[16])
    end
    , function()
        return defAct17(self, goal_manager, default_act_param_list[17])
    end
    , function()
        return defAct18(self, goal_manager, default_act_param_list[18])
    end
    , function()
        return defAct19(self, goal_manager, default_act_param_list[19])
    end
    , function()
        return defAct20(self, goal_manager, default_act_param_list[20])
    end
    , function()
        return defAct21(self, goal_manager, default_act_param_list[21])
    end
    , function()
        return defAct22(self, goal_manager, default_act_param_list[22])
    end
    , function()
        return defAct23(self, goal_manager, default_act_param_list[23])
    end
    , function()
        return defAct24(self, goal_manager, default_act_param_list[24])
    end
    , function()
        return defAct25(self, goal_manager, default_act_param_list[25])
    end
    , function()
        return defAct26(self, goal_manager, default_act_param_list[26])
    end
    , function()
        return defAct27(self, goal_manager, default_act_param_list[27])
    end
    , function()
        return defAct28(self, goal_manager, default_act_param_list[28])
    end
    , function()
        return defAct29(self, goal_manager, default_act_param_list[29])
    end
    , function()
        return defAct30(self, goal_manager, default_act_param_list[30])
    end
    , function()
        return defAct31(self, goal_manager, default_act_param_list[31])
    end
    , function()
        return defAct32(self, goal_manager, default_act_param_list[32])
    end
    , function()
        return defAct33(self, goal_manager, default_act_param_list[33])
    end
    , function()
        return defAct34(self, goal_manager, default_act_param_list[34])
    end
    , function()
        return defAct35(self, goal_manager, default_act_param_list[35])
    end
    , function()
        return defAct36(self, goal_manager, default_act_param_list[36])
    end
    , function()
        return defAct37(self, goal_manager, default_act_param_list[37])
    end
    , function()
        return defAct38(self, goal_manager, default_act_param_list[38])
    end
    , function()
        return defAct39(self, goal_manager, default_act_param_list[39])
    end
    , function()
        return defAct40(self, goal_manager, default_act_param_list[40])
    end
    , function()
        return defAct41(self, goal_manager, default_act_param_list[41])
    end
    , function()
        return defAct42(self, goal_manager, default_act_param_list[42])
    end
    , function()
        return defAct43(self, goal_manager, default_act_param_list[43])
    end
    , function()
        return defAct44(self, goal_manager, default_act_param_list[44])
    end
    , function()
        return defAct45(self, goal_manager, default_act_param_list[45])
    end
    , function()
        return defAct46(self, goal_manager, default_act_param_list[46])
    end
    , function()
        return defAct47(self, goal_manager, default_act_param_list[47])
    end
    , function()
        return defAct48(self, goal_manager, default_act_param_list[48])
    end
    , function()
        return defAct49(self, goal_manager, default_act_param_list[49])
    end
    , function()
        return defAct50(self, goal_manager, default_act_param_list[50])
    end
    }

    for i = 1, act_list_max_size, 1 do
        if act_list[i] ~= nil then
            merged_act_list[i] = act_list[i]
        else
            merged_act_list[i] = default_act_list[i]
        end
        merged_act_weight[i] = act_weight_list[i]
        total_weight = total_weight + merged_act_weight[i]
    end

    if act_after_adjust_space == nil then
        act_after_adjust_space = function()
            HumanCommon_ActAfter_AdjustSpace(self, goal_manager, atkAfterOddsTbl)
        end
    end

    local get_well_space_odd = 0
    local force_act_index = 0
    force_act_index = self:DbgGetForceActIdx()
    if 0 < force_act_index and force_act_index <= act_list_max_size then
        get_well_space_odd = merged_act_list[force_act_index]()
        self:DbgSetLastActIdx(force_act_index)
    else
        local rand_int_weight = self:GetRandam_Int(1, total_weight)
        local total_weight_until = 0
        for i = 1, act_list_max_size, 1 do
            total_weight_until = total_weight_until + merged_act_weight[i]
            if rand_int_weight <= total_weight_until then
                get_well_space_odd = merged_act_list[i]()
                self:DbgSetLastActIdx(i)
            end
        end
    end

    local rand_int_1t100 = self:GetRandam_Int(1, 100)
    if get_well_space_odd == nil then
        get_well_space_odd = 0
    end

    if rand_int_1t100 <= get_well_space_odd then
        act_after_adjust_space()
    end
end

--[[
    return true if any act activates
]]
function Common_Kengeki_Activate(self, goal_manager, act_weights, act_funcs, act_after_adjust_space, act_default_params)
    local merged_act_funcs = {}
    local merged_act_weights = {}
    local total_weight = 0

    local default_act_funcs = { function()
        return Default_Act_01(self, goal_manager, act_default_params[1])
    end
    , function()
        return defAct02(self, goal_manager, act_default_params[2])
    end
    , function()
        return defAct03(self, goal_manager, act_default_params[3])
    end
    , function()
        return defAct04(self, goal_manager, act_default_params[4])
    end
    , function()
        return defAct05(self, goal_manager, act_default_params[5])
    end
    , function()
        return defAct06(self, goal_manager, act_default_params[6])
    end
    , function()
        return defAct07(self, goal_manager, act_default_params[7])
    end
    , function()
        return defAct08(self, goal_manager, act_default_params[8])
    end
    , function()
        return defAct09(self, goal_manager, act_default_params[9])
    end
    , function()
        return defAct10(self, goal_manager, act_default_params[10])
    end
    , function()
        return defAct11(self, goal_manager, act_default_params[11])
    end
    , function()
        return defAct12(self, goal_manager, act_default_params[12])
    end
    , function()
        return defAct13(self, goal_manager, act_default_params[13])
    end
    , function()
        return defAct14(self, goal_manager, act_default_params[14])
    end
    , function()
        return defAct15(self, goal_manager, act_default_params[15])
    end
    , function()
        return defAct16(self, goal_manager, act_default_params[16])
    end
    , function()
        return defAct17(self, goal_manager, act_default_params[17])
    end
    , function()
        return defAct18(self, goal_manager, act_default_params[18])
    end
    , function()
        return defAct19(self, goal_manager, act_default_params[19])
    end
    , function()
        return defAct20(self, goal_manager, act_default_params[20])
    end
    , function()
        return defAct21(self, goal_manager, act_default_params[21])
    end
    , function()
        return defAct22(self, goal_manager, act_default_params[22])
    end
    , function()
        return defAct23(self, goal_manager, act_default_params[23])
    end
    , function()
        return defAct24(self, goal_manager, act_default_params[24])
    end
    , function()
        return defAct25(self, goal_manager, act_default_params[25])
    end
    , function()
        return defAct26(self, goal_manager, act_default_params[26])
    end
    , function()
        return defAct27(self, goal_manager, act_default_params[27])
    end
    , function()
        return defAct28(self, goal_manager, act_default_params[28])
    end
    , function()
        return defAct29(self, goal_manager, act_default_params[29])
    end
    , function()
        return defAct30(self, goal_manager, act_default_params[30])
    end
    , function()
        return defAct31(self, goal_manager, act_default_params[31])
    end
    , function()
        return defAct32(self, goal_manager, act_default_params[32])
    end
    , function()
        return defAct33(self, goal_manager, act_default_params[33])
    end
    , function()
        return defAct34(self, goal_manager, act_default_params[34])
    end
    , function()
        return defAct35(self, goal_manager, act_default_params[35])
    end
    , function()
        return defAct36(self, goal_manager, act_default_params[36])
    end
    , function()
        return defAct37(self, goal_manager, act_default_params[37])
    end
    , function()
        return defAct38(self, goal_manager, act_default_params[38])
    end
    , function()
        return defAct39(self, goal_manager, act_default_params[39])
    end
    , function()
        return defAct40(self, goal_manager, act_default_params[40])
    end
    , function()
        return defAct41(self, goal_manager, act_default_params[41])
    end
    , function()
        return defAct42(self, goal_manager, act_default_params[42])
    end
    , function()
        return defAct43(self, goal_manager, act_default_params[43])
    end
    , function()
        return defAct44(self, goal_manager, act_default_params[44])
    end
    , function()
        return defAct45(self, goal_manager, act_default_params[45])
    end
    , function()
        return defAct46(self, goal_manager, act_default_params[46])
    end
    , function()
        return defAct47(self, goal_manager, act_default_params[47])
    end
    , function()
        return defAct48(self, goal_manager, act_default_params[48])
    end
    , function()
        return defAct49(self, goal_manager, act_default_params[49])
    end
    , function()
        return defAct50(self, goal_manager, act_default_params[50])
    end
    }

    for i = 1, act_list_max_size, 1 do
        if act_funcs[i] ~= nil then
            merged_act_funcs[i] = act_funcs[i]
        else
            merged_act_funcs[i] = default_act_funcs[i]
        end

        merged_act_weights[i] = act_weights[i]
        total_weight = total_weight + merged_act_weights[i]
    end

    if act_after_adjust_space == nil then
        act_after_adjust_space = function()
            HumanCommon_ActAfter_AdjustSpace(self, goal_manager, atkAfterOddsTbl)
        end
    end

    local get_well_space_odd = 0
    -- 0 means no debug
    local force_kengeki_index = self:DbgGetForceKengekiActIdx()
    -- debug in game developer menu
    if 0 < force_kengeki_index and force_kengeki_index <= act_list_max_size then
        get_well_space_odd = merged_act_funcs[force_kengeki_index]()
        self:DbgSetLastKengekiActIdx(force_kengeki_index)
    else
        local rand_int = self:GetRandam_Int(1, total_weight)

        local total_weight_until = 0
        for i = 1, act_list_max_size, 1 do
            total_weight_until = total_weight_until + merged_act_weights[i]
            if rand_int <= total_weight_until then
                get_well_space_odd = merged_act_funcs[i]()
                self:DbgSetLastKengekiActIdx(i)
            end
        end
    end

    if get_well_space_odd == nil then
        get_well_space_odd = 0
    end

    if self:GetRandam_Int(1, 100) <= get_well_space_odd then
        act_after_adjust_space()
    end

    if (total_weight == 0 or get_well_space_odd == -1) and force_kengeki_index == 0 then
        return false
    else
        return true
    end
end

function Default_Act_01(self, goal_manager, param)
    local p = { 1.5, 0, 3000, DIST_Middle, nil }

    if param[1] ~= nil then
        p = param
    end

    local f4_local1 = p[1]
    local f4_local2 = p[1] + 2
    local f4_local3 = p[2]
    local f4_local4 = p[3]
    local f4_local5 = p[4]

    local f4_local6 = get_first_not_nil(p[5], 100)

    Approach_and_Attack_Act(self, goal_manager, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5)

    return f4_local6
end

function defAct02(arg0, arg1, arg2)
    local f5_local0 = {}
    local f5_local1, f5_local2, f5_local3, f5_local4 = nil
    f5_local0[1] = 1.5
    f5_local0[2] = 0
    f5_local0[3] = 10
    f5_local0[4] = 40
    f5_local0[5] = f5_local1
    f5_local0[6] = f5_local2
    f5_local0[7] = f5_local3
    f5_local0[8] = f5_local4
    if arg2[1] ~= nil then
        f5_local0 = arg2
    end
    
    return HumanCommon_Approach_and_ComboAtk(arg0, arg1, f5_local0)
end

function defAct03(arg0, arg1, arg2)
    local f6_local0 = { 1.5, 0, 3005, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f6_local0 = arg2
    end
    local f6_local1 = f6_local0[1]
    local f6_local2 = f6_local0[1] + 2
    local f6_local3 = f6_local0[2]
    local f6_local4 = f6_local0[3]
    local f6_local5 = f6_local0[4]
    local f6_local6 = get_first_not_nil(f6_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5)
    return f6_local6
end

function defAct04(arg0, arg1, arg2)
    local f7_local0 = { 5, 0, 3007, DIST_Middle, 3005, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f7_local0 = arg2
    end
    local f7_local1 = f7_local0[1]
    local f7_local2 = f7_local0[1] + 2
    local f7_local3 = f7_local0[2]
    local f7_local4 = f7_local0[3]
    local f7_local5 = f7_local0[4]
    local f7_local6 = f7_local0[5]
    local f7_local7 = f7_local0[6]
    local f7_local8 = get_first_not_nil(f7_local0[7], 100)
    Approach_and_GuardBreak_Act(arg0, arg1, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7)
    return f7_local8
end

--[[
    keep dist and attack
]]
function defAct05(arg0, arg1, param)
    local p = { 4, 6, 0, 3008, DIST_None, nil }
    if param[1] ~= nil then
        p = param
    end

    local arg2 = p[1]
    local arg3 = p[2]
    local arg4 = p[2] + 2
    local arg5 = p[3]
    local arg6 = p[4]
    local arg7 = p[5]

    local f38_local0 = arg0:GetDist(TARGET_ENE_0)
    local f38_local1 = true
    if arg4 <= f38_local0 then
        f38_local1 = false
    end
    local f38_local2 = -1
    local f38_local3 = arg0:GetRandam_Int(1, 100)
    if f38_local3 <= arg5 then
        f38_local2 = 9910
    end

    arg1:AddSubGoal(GOAL_COMMON_KeepDist, 10, TARGET_ENE_0, arg2, arg3, TARGET_ENE_0, f38_local1, f38_local2)
    arg1:AddSubGoal(GOAL_COMMON_Attack, 10, arg6, TARGET_ENE_0, arg7, 0)

    return get_first_not_nil(p[6], 0)
end

function defAct06(arg0, arg1, arg2)
    local f9_local0 = { 3000, DIST_Far, nil }
    if arg2[1] ~= nil then
        f9_local0 = arg2
    end
    local f9_local1 = get_first_not_nil(f9_local0[3], 0)
    arg1:AddSubGoal(GOAL_COMMON_Attack, 10, f9_local0[1], TARGET_ENE_0, f9_local0[2], 0)
    return f9_local1
end

function defAct07(arg0, arg1, arg2)
    local f10_local0 = { 1.5, 0, 3001, DIST_Middle }
    local f10_local1 = arg2[1]
    if f10_local1 ~= nil then
        f10_local0 = arg2
    end
    f10_local1 = f10_local0[1]
    local f10_local2 = f10_local0[1] + 2
    local f10_local3 = f10_local0[2]
    local f10_local4 = f10_local0[3]
    local f10_local5 = f10_local0[4]
    Approach_and_Attack_Act(arg0, arg1, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5)
    return 100
end

function defAct08(arg0, arg1, arg2)
    local f11_local0 = { nil }
    if arg2[1] ~= nil then
        f11_local0 = arg2
    end
    local f11_local1 = get_first_not_nil(f11_local0[1], 0)
    Watching_Parry_Chance_Act(arg0, arg1)
    return f11_local1
end

function defAct09(arg0, arg1, arg2)
    local f12_local0 = {}
    local f12_local1, f12_local2, f12_local3, f12_local4 = nil
    f12_local0[1] = 1.5
    f12_local0[2] = 0
    f12_local0[3] = 10
    f12_local0[4] = 40
    f12_local0[5] = f12_local1
    f12_local0[6] = f12_local2
    f12_local0[7] = f12_local3
    f12_local0[8] = f12_local4
    if arg2[1] ~= nil then
        f12_local0 = arg2
    end
    return HumanCommon_Approach_and_ComboAtk(arg0, arg1, f12_local0)
end

function defAct10(arg0, arg1, arg2)
    local f13_local0 = { 3000, 3001, 2, 4, 0 }
    if arg2[1] ~= nil then
        f13_local0 = arg2
    end
    return HumanCommon_Shooting_Act(arg0, arg1, f13_local0)
end

function defAct11(arg0, arg1, arg2)
    local f14_local0 = { 3002, 3003, 2, 4, 0 }
    if arg2[1] ~= nil then
        f14_local0 = arg2
    end
    return HumanCommon_Shooting_Act(arg0, arg1, f14_local0)
end

function defAct12(arg0, arg1, arg2)
    local f15_local0 = { 1.5, 0, 3001, DIST_Middle }
    local f15_local1 = arg2[1]
    if f15_local1 ~= nil then
        f15_local0 = arg2
    end
    f15_local1 = f15_local0[1]
    local f15_local2 = f15_local0[1] + 2
    local f15_local3 = f15_local0[2]
    local f15_local4 = f15_local0[3]
    local f15_local5 = f15_local0[4]
    Approach_and_Attack_Act(arg0, arg1, f15_local1, f15_local2, f15_local3, f15_local4, f15_local5)
    return 100
end

function defAct13(arg0, arg1, arg2)
    local f16_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f16_local0 = arg2
    end
    local f16_local1 = f16_local0[1]
    local f16_local2 = f16_local0[1] + 2
    local f16_local3 = f16_local0[2]
    local f16_local4 = f16_local0[3]
    local f16_local5 = f16_local0[4]
    local f16_local6 = get_first_not_nil(f16_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f16_local1, f16_local2, f16_local3, f16_local4, f16_local5)
    return f16_local6
end

function defAct14(arg0, arg1, arg2)
    local f17_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f17_local0 = arg2
    end
    local f17_local1 = f17_local0[1]
    local f17_local2 = f17_local0[1] + 2
    local f17_local3 = f17_local0[2]
    local f17_local4 = f17_local0[3]
    local f17_local5 = f17_local0[4]
    local f17_local6 = get_first_not_nil(f17_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f17_local1, f17_local2, f17_local3, f17_local4, f17_local5)
    return f17_local6
end

function defAct15(arg0, arg1, arg2)
    local f18_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f18_local0 = arg2
    end
    local f18_local1 = f18_local0[1]
    local f18_local2 = f18_local0[1] + 2
    local f18_local3 = f18_local0[2]
    local f18_local4 = f18_local0[3]
    local f18_local5 = f18_local0[4]
    local f18_local6 = get_first_not_nil(f18_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f18_local1, f18_local2, f18_local3, f18_local4, f18_local5)
    return f18_local6
end

function defAct16(arg0, arg1, arg2)
    local f19_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f19_local0 = arg2
    end
    local f19_local1 = f19_local0[1]
    local f19_local2 = f19_local0[1] + 2
    local f19_local3 = f19_local0[2]
    local f19_local4 = f19_local0[3]
    local f19_local5 = f19_local0[4]
    local f19_local6 = get_first_not_nil(f19_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f19_local1, f19_local2, f19_local3, f19_local4, f19_local5)
    return f19_local6
end

function defAct17(arg0, arg1, arg2)
    local f20_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f20_local0 = arg2
    end
    local f20_local1 = f20_local0[1]
    local f20_local2 = f20_local0[1] + 2
    local f20_local3 = f20_local0[2]
    local f20_local4 = f20_local0[3]
    local f20_local5 = f20_local0[4]
    local f20_local6 = get_first_not_nil(f20_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f20_local1, f20_local2, f20_local3, f20_local4, f20_local5)
    return f20_local6
end

function defAct18(arg0, arg1, arg2)
    local f21_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f21_local0 = arg2
    end
    local f21_local1 = f21_local0[1]
    local f21_local2 = f21_local0[1] + 2
    local f21_local3 = f21_local0[2]
    local f21_local4 = f21_local0[3]
    local f21_local5 = f21_local0[4]
    local f21_local6 = get_first_not_nil(f21_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f21_local1, f21_local2, f21_local3, f21_local4, f21_local5)
    return f21_local6
end

function defAct19(arg0, arg1, arg2)
    local f22_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f22_local0 = arg2
    end
    local f22_local1 = f22_local0[1]
    local f22_local2 = f22_local0[1] + 2
    local f22_local3 = f22_local0[2]
    local f22_local4 = f22_local0[3]
    local f22_local5 = f22_local0[4]
    local f22_local6 = get_first_not_nil(f22_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f22_local1, f22_local2, f22_local3, f22_local4, f22_local5)
    return f22_local6
end

function defAct20(arg0, arg1, arg2)
    local f23_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f23_local0 = arg2
    end
    local f23_local1 = f23_local0[1]
    local f23_local2 = f23_local0[1] + 2
    local f23_local3 = f23_local0[2]
    local f23_local4 = f23_local0[3]
    local f23_local5 = f23_local0[4]
    local f23_local6 = get_first_not_nil(f23_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f23_local1, f23_local2, f23_local3, f23_local4, f23_local5)
    return f23_local6
end

function defAct21(arg0, arg1, arg2)
    local f24_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f24_local0 = arg2
    end
    local f24_local1 = f24_local0[1]
    local f24_local2 = f24_local0[1] + 2
    local f24_local3 = f24_local0[2]
    local f24_local4 = f24_local0[3]
    local f24_local5 = f24_local0[4]
    local f24_local6 = get_first_not_nil(f24_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f24_local1, f24_local2, f24_local3, f24_local4, f24_local5)
    return f24_local6
end

function defAct22(arg0, arg1, arg2)
    local f25_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f25_local0 = arg2
    end
    local f25_local1 = f25_local0[1]
    local f25_local2 = f25_local0[1] + 2
    local f25_local3 = f25_local0[2]
    local f25_local4 = f25_local0[3]
    local f25_local5 = f25_local0[4]
    local f25_local6 = get_first_not_nil(f25_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f25_local1, f25_local2, f25_local3, f25_local4, f25_local5)
    return f25_local6
end

function defAct23(arg0, arg1, arg2)
    local f26_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f26_local0 = arg2
    end
    local f26_local1 = f26_local0[1]
    local f26_local2 = f26_local0[1] + 2
    local f26_local3 = f26_local0[2]
    local f26_local4 = f26_local0[3]
    local f26_local5 = f26_local0[4]
    local f26_local6 = get_first_not_nil(f26_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f26_local1, f26_local2, f26_local3, f26_local4, f26_local5)
    return f26_local6
end

function defAct24(arg0, arg1, arg2)
    local f27_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f27_local0 = arg2
    end
    local f27_local1 = f27_local0[1]
    local f27_local2 = f27_local0[1] + 2
    local f27_local3 = f27_local0[2]
    local f27_local4 = f27_local0[3]
    local f27_local5 = f27_local0[4]
    local f27_local6 = get_first_not_nil(f27_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f27_local1, f27_local2, f27_local3, f27_local4, f27_local5)
    return f27_local6
end

function defAct25(arg0, arg1, arg2)
    local f28_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f28_local0 = arg2
    end
    local f28_local1 = f28_local0[1]
    local f28_local2 = f28_local0[1] + 2
    local f28_local3 = f28_local0[2]
    local f28_local4 = f28_local0[3]
    local f28_local5 = f28_local0[4]
    local f28_local6 = get_first_not_nil(f28_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f28_local1, f28_local2, f28_local3, f28_local4, f28_local5)
    return f28_local6
end

function defAct26(arg0, arg1, arg2)
    local f29_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f29_local0 = arg2
    end
    local f29_local1 = f29_local0[1]
    local f29_local2 = f29_local0[1] + 2
    local f29_local3 = f29_local0[2]
    local f29_local4 = f29_local0[3]
    local f29_local5 = f29_local0[4]
    local f29_local6 = get_first_not_nil(f29_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f29_local1, f29_local2, f29_local3, f29_local4, f29_local5)
    return f29_local6
end

function defAct27(arg0, arg1, arg2)
    local f30_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f30_local0 = arg2
    end
    local f30_local1 = f30_local0[1]
    local f30_local2 = f30_local0[1] + 2
    local f30_local3 = f30_local0[2]
    local f30_local4 = f30_local0[3]
    local f30_local5 = f30_local0[4]
    local f30_local6 = get_first_not_nil(f30_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f30_local1, f30_local2, f30_local3, f30_local4, f30_local5)
    return f30_local6
end

function defAct28(arg0, arg1, arg2)
    local f31_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f31_local0 = arg2
    end
    local f31_local1 = f31_local0[1]
    local f31_local2 = f31_local0[1] + 2
    local f31_local3 = f31_local0[2]
    local f31_local4 = f31_local0[3]
    local f31_local5 = f31_local0[4]
    local f31_local6 = get_first_not_nil(f31_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f31_local1, f31_local2, f31_local3, f31_local4, f31_local5)
    return f31_local6
end

function defAct29(arg0, arg1, arg2)
    local f32_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f32_local0 = arg2
    end
    local f32_local1 = f32_local0[1]
    local f32_local2 = f32_local0[1] + 2
    local f32_local3 = f32_local0[2]
    local f32_local4 = f32_local0[3]
    local f32_local5 = f32_local0[4]
    local f32_local6 = get_first_not_nil(f32_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f32_local1, f32_local2, f32_local3, f32_local4, f32_local5)
    return f32_local6
end

function defAct30(arg0, arg1, arg2)
    local f33_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f33_local0 = arg2
    end
    local f33_local1 = f33_local0[1]
    local f33_local2 = f33_local0[1] + 2
    local f33_local3 = f33_local0[2]
    local f33_local4 = f33_local0[3]
    local f33_local5 = f33_local0[4]
    local f33_local6 = get_first_not_nil(f33_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f33_local1, f33_local2, f33_local3, f33_local4, f33_local5)
    return f33_local6
end

function defAct31(arg0, arg1, arg2)
    local f34_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f34_local0 = arg2
    end
    local f34_local1 = f34_local0[1]
    local f34_local2 = f34_local0[1] + 2
    local f34_local3 = f34_local0[2]
    local f34_local4 = f34_local0[3]
    local f34_local5 = f34_local0[4]
    local f34_local6 = get_first_not_nil(f34_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f34_local1, f34_local2, f34_local3, f34_local4, f34_local5)
    return f34_local6
end

function defAct32(arg0, arg1, arg2)
    local f35_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f35_local0 = arg2
    end
    local f35_local1 = f35_local0[1]
    local f35_local2 = f35_local0[1] + 2
    local f35_local3 = f35_local0[2]
    local f35_local4 = f35_local0[3]
    local f35_local5 = f35_local0[4]
    local f35_local6 = get_first_not_nil(f35_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f35_local1, f35_local2, f35_local3, f35_local4, f35_local5)
    return f35_local6
end

function defAct33(arg0, arg1, arg2)
    local f36_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f36_local0 = arg2
    end
    local f36_local1 = f36_local0[1]
    local f36_local2 = f36_local0[1] + 2
    local f36_local3 = f36_local0[2]
    local f36_local4 = f36_local0[3]
    local f36_local5 = f36_local0[4]
    local f36_local6 = get_first_not_nil(f36_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f36_local1, f36_local2, f36_local3, f36_local4, f36_local5)
    return f36_local6
end

function defAct34(arg0, arg1, arg2)
    local f37_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f37_local0 = arg2
    end
    local f37_local1 = f37_local0[1]
    local f37_local2 = f37_local0[1] + 2
    local f37_local3 = f37_local0[2]
    local f37_local4 = f37_local0[3]
    local f37_local5 = f37_local0[4]
    local f37_local6 = get_first_not_nil(f37_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f37_local1, f37_local2, f37_local3, f37_local4, f37_local5)
    return f37_local6
end

function defAct35(arg0, arg1, arg2)
    local f38_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f38_local0 = arg2
    end
    local f38_local1 = f38_local0[1]
    local f38_local2 = f38_local0[1] + 2
    local f38_local3 = f38_local0[2]
    local f38_local4 = f38_local0[3]
    local f38_local5 = f38_local0[4]
    local f38_local6 = get_first_not_nil(f38_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f38_local1, f38_local2, f38_local3, f38_local4, f38_local5)
    return f38_local6
end

function defAct36(arg0, arg1, arg2)
    local f39_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f39_local0 = arg2
    end
    local f39_local1 = f39_local0[1]
    local f39_local2 = f39_local0[1] + 2
    local f39_local3 = f39_local0[2]
    local f39_local4 = f39_local0[3]
    local f39_local5 = f39_local0[4]
    local f39_local6 = get_first_not_nil(f39_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f39_local1, f39_local2, f39_local3, f39_local4, f39_local5)
    return f39_local6
end

function defAct37(arg0, arg1, arg2)
    local f40_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f40_local0 = arg2
    end
    local f40_local1 = f40_local0[1]
    local f40_local2 = f40_local0[1] + 2
    local f40_local3 = f40_local0[2]
    local f40_local4 = f40_local0[3]
    local f40_local5 = f40_local0[4]
    local f40_local6 = get_first_not_nil(f40_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f40_local1, f40_local2, f40_local3, f40_local4, f40_local5)
    return f40_local6
end

function defAct38(arg0, arg1, arg2)
    local f41_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f41_local0 = arg2
    end
    local f41_local1 = f41_local0[1]
    local f41_local2 = f41_local0[1] + 2
    local f41_local3 = f41_local0[2]
    local f41_local4 = f41_local0[3]
    local f41_local5 = f41_local0[4]
    local f41_local6 = get_first_not_nil(f41_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f41_local1, f41_local2, f41_local3, f41_local4, f41_local5)
    return f41_local6
end

function defAct39(arg0, arg1, arg2)
    local f42_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f42_local0 = arg2
    end
    local f42_local1 = f42_local0[1]
    local f42_local2 = f42_local0[1] + 2
    local f42_local3 = f42_local0[2]
    local f42_local4 = f42_local0[3]
    local f42_local5 = f42_local0[4]
    local f42_local6 = get_first_not_nil(f42_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f42_local1, f42_local2, f42_local3, f42_local4, f42_local5)
    return f42_local6
end

function defAct40(arg0, arg1, arg2)
    local f43_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f43_local0 = arg2
    end
    local f43_local1 = f43_local0[1]
    local f43_local2 = f43_local0[1] + 2
    local f43_local3 = f43_local0[2]
    local f43_local4 = f43_local0[3]
    local f43_local5 = f43_local0[4]
    local f43_local6 = get_first_not_nil(f43_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f43_local1, f43_local2, f43_local3, f43_local4, f43_local5)
    return f43_local6
end

function defAct41(arg0, arg1, arg2)
    local f44_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f44_local0 = arg2
    end
    local f44_local1 = f44_local0[1]
    local f44_local2 = f44_local0[1] + 2
    local f44_local3 = f44_local0[2]
    local f44_local4 = f44_local0[3]
    local f44_local5 = f44_local0[4]
    local f44_local6 = get_first_not_nil(f44_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f44_local1, f44_local2, f44_local3, f44_local4, f44_local5)
    return f44_local6
end

function defAct42(arg0, arg1, arg2)
    local f45_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f45_local0 = arg2
    end
    local f45_local1 = f45_local0[1]
    local f45_local2 = f45_local0[1] + 2
    local f45_local3 = f45_local0[2]
    local f45_local4 = f45_local0[3]
    local f45_local5 = f45_local0[4]
    local f45_local6 = get_first_not_nil(f45_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f45_local1, f45_local2, f45_local3, f45_local4, f45_local5)
    return f45_local6
end

function defAct43(arg0, arg1, arg2)
    local f46_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f46_local0 = arg2
    end
    local f46_local1 = f46_local0[1]
    local f46_local2 = f46_local0[1] + 2
    local f46_local3 = f46_local0[2]
    local f46_local4 = f46_local0[3]
    local f46_local5 = f46_local0[4]
    local f46_local6 = get_first_not_nil(f46_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f46_local1, f46_local2, f46_local3, f46_local4, f46_local5)
    return f46_local6
end

function defAct44(arg0, arg1, arg2)
    local f47_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f47_local0 = arg2
    end
    local f47_local1 = f47_local0[1]
    local f47_local2 = f47_local0[1] + 2
    local f47_local3 = f47_local0[2]
    local f47_local4 = f47_local0[3]
    local f47_local5 = f47_local0[4]
    local f47_local6 = get_first_not_nil(f47_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f47_local1, f47_local2, f47_local3, f47_local4, f47_local5)
    return f47_local6
end

function defAct45(arg0, arg1, arg2)
    local f48_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f48_local0 = arg2
    end
    local f48_local1 = f48_local0[1]
    local f48_local2 = f48_local0[1] + 2
    local f48_local3 = f48_local0[2]
    local f48_local4 = f48_local0[3]
    local f48_local5 = f48_local0[4]
    local f48_local6 = get_first_not_nil(f48_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f48_local1, f48_local2, f48_local3, f48_local4, f48_local5)
    return f48_local6
end

function defAct46(arg0, arg1, arg2)
    local f49_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f49_local0 = arg2
    end
    local f49_local1 = f49_local0[1]
    local f49_local2 = f49_local0[1] + 2
    local f49_local3 = f49_local0[2]
    local f49_local4 = f49_local0[3]
    local f49_local5 = f49_local0[4]
    local f49_local6 = get_first_not_nil(f49_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f49_local1, f49_local2, f49_local3, f49_local4, f49_local5)
    return f49_local6
end

function defAct47(arg0, arg1, arg2)
    local f50_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f50_local0 = arg2
    end
    local f50_local1 = f50_local0[1]
    local f50_local2 = f50_local0[1] + 2
    local f50_local3 = f50_local0[2]
    local f50_local4 = f50_local0[3]
    local f50_local5 = f50_local0[4]
    local f50_local6 = get_first_not_nil(f50_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f50_local1, f50_local2, f50_local3, f50_local4, f50_local5)
    return f50_local6
end

function defAct48(arg0, arg1, arg2)
    local f51_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f51_local0 = arg2
    end
    local f51_local1 = f51_local0[1]
    local f51_local2 = f51_local0[1] + 2
    local f51_local3 = f51_local0[2]
    local f51_local4 = f51_local0[3]
    local f51_local5 = f51_local0[4]
    local f51_local6 = get_first_not_nil(f51_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f51_local1, f51_local2, f51_local3, f51_local4, f51_local5)
    return f51_local6
end

function defAct49(arg0, arg1, arg2)
    local f52_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f52_local0 = arg2
    end
    local f52_local1 = f52_local0[1]
    local f52_local2 = f52_local0[1] + 2
    local f52_local3 = f52_local0[2]
    local f52_local4 = f52_local0[3]
    local f52_local5 = f52_local0[4]
    local f52_local6 = get_first_not_nil(f52_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f52_local1, f52_local2, f52_local3, f52_local4, f52_local5)
    return f52_local6
end

function defAct50(arg0, arg1, arg2)
    local f53_local0 = { 1.5, 0, 3000, DIST_Middle, nil }
    if arg2[1] ~= nil then
        f53_local0 = arg2
    end
    local f53_local1 = f53_local0[1]
    local f53_local2 = f53_local0[1] + 2
    local f53_local3 = f53_local0[2]
    local f53_local4 = f53_local0[3]
    local f53_local5 = f53_local0[4]
    local f53_local6 = get_first_not_nil(f53_local0[5], 100)
    Approach_and_Attack_Act(arg0, arg1, f53_local1, f53_local2, f53_local3, f53_local4, f53_local5)
    return f53_local6
end

--[[
    攻击后，调整身位，根据概率表
]]
function HumanCommon_ActAfter_AdjustSpace(self, goal_manager, odd_table)
    local f55_local0 = odd_table[1]
    local f55_local1 = odd_table[2]
    local f55_local2 = odd_table[3]
    local f55_local3 = odd_table[4]
    local f55_local4 = odd_table[5]
    local f55_local5 = odd_table[6]

    GetWellSpace_Act(self, goal_manager, f55_local0, f55_local1, f55_local2, f55_local3, f55_local4, f55_local5)
end

function HumanCommon_Approach_and_ComboAtk(arg0, arg1, arg2)
    local f57_local0 = arg2[1]
    local f57_local1 = arg2[1] + 2
    local f57_local2 = arg2[2]

    Approach_Act(arg0, arg1, f57_local0, f57_local1, f57_local2)

    local f57_local3 = get_first_not_nil(arg2[5], 3000)
    local f57_local4 = get_first_not_nil(arg2[6], 3001)
    local f57_local5 = get_first_not_nil(arg2[7], 3002)
    local f57_local6 = arg0:GetRandam_Int(1, 100)

    if f57_local6 <= arg2[3] then
        arg1:AddSubGoal(GOAL_COMMON_Attack, 10, f57_local3, TARGET_ENE_0, DIST_Middle, 0)
    elseif f57_local6 <= arg2[3] + arg2[4] then
        arg1:AddSubGoal(GOAL_COMMON_ComboAttack, 10, f57_local3, TARGET_ENE_0, DIST_Middle, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f57_local4, TARGET_ENE_0, DIST_Middle, 0)
    else
        arg1:AddSubGoal(GOAL_COMMON_ComboAttack, 10, f57_local3, TARGET_ENE_0, DIST_Middle, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f57_local4, TARGET_ENE_0, DIST_Middle, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f57_local5, TARGET_ENE_0, DIST_Middle, 0)
    end

    return get_first_not_nil(arg2[8], 100)
end

function HumanCommon_Shooting_Act(arg0, arg1, arg2)
    local f59_local0 = arg2[1]
    local f59_local1 = arg2[2]
    local f59_local2 = arg0:GetRandam_Int(arg2[3], arg2[4])
    local f59_local3 = arg2[5]

    Shoot_Act(arg0, arg1, f59_local0, f59_local1, f59_local2)

    if f59_local3 == 0 then

    elseif f59_local3 == 1 then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 2, TARGET_ENE_0, 20, TARGET_ENE_0, true, -1)
    elseif f59_local3 == 2 then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 5, TARGET_ENE_0, 20, TARGET_SELF, false, -1)
    else
        arg0:PrintText("??logical error, get the manager!?? ")
    end

    return 0
end

function get_first_not_nil(not_nil_param, nil_param)
    if not_nil_param ~= nil then
        return not_nil_param
    end
    return nil_param
end

--[[
    function p3(p1, p2, p4)
]]
function REGIST_FUNC(p1, p2, func, p3)
    return function()
        return func(p1, p2, p3)
    end
end
