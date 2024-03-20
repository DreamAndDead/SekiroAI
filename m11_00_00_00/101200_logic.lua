RegisterTableLogic(101200)
Logic.Main = function (arg0, arg1)
    if COMMON_HiPrioritySetup(arg1) then
        return true
    end
    if arg1:HasSpecialEffectId(TARGET_SELF, SP_PUPPET_SHINOBI) then
        if arg0.KugutsuAct(arg1, goal) then
            return true
        end
    elseif arg1:IsFinishTimer(AI_TIMER_TEKIMAWASHI_REACTION) == false then
        JuzuReaction(arg1, goal, 1, 20105)
        return true
    end
    if not arg1:IsFindState() and not arg1:IsBattleState() and not arg1:IsCautionState() and arg1:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then
        arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401000, TARGET_LOCALPLAYER, 9999, 0, 0, 0, 0)
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


