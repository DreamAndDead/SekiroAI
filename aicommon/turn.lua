REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_ApproachTarget, 0, 0)

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 0, "????^?[?Q?b?g", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 1, "???????p?x", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 2, "?K?[?hEzState???", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 3, "?K?[?h?S?[???I???^?C?v", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 4, "?K?[?h?S?[???F???????s?????????????", 0)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_Turn, true)

function Turn_Activate(arg0, arg1)
    local f1_local0 = arg1:GetParam(2)

    if 0 < f1_local0 then
        arg0:DoEzAction(life_time, f1_local0)
    end
end

function Turn_Update(arg0, arg1)
    local target = arg1:GetParam(0)
    arg0:RequestEmergencyQuickTurn()
    arg0:TurnTo(target)

    if Turn_IsLookToTarget(arg0, arg1) then
        return GOAL_RESULT_Success
    end

    local f2_local1 = arg1:GetParam(2)
    local f2_local2 = arg1:GetParam(3)
    local f2_local3 = arg1:GetParam(4)

    if 0 < f2_local1 then
        if arg1:GetNumber(0) ~= 0 then
            return GOAL_RESULT_Failed
        elseif arg1:GetNumber(1) ~= 0 then
            return f2_local2
        end
    end

    if arg1:GetLife() <= 0 then
        if f2_local3 then
            return GOAL_RESULT_Success
        else
            return GOAL_RESULT_Failed
        end
    end

    return GOAL_RESULT_Continue
end

function Turn_Terminate(arg0, arg1)

end

function Turn_Interupt(arg0, arg1)
    local f4_local0 = arg1:GetParam(2)
    local f4_local1 = arg1:GetParam(3)

    if 0 < f4_local0 then
        if arg0:IsInterupt(INTERUPT_Damaged) then
            arg1:SetNumber(0, 1)
        elseif arg0:IsInterupt(INTERUPT_SuccessGuard) and f4_local1 ~= GOAL_RESULT_Continue then
            arg1:SetNumber(1, 1)
        end
    end

    return false
end

function Turn_IsLookToTarget(arg0, arg1)
    local angle = arg1:GetParam(1)
    if angle <= 0 then
        angle = 15
    end
    return arg0:IsLookToTarget(angle)
end
