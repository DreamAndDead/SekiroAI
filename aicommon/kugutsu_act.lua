-- 傀儡状态
RegisterTableGoal(GOAL_KugutsuAct_20000_Battle, "GOAL_KugutsuAct_20000_Battle")
REGISTER_DBG_GOAL_PARAM(GOAL_KugutsuAct_20000_Battle, 0, "???s??", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_KugutsuAct_20000_Battle, 1, "???s?s??", 0)

REGISTER_GOAL_NO_UPDATE(GOAL_KugutsuAct_20000_Battle, true)

Goal.Initialize = function(arg0, arg1, arg2, arg3)

end

Goal.Activate = function(arg0, self, goal_manager)
    local f2_local0 = goal_manager:GetParam(0)
    local f2_local1 = goal_manager:GetParam(1)
    local dist_to_player = self:GetDist(TARGET_LOCALPLAYER)

    if self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then

    elseif self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then
        goal_manager:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 3, 201040, TARGET_SELF, 9999, 0, 0, 0, 0)
    else
        goal_manager:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 3, 1040, TARGET_SELF, 9999, 0, 0, 0, 0)
    end

    if dist_to_player >= 6 then
        if self:CheckDoesExistPath(TARGET_LOCALPLAYER, DIR_FRONT, 0, 0) == true then
            if f2_local1 == 1 then
                goal_manager:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_LOCALPLAYER, 5, TARGET_SELF, true, -1)
            else
                goal_manager:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_LOCALPLAYER, 5, TARGET_SELF, false, -1)
            end
        elseif self:IsInsideTarget(TARGET_LOCALPLAYER, DIR_FRONT, 90) then
            goal_manager:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        else
            goal_manager:AddSubGoal(GOAL_COMMON_Turn, 1, TARGET_LOCALPLAYER, 0, 0, 0)
        end
    elseif dist_to_player >= 3 then
        if self:CheckDoesExistPath(TARGET_LOCALPLAYER, DIR_FRONT, 0, 0) == true then
            goal_manager:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_LOCALPLAYER, 2, TARGET_SELF, true, -1)
        elseif self:IsInsideTarget(TARGET_LOCALPLAYER, DIR_FRONT, 90) then
            goal_manager:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        else
            goal_manager:AddSubGoal(GOAL_COMMON_Turn, 1, TARGET_LOCALPLAYER, 0, 0, 0)
        end
    elseif dist_to_player >= 1 then
        goal_manager:AddSubGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
    elseif NoCollisionAround(self, goal_manager, 180, 1) == true then
        if f2_local0 == 1 then
            if self:IsInsideTarget(TARGET_LOCALPLAYER, DIR_FRONT, 90) then
                goal_manager:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
            else
                goal_manager:AddSubGoal(GOAL_COMMON_Turn, 1, TARGET_LOCALPLAYER, 0, 0, 0)
            end
        else
            goal_manager:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_LOCALPLAYER, 999, TARGET_LOCALPLAYER, true, -1)
        end
    elseif self:IsInsideTarget(TARGET_LOCALPLAYER, DIR_FRONT, 90) then
        goal_manager:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
    else
        goal_manager:AddSubGoal(GOAL_COMMON_Turn, 1, TARGET_LOCALPLAYER, 0, 0, 0)
    end
end

Goal.Interrupt = function(arg0, arg1, arg2)
    return false
end

Goal.Update = function(arg0, arg1, arg2)
    return default_update(arg0, arg1, arg2)
end

Goal.Terminate = function(arg0, arg1, arg2)

end
