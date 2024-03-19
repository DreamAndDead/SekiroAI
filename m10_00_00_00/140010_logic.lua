RegisterTableLogic(140010)
Logic.Main = function (arg0, arg1)
    if COMMON_HiPrioritySetup(arg1) then
        return true
    end
    if arg1:HasSpecialEffectId(TARGET_SELF, 205080) and COMMON_AddStateTransitionGoal(arg1, COMMON_FLAG_BOSS) then
        return true
    else

    end
    if arg1:HasSpecialEffectId(TARGET_SELF, SP_PUPPET_SHINOBI) then
        if arg0.KugutsuAct(arg1, goal) then
            return true
        end
    elseif arg1:IsFinishTimer(AI_TIMER_TEKIMAWASHI_REACTION) == false then
        local f1_local0 = arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__battleGoalID)
        if f1_local0 == GOAL_Kenkaku_weak_140000_Battle then
            JuzuReaction(arg1, goal, 0, 20105)
        else
            JuzuReaction(arg1, goal, 1, 20105)
        end
        return true
    end
    if arg1:HasSpecialEffectId(TARGET_SELF, 205080) then
        COMMON_SetBattleGoal(arg1)
    else
        COMMON_EzSetup(arg1)
    end
    
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


