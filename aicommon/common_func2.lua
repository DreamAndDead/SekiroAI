function Approach_and_Attack_Act(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    local f37_local0 = arg0:GetDist(TARGET_ENE_0)
    local f37_local1 = true
    if arg3 <= f37_local0 then
        f37_local1 = false
    end
    local f37_local2 = -1
    local f37_local3 = arg0:GetRandam_Int(1, 100)
    if f37_local3 <= arg4 then
        f37_local2 = 9910
    end
    local f37_local4 = get_first_not_nil(arg7, 1.5)
    local f37_local5 = get_first_not_nil(arg8, 20)

    arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, arg2, TARGET_SELF, f37_local1, f37_local2)
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, arg5, TARGET_ENE_0, arg6, f37_local4, f37_local5)
end

function Approach_and_GuardBreak_Act(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    local f39_local0 = arg0:GetDist(TARGET_ENE_0)
    local f39_local1 = true
    if arg3 <= f39_local0 then
        f39_local1 = false
    end
    local f39_local2 = -1
    local f39_local3 = arg0:GetRandam_Int(1, 100)
    if f39_local3 <= arg4 then
        f39_local2 = 9910
    end
    arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, arg2, TARGET_SELF, f39_local1, f39_local2)
    arg1:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10, arg5, TARGET_ENE_0, arg6, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, arg7, TARGET_ENE_0, arg8, 0)
end

--[[
    调整站位的 act
]]
function GetWellSpace_Act(self, goal_manager, arg2, arg3, arg4, arg5, arg6, arg7)
    local f40_local0 = -1
    local f40_local1 = self:GetRandam_Int(1, 100)
    if f40_local1 <= arg2 then
        f40_local0 = 9910
    end

    local f40_local2 = self:GetRandam_Int(1, 100)
    local f40_local3 = self:GetRandam_Int(0, 1)
    local f40_local4 = self:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L + f40_local3, TARGET_ENE_0, 2)
    if f40_local2 <= arg3 then

    elseif f40_local2 <= arg3 + arg4 and f40_local4 < 2 then
        goal_manager:AddSubGoal(GOAL_COMMON_LeaveTarget, 2.5, TARGET_ENE_0, 2, TARGET_ENE_0, true, f40_local0)
        goal_manager:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f40_local3, self:GetRandam_Int(30, 45), true, true,
            f40_local0)
    elseif f40_local2 <= arg3 + arg4 + arg5 then
        goal_manager:AddSubGoal(GOAL_COMMON_LeaveTarget, 2.5, TARGET_ENE_0, 3, TARGET_ENE_0, true, f40_local0)
    elseif f40_local2 <= arg3 + arg4 + arg5 + arg6 then
        goal_manager:AddSubGoal(GOAL_COMMON_Wait, self:GetRandam_Float(0.5, 1), 0, 0, 0, 0)
    else
        goal_manager:AddSubGoal(GOAL_COMMON_SpinStep, 5, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4)
    end
end

function Shoot_Act(arg0, arg1, arg2, arg3, arg4)
    if arg4 == 1 then
        arg1:AddSubGoal(GOAL_COMMON_Attack, 10, arg2, TARGET_ENE_0, DIST_None, 0)
    elseif arg4 >= 2 then
        arg1:AddSubGoal(GOAL_COMMON_ComboAttack, 10, arg2, TARGET_ENE_0, DIST_None, 0)
        if arg4 >= 3 then
            arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, arg3, TARGET_ENE_0, DIST_None, 0)
            if arg4 >= 4 then
                arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, arg3, TARGET_ENE_0, DIST_None, 0)
                if arg4 >= 5 then
                    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, arg3, TARGET_ENE_0, DIST_None, 0)
                end
            end
        end
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, arg3, TARGET_ENE_0, DIST_None, 0)
    end
end

function Approach_Act(arg0, arg1, arg2, arg3, arg4, arg5)
    if arg5 == nil then
        arg5 = 10
    end
    local f43_local0 = arg0:GetDist(TARGET_ENE_0)
    local f43_local1 = true
    if arg3 <= f43_local0 then
        f43_local1 = false
    end
    local f43_local2 = -1
    local f43_local3 = arg0:GetRandam_Int(1, 100)
    if f43_local3 <= arg4 then
        f43_local2 = 9910
    end
    arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, arg5, TARGET_ENE_0, arg2, TARGET_SELF, f43_local1, f43_local2)
end

function Watching_Parry_Chance_Act(arg0, arg1)
    FirstDist = arg0:GetRandam_Float(2, 4)
    SecondDist = arg0:GetRandam_Float(2, 4)
    arg1:AddSubGoal(GOAL_COMMON_KeepDist, 5, TARGET_ENE_0, FirstDist, FirstDist + 0.5, TARGET_ENE_0, true, 9920)
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, arg0:GetRandam_Float(3, 5), TARGET_ENE_0, arg0:GetRandam_Int(0, 1), 180,
        true, true, 9920)
    arg1:AddSubGoal(GOAL_COMMON_KeepDist, 5, TARGET_ENE_0, SecondDist, SecondDist + 0.5, TARGET_ENE_0, true, 9920)
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, arg0:GetRandam_Float(3, 5), TARGET_ENE_0, arg0:GetRandam_Int(0, 1), 180,
        true, true, 9920)
end

function SelectOddsIndex(arg0, arg1)
    local f52_local0 = table.getn(arg1)
    local f52_local1 = 0
    for f52_local2 = 1, f52_local0, 1 do
        f52_local1 = f52_local1 + arg1[f52_local2]
    end
    local f52_local2 = arg0:GetRandam_Int(0, f52_local1 - 1)
    for f52_local3 = 1, f52_local0, 1 do
        local f52_local6 = arg1[f52_local3]
        if f52_local2 < f52_local6 then
            return f52_local3
        end
        f52_local2 = f52_local2 - f52_local6
    end
    local f52_local3 = -1
    return f52_local3
end