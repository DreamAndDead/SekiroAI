RegisterTableLogic(711300)
Logic.Main = function (arg0, arg1)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, SP_BLOOD_SMOKE)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 107710)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, SP_DEAD)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110015)
    local f1_local0 = arg1:GetHpLastTarget()
    if COMMON_HiPrioritySetup(arg1, COMMON_FLAG_BOSS) then
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
    COMMON_EzSetup(arg1, COMMON_FLAG_BOSS)
    
end

Logic.Interrupt = function (arg0, arg1, arg2)
    local f2_local0 = arg1:GetSpecialEffectActivateInterruptType(0)
    if arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f2_local0 == SP_BLOOD_SMOKE then
            arg1:ClearEnemyTarget()
            return true
        elseif f2_local0 == 107710 then
            arg1:Replanning()
            return true
        elseif arg1:GetSpecialEffectActivateInterruptType(0) == SP_DEAD then
            arg1:SetStringIndexedNumber("targetDeadFlag", 1)
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 1, TARGET_ENE_0, 9999, TARGET_SELF, true, -1)
            return true
        elseif arg1:GetSpecialEffectActivateInterruptType(0) == 110015 then
            arg1:SetStringIndexedNumber("TargetDeadFlag", 0)
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_Wait, 0, TARGET_ENE_0, 0, 0, 0)
            return true
        end
    end
    return false
    
end


