RegisterTableLogic(101000)

--[[
    不关乎返回值 
]]
Logic.Main = function(logic, self)
    self:AddObserveSpecialEffectAttribute(TARGET_SELF, 200299)

    self:AddObserveRegion(30, TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0)

    if self:IsLockOnTarget(TARGET_LOCALPLAYER, TARGET_SELF) and self:HasSpecialEffectId(TARGET_SELF, 3101110) then
        self:SetEventFlag(11125650, true)
    end

    if COMMON_HiPrioritySetup(self, COMMON_FLAG_EXPERIMENT) then
        return true
    end

    -- param place holder
    local goal = nil

    if self:HasSpecialEffectId(TARGET_SELF, SP_PUPPET_SHINOBI) then
        if logic.KugutsuAct(self, goal) then
            return true
        end
    elseif self:IsFinishTimer(AI_TIMER_TEKIMAWASHI_REACTION) == false then
        JuzuReaction(self, goal, 0, 20105, 20107)
        return true
    end

    local event_req = self:GetEventRequest()

    if event_req == 10 then
        self:SetEventMoveTarget(9622490)
        local f1_local1 = self:GetDist_Point(POINT_EVENT)
        if f1_local1 > 3 then
            self:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
        end
    elseif event_req == 11 then
        self:SetEventMoveTarget(9622118)
        self:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, true, -1)
        -- 直接开始拔刀？
    elseif event_req == 12 then
        if not self:HasSpecialEffectId(TARGET_SELF, 200004) then
            self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 1, 1040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end

        self:SetEventMoveTarget(9622492)

        local f1_local1 = self:GetDist_Point(POINT_EVENT)
        if f1_local1 > 3 then
            self:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
        end
    elseif event_req == 13 then
        self:SetEventMoveTarget(1112390)
        self:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
    elseif event_req == 20 then
        self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_LOCALPLAYER, 45, -1, GOAL_RESULT_Success, true)
    elseif event_req == 21 then
        self:SetEventMoveTarget(1122522)
        local f1_local1 = self:GetDist_Point(POINT_EVENT)
        if f1_local1 > 3 then
            self:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
        end
    elseif event_req == 22 then
        self:SetEventMoveTarget(1122523)
        local f1_local1 = self:GetDist_Point(POINT_EVENT)
        if f1_local1 > 3 then
            self:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
        end
        -- 被惊动，开始搜索敌人
    elseif event_req == 30 then
        if self:GetNumber(30) == 0 then
            self:AddTopGoal(GOAL_COMMON_EndureAttack, 1, 20002, TARGET_ENE_0, 9999, 0)
            self:SetNumber(30, 1)
        end
        -- 和 上面一样？
    elseif event_req == 31 then
        if self:GetNumber(30) == 0 then
            self:AddTopGoal(GOAL_COMMON_EndureAttack, 1, 20003, TARGET_ENE_0, 9999, 0)
            self:SetNumber(30, 1)
        end
    end

    COMMON_EzSetup(self, COMMON_FLAG_EXPERIMENT)
end

Logic.Interrupt = function(arg0, arg1, arg2)
    if arg1:IsInterupt(INTERUPT_EventRequest) then
        local event = arg1:GetEventRequest()
        if event == 12 then
            arg1:Replanning()
        end
    end

    return false
end

--[[
    傀儡行动
]]
Logic.KugutsuAct = function(arg0, arg1)
    if arg0:IsBattleState() == false and arg0:IsFindState() == false then
        arg0:AddTopGoal(GOAL_KugutsuAct_20000_Battle, -1)
        return true
    end
    
    return false
end
