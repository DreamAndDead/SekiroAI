RegisterTableLogic(118000)
Logic.Main = function (arg0, arg1)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 220060)
    if arg1:HasSpecialEffectId(TARGET_SELF, 3118060) then
        arg1:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 3004, TARGET_ENE_0, 9999, 0)
        return true
    end
    if arg1:HasSpecialEffectId(TARGET_SELF, 5027) then
        arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 20001, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    end
    if COMMON_HiPrioritySetup(arg1) then
        return true
    end
    if arg1:HasSpecialEffectId(TARGET_SELF, SP_PUPPET_SHINOBI) then
        if arg0.KugutsuAct(arg1, goal) then
            return true
        end
    elseif arg1:IsFinishTimer(AI_TIMER_TEKIMAWASHI_REACTION) == false then
        JuzuReaction(arg1, goal, 0, 20105)
        return true
    end
    COMMON_EzSetup(arg1)
    
end

Logic.Interrupt = function (arg0, arg1, arg2)
    return false
    
end

Logic.KugutsuAct = function (arg0, arg1)
    if arg0:IsBattleState() == false and arg0:IsFindState() == false then
        arg0:AddTopGoal(GOAL_KugutsuAct_20000_Battle, -1)
        return true
    end
    return false
    
end


