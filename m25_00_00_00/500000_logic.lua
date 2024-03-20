RegisterTableLogic(500000)
Logic.Main = function (arg0, arg1)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110060)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110015)
    local f1_local0 = arg1:GetHpLastTarget()
    if COMMON_HiPrioritySetup(arg1) then
        return true
    end
    if arg1:IsFindState() or arg1:IsBattleState() then
        if arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then

        elseif arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then

        end
    elseif arg1:IsCautionState() then
        if arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then

        elseif arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then

        end
    else
        if arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then

        elseif arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then

        else

        end
        arg1:SetStringIndexedNumber("TargetDeadFlag", 0)
    end
    COMMON_EzSetup(arg1)
    
end

Logic.Interrupt = function (arg0, arg1, arg2)
    local f2_local0 = arg1:GetSpecialEffectActivateInterruptType(0)
    if arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f2_local0 == 110060 then
            arg1:SetStringIndexedNumber("TargetDeadFlag", 1)
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_Wait, 0, TARGET_ENE_0, 0, 0, 0)
            return true
        elseif f2_local0 == 110015 then
            arg1:SetStringIndexedNumber("TargetDeadFlag", 0)
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_Wait, 0, TARGET_ENE_0, 0, 0, 0)
            return true
        elseif f2_local0 == 110060 then
            arg1:SetStringIndexedNumber("targetDeadFlag", 1)
            arg1:Replanning()
            retval = false
        elseif f2_local0 == 110015 then
            arg1:SetStringIndexedNumber("targetDeadFlag", 0)
            arg1:Replanning()
            retval = false
        end
    end
    return false
    
end


