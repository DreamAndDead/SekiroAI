RegisterTableLogic(510000)
Logic.Main = function (arg0, arg1)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, SP_BLOOD_SMOKE)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 107710)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, SP_DEAD)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110015)
    arg1:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
    local f1_local0 = arg1:GetDist(TARGET_ENE_0)
    if COMMON_HiPrioritySetup(arg1, COMMON_FLAG_BOSS) then
        return true
    end
    if arg1:HasSpecialEffectId(TARGET_SELF, 200031) == false and arg1:HasSpecialEffectId(TARGET_SELF, SP_DIZZINESS) and arg1:HasSpecialEffectId(TARGET_ENE_0, SP_HIDE_IN_BUSH) and arg1:IsVisibleCurrTarget() == false then
        arg1:AddTopGoal(GOAL_COMMON_WaitWithAnime, 30, 20030, TARGET_SELF)
        arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 20031, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        arg1:AddObserveChrDmyArea(COMMON_OBSERVE_SLOT_BATTLE_STEALTH, TARGET_ENE_0, 7, 90, 120, 30, 4)
        return true
    end
    local f1_local1 = arg1:GetHpLastTarget()
    if arg1:IsFindState() or arg1:IsBattleState() then
        COMMON_SetBattleGoal(arg1)
        if arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then

        elseif arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then

        end
    elseif arg1:IsCautionState() then
        if arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then

        elseif arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then

        end
    elseif arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then

    elseif arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then

    else

    end
    
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
        elseif f2_local0 == SP_DEAD then
            arg1:SetStringIndexedNumber("TargetDeadFlag", 1)
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_Wait, 0, TARGET_ENE_0, 0, 0, 0)
            return true
        elseif f2_local0 == 110015 then
            arg1:SetStringIndexedNumber("TargetDeadFlag", 0)
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_Wait, 0, TARGET_ENE_0, 0, 0, 0)
            return true
        elseif f2_local0 == SP_DEAD then
            arg1:SetStringIndexedNumber("targetDeadFlag", 1)
            arg1:Replanning()
            retval = false
        elseif f2_local0 == 110015 then
            arg1:SetStringIndexedNumber("targetDeadFlag", 0)
            arg1:Replanning()
            retval = false
        end
    end
    if arg1:IsInterupt(INTERUPT_Damaged) and arg1:HasSpecialEffectId(TARGET_SELF, 3510060) and arg1:HasSpecialEffectId(TARGET_SELF, 200031) == false then
        arg1:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
        arg2:ClearSubGoal()
        arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 1, 20031, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    end
    if arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
        if arg1:IsVisibleCurrTarget() then
            if arg1:HasSpecialEffectId(TARGET_SELF, 3510060) and arg1:HasSpecialEffectId(TARGET_SELF, 200031) == false then
                arg1:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
                arg2:ClearSubGoal()
                arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 1, 20031, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        else
            arg1:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
            arg1:AddObserveChrDmyArea(COMMON_OBSERVE_SLOT_BATTLE_STEALTH, TARGET_ENE_0, 7, 90, 120, 30, 4)
            return false
        end
    end
    return false
    
end


