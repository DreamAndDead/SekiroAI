g_LogicTable = {}
g_GoalTable = {}
Logic = nil
Goal = nil

function RegisterTableLogic(logic_id)
    REGISTER_LOGIC_FUNC(logic_id, "TableLogic_" .. logic_id, "TableLogic_" .. logic_id .. "_Interrupt")
    Logic = {}
    g_LogicTable[logic_id] = Logic
end

function RegisterTableGoal(goal_id, goal_name)
    REGISTER_GOAL(goal_id, goal_name)
    Goal = {}
    g_GoalTable[goal_id] = Goal
end

function SetupScriptLogicInfo(arg0, arg1)
    local f3_local0 = g_LogicTable[arg0]
    if f3_local0 ~= nil then
        local f3_local1 = _CreateInterruptTypeInfoTable(f3_local0)
        local f3_local2 = f3_local0.Update ~= nil
        local f3_local3 = _IsInterruptFuncExist(f3_local1, f3_local0)
        f3_local0.InterruptInfoTable = f3_local1
        arg1:SetTableLogic(f3_local2, f3_local3)
    else
        arg1:SetNormalLogic()
    end
end

function SetupScriptGoalInfo(goal_id, arg1)
    local goal = g_GoalTable[goal_id]
    if goal ~= nil then
        local int_table = _CreateInterruptTypeInfoTable(goal)
        local can_update = goal.Update ~= nil
        local can_terminate = goal.Terminate ~= nil
        local can_interupt = _IsInterruptFuncExist(int_table, goal)
        local can_init = goal.Initialize ~= nil
        goal.InterruptInfoTable = int_table
        arg1:SetTableGoal(can_update, can_terminate, can_interupt, can_init)
    else
        arg1:SetNormalGoal()
    end
end

function ExecTableLogic(arg0, arg1)
    local f5_local0 = g_LogicTable[arg1]
    if f5_local0 ~= nil then
        local f5_local1 = f5_local0.Main
        if f5_local1 ~= nil then
            f5_local1(f5_local0, arg0)
        end
    end
end

function UpdateTableLogic(arg0, arg1)
    local f6_local0 = g_LogicTable[arg1]
    if f6_local0 ~= nil then
        local f6_local1 = f6_local0.Update
        if f6_local1 ~= nil then
            f6_local1(f6_local0, arg0)
        end
    end
end

function InitializeTableGoal(arg0, arg1, goal_id)
    local if_init = false
    local goal = g_GoalTable[goal_id]
    if goal ~= nil then
        local init_func = goal.Initialize
        if init_func ~= nil then
            init_func(goal, arg0, arg1, arg0:GetChangeBattleStateCount())
            if_init = true
        end
    end
    return if_init
end

function ActivateTableGoal(arg0, arg1, goal_id)
    local activate_res = false
    local goal = g_GoalTable[goal_id]
    if goal ~= nil then
        local activate_func = goal.Activate
        if activate_func ~= nil then
            activate_res = activate_func(goal, arg0, arg1)
        end
    end
    return activate_res
end

function UpdateTableGoal(arg0, arg1, goal_id)
    local update_res = GOAL_RESULT_Continue
    local goal = g_GoalTable[goal_id]
    if goal ~= nil then
        local update_func = goal.Update
        if update_func ~= nil then
            update_res = update_func(goal, arg0, arg1)
        end
    end
    return update_res
end

function TerminateTableGoal(arg0, arg1, goal_id)
    local terminate_res = false
    local goal = g_GoalTable[goal_id]
    if goal ~= nil then
        local terminate_func = goal.Terminate
        if terminate_func ~= nil then
            terminate_res = terminate_func(goal, arg0, arg1)
        end
    end
    return terminate_res
end

function InterruptTableLogic(arg0, arg1, logic_id, int_id)
    local interrupt_res = false
    local logic = g_LogicTable[logic_id]
    if logic ~= nil then
        interrupt_res = _InterruptTableGoal_TypeCall(arg0, arg1, logic, int_id)
    end
    return interrupt_res
end

function InterruptTableLogic_Common(arg0, arg1, arg2)
    local f12_local0 = false
    local f12_local1 = g_LogicTable[arg2]
    if f12_local1 ~= nil and f12_local1.Interrupt ~= nil and f12_local1:Interrupt(arg0, arg1) then
        f12_local0 = true
    end
    if arg0:IsInterupt(INTERUPT_MovedEnd_OnFailedPath) then
        arg0:DecideWalkAroundPos()
        local f12_local2 = arg0:GetActTypeOnFailedPathEnd()
        if f12_local2 == 0 then
            f12_local0 = true
        elseif f12_local2 == 1 then
            arg1:ClearSubGoal()
            arg0:AddTopGoal(GOAL_COMMON_Wait_On_FailedPath, -1, 0.1)
            f12_local0 = true
        elseif f12_local2 == 2 then
            arg1:ClearSubGoal()
            arg0:AddTopGoal(GOAL_COMMON_Wait_On_FailedPath, 0.5, 0.1)
            f12_local0 = true
        elseif f12_local2 == 3 then
            arg1:ClearSubGoal()
            arg0:AddTopGoal(GOAL_COMMON_WalkAround_On_FailedPath, -1, 0.1)
            f12_local0 = true
        elseif f12_local2 == 4 then
            arg1:ClearSubGoal()
            arg0:AddTopGoal(GOAL_COMMON_BackToHome_On_FailedPath, 100, 1, 2)
            f12_local0 = true
        end
        arg0:SetStringIndexedNumber("Reach_EndOnFailedPath", 1)
        return f12_local0
    end
    if not not arg0:HasSpecialEffectId(TARGET_SELF, 205050) or arg0:HasSpecialEffectId(TARGET_SELF, 205051) then
        return false
    end
    if arg0:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        local f12_local2 = arg0:GetSpecialEffectActivateInterruptType(0)
        if f12_local2 == COMMON_SP_EFFECT_PC_RETURN then
            arg0:Replanning()
            return true
        elseif f12_local2 == COMMON_SP_EFFECT_PC_DEAD then
            arg0:SetStringIndexedNumber("targetDeadFlag", 1)
            arg0:Replanning()
            return false
        elseif f12_local2 == COMMON_SP_EFFECT_PC_REVIVAL_AFTER_2 and arg0:HasSpecialEffectId(TARGET_SELF, 200000) then
            if arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_BOSS) then
                arg0:Replanning()
                return true
            else
                arg1:ClearSubGoal()
                arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif f12_local2 == COMMON_SP_EFFECT_PC_REVIVAL_AFTER_2 and arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
            if arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_BOSS) then
                arg0:Replanning()
                return true
            else
                arg1:ClearSubGoal()
                arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif f12_local2 == COMMON_SP_EFFECT_PC_REVIVAL_AFTER_3 then
            arg0:Replanning()
            return true
        elseif f12_local2 == COMMON_SP_EFFECT_QUICK_TURN_TO_PC then
            arg1:ClearSubGoal()
            local f12_local3 = arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_LOCALPLAYER, 20, -1, GOAL_RESULT_Success, true)
            f12_local3:SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
            arg0:AddTopGoal(GOAL_COMMON_Wait, 0.5, TARGET_LOCALPLAYER, 0, 0, 0)
            return true
        elseif f12_local2 == COMMON_SP_EFFECT_ENEMY_TURN then
            if arg0:HasSpecialEffectId(TARGET_SELF, 240100) == false then
                arg0:ClearEnemyTarget()
            end
            arg0:SetTimer(AI_TIMER_TEKIMAWASHI_REACTION, 3)
            arg0:Replanning()
            return true
        elseif f12_local2 == COMMON_SP_EFFECT_BLOOD_SMOKE then
            if not not arg0:IsBattleState() or arg0:IsFindState() then
                if not not arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_ZAKO_REACTION) or arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_ZAKO_NOREACTION) then
                    arg0:ClearEnemyTarget()
                    return true
                elseif arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_CHUBOSS_REACTION) then
                    arg0:SetNumber(AI_NUMBER_BLOOD_SMOKE_BLINDNESS, 1)
                end
            end
        elseif f12_local2 == COMMON_SP_EFFECT_HIDE_IN_BLOOD then
            if (not not arg0:IsBattleState() or arg0:IsFindState()) and (not not arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_ZAKO_REACTION) or arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_ZAKO_NOREACTION)) then
                arg0:ClearEnemyTarget()
                return true
            end
        elseif f12_local2 == 200250 then
            if arg0:IsFinishTimer(13) then
                arg0:SetStringIndexedNumber("ConsecutiveGuardCount", 1)
            else
                arg0:SetStringIndexedNumber("ConsecutiveGuardCount",
                    arg0:GetStringIndexedNumber("ConsecutiveGuardCount") + 1)
            end
            arg0:SetTimer(13, 1)
        elseif f12_local2 == 200210 or f12_local2 == 200211 then
            arg0:SetStringIndexedNumber("ConsecutiveGuardCount", 0)
            arg0:SetTimer(13, 0)
        elseif f12_local2 == COMMON_SP_EFFECT_CONFUSE or f12_local2 == COMMON_SP_EFFECT_CONFUSE_GHOST then
            arg0:Replanning()
            return true
        end
    end
    if arg0:IsInterupt(INTERUPT_InactivateSpecialEffect) then
        local f12_local2 = arg0:GetSpecialEffectInactivateInterruptType(0)
        if f12_local2 == COMMON_SP_EFFECT_PC_NINSATSU then
            arg0:Replanning()
            return true
        end
    end
    if arg0:IsInterupt(INTERUPT_ChangeSoundTarget) and arg0:HasSpecialEffectId(TARGET_SELF, 205060) == false and arg0:HasSpecialEffectId(TARGET_SELF, 205061) == false and arg0:GetLatestSoundTargetID() ~= 7700 and (not not arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_ZAKO_REACTION) or arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_CHUBOSS_REACTION)) then
        local f12_local2 = arg0:GetLatestSoundTargetRank()
        if f12_local2 == AI_SOUND_RANK__IMPORTANT then
            if arg0:IsFinishTimer(11) and arg0:GetLatestSoundTargetID() ~= arg0:GetNumber(AI_NUMBER_LATEST_SOUND_ID) then
                arg1:ClearSubGoal()
                local f12_local3 = arg0:AddTopGoal(GOAL_COMMON_Wait, arg0:GetRandam_Float(0, 0.3), TARGET_SELF, 0, 0, 0)
                f12_local3:TimingSetTimer(11, 5, AI_TIMING_SET__ACTIVATE)
                arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 1, 710, TARGET_SELF, 9999, 0)
                arg0:SetNumber(AI_NUMBER_LATEST_SOUND_ID, arg0:GetLatestSoundTargetID())
                return true
            else
                arg0:Replanning()
            end
        elseif arg0:IsFinishTimer(12) and arg0:GetLatestSoundTargetID() ~= arg0:GetNumber(AI_NUMBER_LATEST_SOUND_ID) then
            arg1:ClearSubGoal()
            local f12_local3 = arg0:AddTopGoal(GOAL_COMMON_Wait, arg0:GetRandam_Float(0, 0.3), TARGET_SELF, 0, 0, 0)
            f12_local3:TimingSetTimer(12, 5, AI_TIMING_SET__ACTIVATE)
            arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 1, 700, TARGET_SELF, 9999, 0)
            arg0:SetNumber(AI_NUMBER_LATEST_SOUND_ID, arg0:GetLatestSoundTargetID())
            return true
        else
            arg0:Replanning()
        end
    end
    if arg0:IsInterupt(INTERUPT_FindCorpseTarget) then
        arg1:ClearSubGoal()
        arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 1, 710, TARGET_ENE_0, 9999, 0)
        return true
    end
    if arg0:IsInterupt(INTERUPT_Inside_ObserveArea) and arg0:IsBattleState() and arg0:IsInsideObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH) then
        if arg0:IsVisibleCurrTarget() then
            arg0:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
            arg1:ClearSubGoal()
            arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 1, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        else
            arg0:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
            arg0:AddObserveChrDmyArea(COMMON_OBSERVE_SLOT_BATTLE_STEALTH, TARGET_ENE_0, 7, 90, 120, 30, 4)
            return false
        end
    end
    if arg0:IsInterupt(INTERUPT_InvadeTriggerRegion) and arg0:IsCautionState() then
        local f12_local2 = arg0:GetLatestSoundTargetInstanceID()
        local f12_local3 = arg0:GetInvadeTriggerRegionInfoNum()
        local f12_local4 = 600
        if arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
            if arg0:GetRandam_Int(1, 100) <= 50 then
                f12_local4 = 610
            end
        elseif arg0:HasSpecialEffectId(TARGET_SELF, 200002) then
            if arg0:GetRandam_Int(1, 100) <= 50 then
                f12_local4 = 400600
            else
                f12_local4 = 400610
            end
        end
        for f12_local5 = 0, f12_local3 - 1, 1 do
            local f12_local8 = arg0:GetInvadeTriggerRegionCategory(f12_local5)
            local f12_local9 = arg0:GetInvadeTriggerRegionUnitID(f12_local5)
            if f12_local8 == 1000 and f12_local9 == f12_local2 then
                arg0:RemoveTriggerRegionObserver(1000)
                arg1:ClearSubGoal()
                arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f12_local4, TARGET_SELF, arg0:GetRandam_Float(3, 4),
                    TARGET_SELF)
                return true
            end
        end
    end
    if arg0:IsInterupt(INTERUPT_Inside_ObserveArea) and arg0:IsInsideObserve(30) then
        arg1:ClearSubGoal()
        arg1:AddSubGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
    end
    return f12_local0
end

function InterruptTableGoal(arg0, arg1, goal_id, int_id)
    local interrupt_res = false
    local goal = g_GoalTable[goal_id]
    if goal ~= nil then
        interrupt_res = _InterruptTableGoal_TypeCall(arg0, arg1, goal, int_id)
    end
    return interrupt_res
end

function InterruptTableGoal_Common(arg0, arg1, goal_id)
    local if_interrupt = false
    local goal = g_GoalTable[goal_id]

    if goal ~= nil and goal.Interrupt ~= nil then
        if goal:Interrupt(arg0, arg1) then
            if_interrupt = true
        end
        if arg1:IsInterruptSubGoalChanged() then
            if_interrupt = true
        end
    end
    return if_interrupt
end

function _IsInterruptFuncExist(int_table, goal)
    for f15_local0 = INTERUPT_First, INTERUPT_Last, 1 do
        if not int_table[f15_local0].bEmpty then
            return true
        end
    end
    return false
end

function _InterruptTableGoal_TypeCall(arg0, arg1, goal, int_id)
    if goal.InterruptInfoTable[int_id].func(arg0, arg1, goal) then
        return true
    end
    return false
end

function _CreateInterruptTypeInfoTable(goal)
    local int_info_table = {}

    local int_id = INTERUPT_FindEnemy
    local int_info = {
        func = function(arg0, arg1, arg2)
            local int_func = _GetInterruptFunc(arg2.Interrupt_FindEnemy)
            if int_func(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_FindEnemy == nil
    }
    int_info_table[int_id] = int_info

    int_id = INTERUPT_FindAttack
    int_info = {
        func = function(arg0, arg1, arg2)
            local f30_local0 = _GetInterruptFunc(arg2.Interrupt_FindAttack)
            if f30_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_FindAttack == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_Damaged
    int_info = {
        func = function(arg0, arg1, arg2)
            local f31_local0 = _GetInterruptFunc(arg2.Interrupt_Damaged)
            if f31_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_Damaged == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_Damaged_Stranger
    int_info = {
        func = function(arg0, arg1, arg2)
            local f32_local0 = _GetInterruptFunc(arg2.Interrupt_Damaged_Stranger)
            if f32_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_Damaged_Stranger == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_FindMissile
    int_info = {
        func = function(arg0, arg1, arg2)
            local f33_local0 = _GetInterruptFunc(arg2.Interrupt_FindMissile)
            if f33_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_FindMissile == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_SuccessGuard
    int_info = {
        func = function(arg0, arg1, arg2)
            local f34_local0 = _GetInterruptFunc(arg2.Interrupt_SuccessGuard)
            if f34_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_SuccessGuard == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_MissSwing
    int_info = {
        func = function(arg0, arg1, arg2)
            local f35_local0 = _GetInterruptFunc(arg2.Interrupt_MissSwing)
            if f35_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_MissSwing == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_GuardBegin
    int_info = {
        func = function(arg0, arg1, arg2)
            local f36_local0 = _GetInterruptFunc(arg2.Interrupt_GuardBegin)
            if f36_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_GuardBegin == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_GuardFinish
    int_info = {
        func = function(arg0, arg1, arg2)
            local f37_local0 = _GetInterruptFunc(arg2.Interrupt_GuardFinish)
            if f37_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_GuardFinish == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_GuardBreak
    int_info = {
        func = function(arg0, arg1, arg2)
            local f38_local0 = _GetInterruptFunc(arg2.Interrupt_GuardBreak)
            if f38_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_GuardBreak == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_Shoot
    int_info = {
        func = function(arg0, arg1, arg2)
            local f39_local0 = _GetInterruptFunc(arg2.Interrupt_Shoot)
            if f39_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_Shoot == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_ShootImpact
    int_info = {
        func = function(arg0, arg1, arg2)
            local f40_local0 = _GetInterruptFunc(arg2.Interrupt_ShootImpact)
            if f40_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_ShootImpact == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_UseItem
    int_info = {
        func = function(arg0, arg1, arg2)
            local f41_local0 = _GetInterruptFunc(arg2.Interrupt_UseItem)
            if f41_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_UseItem == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_EnterBattleArea
    int_info = {
        func = function(arg0, arg1, arg2)
            local f42_local0 = _GetInterruptFunc(arg2.Interrupt_EnterBattleArea)
            if f42_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_EnterBattleArea == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_LeaveBattleArea
    int_info = {
        func = function(arg0, arg1, arg2)
            local f43_local0 = _GetInterruptFunc(arg2.Interrupt_LeaveBattleArea)
            if f43_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_LeaveBattleArea == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_CANNOT_MOVE
    int_info = {
        func = function(arg0, arg1, arg2)
            local f44_local0 = _GetInterruptFunc(arg2.Interrupt_CANNOT_MOVE)
            if f44_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_CANNOT_MOVE == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_Inside_ObserveArea
    int_info = {
        func = function(arg0, arg1, arg2)
            if _InterruptTableGoal_Inside_ObserveArea(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_Inside_ObserveArea == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_ReboundByOpponentGuard
    int_info = {
        func = function(arg0, arg1, arg2)
            local f46_local0 = _GetInterruptFunc(arg2.Interrupt_ReboundByOpponentGuard)
            if f46_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_ReboundByOpponentGuard == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_ForgetTarget
    int_info = {
        func = function(arg0, arg1, arg2)
            local f47_local0 = _GetInterruptFunc(arg2.Interrupt_ForgetTarget)
            if f47_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_ForgetTarget == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_FriendRequestSupport
    int_info = {
        func = function(arg0, arg1, arg2)
            local f48_local0 = _GetInterruptFunc(arg2.Interrupt_FriendRequestSupport)
            if f48_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_FriendRequestSupport == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_TargetIsGuard
    int_info = {
        func = function(arg0, arg1, arg2)
            local f49_local0 = _GetInterruptFunc(arg2.Interrupt_TargetIsGuard)
            if f49_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_TargetIsGuard == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_HitEnemyWall
    int_info = {
        func = function(arg0, arg1, arg2)
            local f50_local0 = _GetInterruptFunc(arg2.Interrupt_HitEnemyWall)
            if f50_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_HitEnemyWall == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_SuccessParry
    int_info = {
        func = function(arg0, arg1, arg2)
            local f51_local0 = _GetInterruptFunc(arg2.Interrupt_SuccessParry)
            if f51_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_SuccessParry == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_CANNOT_MOVE_DisableInterupt
    int_info = {
        func = function(arg0, arg1, arg2)
            local f52_local0 = _GetInterruptFunc(arg2.Interrupt_CANNOT_MOVE_DisableInterupt)
            if f52_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_CANNOT_MOVE_DisableInterupt == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_ParryTiming
    int_info = {
        func = function(arg0, arg1, arg2)
            local f53_local0 = _GetInterruptFunc(arg2.Interrupt_ParryTiming)
            if f53_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_ParryTiming == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_RideNode_LadderBottom
    int_info = {
        func = function(arg0, arg1, arg2)
            local f54_local0 = _GetInterruptFunc(arg2.Interrupt_RideNode_LadderBottom)
            if f54_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_RideNode_LadderBottom == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_FLAG_RideNode_Door
    int_info = {
        func = function(arg0, arg1, arg2)
            local f55_local0 = _GetInterruptFunc(arg2.Interrupt_FLAG_RideNode_Door)
            if f55_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_FLAG_RideNode_Door == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_StraightByPath
    int_info = {
        func = function(arg0, arg1, arg2)
            local f56_local0 = _GetInterruptFunc(arg2.Interrupt_StraightByPath)
            if f56_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_StraightByPath == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_ChangedAnimIdOffset
    int_info = {
        func = function(arg0, arg1, arg2)
            local f57_local0 = _GetInterruptFunc(arg2.Interrupt_ChangedAnimIdOffset)
            if f57_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_ChangedAnimIdOffset == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_SuccessThrow
    int_info = {
        func = function(arg0, arg1, arg2)
            local f58_local0 = _GetInterruptFunc(arg2.Interrupt_SuccessThrow)
            if f58_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_SuccessThrow == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_LookedTarget
    int_info = {
        func = function(arg0, arg1, arg2)
            local f59_local0 = _GetInterruptFunc(arg2.Interrupt_LookedTarget)
            if f59_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_LookedTarget == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_LoseSightTarget
    int_info = {
        func = function(arg0, arg1, arg2)
            local f60_local0 = _GetInterruptFunc(arg2.Interrupt_LoseSightTarget)
            if f60_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_LoseSightTarget == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_RideNode_InsideWall
    int_info = {
        func = function(arg0, arg1, arg2)
            local f61_local0 = _GetInterruptFunc(arg2.Interrupt_RideNode_InsideWall)
            if f61_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_RideNode_InsideWall == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_MissSwingSelf
    int_info = {
        func = function(arg0, arg1, arg2)
            local f62_local0 = _GetInterruptFunc(arg2.Interrupt_MissSwingSelf)
            if f62_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_MissSwingSelf == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_GuardBreakBlow
    int_info = {
        func = function(arg0, arg1, arg2)
            local f63_local0 = _GetInterruptFunc(arg2.Interrupt_GuardBreakBlow)
            if f63_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_GuardBreakBlow == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_TargetOutOfRange
    int_info = {
        func = function(arg0, arg1, arg2)
            if _InterruptTableGoal_TargetOutOfRange(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_TargetOutOfRange == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_UnstableFloor
    int_info = {
        func = function(arg0, arg1, arg2)
            local f65_local0 = _GetInterruptFunc(arg2.Interrupt_UnstableFloor)
            if f65_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_UnstableFloor == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_BreakFloor
    int_info = {
        func = function(arg0, arg1, arg2)
            local f66_local0 = _GetInterruptFunc(arg2.Interrupt_BreakFloor)
            if f66_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_BreakFloor == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_BreakObserveObj
    int_info = {
        func = function(arg0, arg1, arg2)
            local f67_local0 = _GetInterruptFunc(arg2.Interrupt_BreakObserveObj)
            if f67_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_BreakObserveObj == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_EventRequest
    int_info = {
        func = function(arg0, arg1, arg2)
            local f68_local0 = _GetInterruptFunc(arg2.Interrupt_EventRequest)
            if f68_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_EventRequest == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_Outside_ObserveArea
    int_info = {
        func = function(arg0, arg1, arg2)
            if _InterruptTableGoal_Outside_ObserveArea(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_Outside_ObserveArea == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_TargetOutOfAngle
    int_info = {
        func = function(arg0, arg1, arg2)
            if _InterruptTableGoal_TargetOutOfAngle(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_TargetOutOfAngle == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_PlatoonAiOrder
    int_info = {
        func = function(arg0, arg1, arg2)
            local f71_local0 = _GetInterruptFunc(arg2.Interrupt_PlatoonAiOrder)
            if f71_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_PlatoonAiOrder == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_ActivateSpecialEffect
    int_info = {
        func = function(arg0, arg1, arg2)
            if _InterruptTableGoal_ActivateSpecialEffect(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_ActivateSpecialEffect == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_InactivateSpecialEffect
    int_info = {
        func = function(arg0, arg1, arg2)
            if _InterruptTableGoal_InactivateSpecialEffect(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_InactivateSpecialEffect == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_MovedEnd_OnFailedPath
    int_info = {
        func = function(arg0, arg1, arg2)
            local f74_local0 = _GetInterruptFunc(arg2.Interrupt_MovedEnd_OnFailedPath)
            if f74_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_MovedEnd_OnFailedPath == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_ChangeSoundTarget
    int_info = {
        func = function(arg0, arg1, arg2)
            local f75_local0 = _GetInterruptFunc(arg2.Interrupt_ChangeSoundTarget)
            if f75_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_ChangeSoundTarget == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_OnCreateDamage
    int_info = {
        func = function(arg0, arg1, arg2)
            local f76_local0 = _GetInterruptFunc(arg2.Interrupt_OnCreateDamage)
            if f76_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_OnCreateDamage == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_InvadeTriggerRegion
    int_info = {
        func = function(arg0, arg1, arg2)
            if _InterruptTableGoal_InvadeTriggerRegion(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_InvadeTriggerRegion == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_LeaveTriggerRegion
    int_info = {
        func = function(arg0, arg1, arg2)
            if _InterruptTableGoal_LeaveTriggerRegion(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_LeaveTriggerRegion == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_AIGuardBroken
    int_info = {
        func = function(arg0, arg1, arg2)
            local f79_local0 = _GetInterruptFunc(arg2.Interrupt_AIGuardBroken)
            if f79_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_AIGuardBroken == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_AIReboundByOpponentGuard
    int_info = {
        func = function(arg0, arg1, arg2)
            local f80_local0 = _GetInterruptFunc(arg2.Interrupt_AIReboundByOpponentGuard)
            if f80_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_AIReboundByOpponentGuard == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_BackstabRisk
    int_info = {
        func = function(arg0, arg1, arg2)
            local f81_local0 = _GetInterruptFunc(arg2.Interrupt_BackstabRisk)
            if f81_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_BackstabRisk == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_FindIndicationTarget
    int_info = {
        func = function(arg0, arg1, arg2)
            local f82_local0 = _GetInterruptFunc(arg2.Interrupt_FindIndicationTarget)
            if f82_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_FindIndicationTarget == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_FindCorpseTarget
    int_info = {
        func = function(arg0, arg1, arg2)
            local f83_local0 = _GetInterruptFunc(arg2.Interrupt_FindCorpseTarget)
            if f83_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_FindCorpseTarget == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_FindFailedPath
    int_info = {
        func = function(arg0, arg1, arg2)
            local f84_local0 = _GetInterruptFunc(arg2.Interrupt_FindFailedPath)
            if f84_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_FindFailedPath == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_GuardedMyAttack
    int_info = {
        func = function(arg0, arg1, arg2)
            local f85_local0 = _GetInterruptFunc(arg2.Interrupt_GuardedMyAttack)
            if f85_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_GuardedMyAttack == nil
    }
    int_info_table[int_id] = int_info
    int_id = INTERUPT_WanderedOffPathRepath
    int_info = {
        func = function(arg0, arg1, arg2)
            local f86_local0 = _GetInterruptFunc(arg2.Interrupt_WanderedOffPathRepath)
            if f86_local0(arg2, arg0, arg1) then
                return true
            end
            if arg1:IsInterruptSubGoalChanged() then
                return true
            end
            return false
        end
        ,
        bEmpty = goal.Interrupt_WanderedOffPathRepath == nil
    }
    int_info_table[int_id] = int_info
    return int_info_table
end

function _GetInterruptFunc(func)
    if func ~= nil then
        return func
    end
    return _InterruptTableGoal_TypeCall_Dummy
end

function _InterruptTableGoal_TypeCall_Dummy()
    return false
end

function _InterruptTableGoal_TargetOutOfRange_Common(arg0, arg1, arg2, arg3, arg4)
    for i = 0, 31, 1 do
        if arg3(i) then
            if arg4(arg0, arg1, arg2, i) then
                return true
            end
        end
    end

    local f20_local1 = bSlotEnable
    if f20_local1 then
        f20_local1 = false
        return f20_local1
    end

    return arg4(arg0, arg1, arg2, -1)
end

function _InterruptTableGoal_TargetOutOfRange(arg0, arg1, arg2)
    local f21_local0 = _InterruptTableGoal_TargetOutOfRange_Common
    local f21_local1 = arg0
    local f21_local2 = REG1_0
    local f21_local3 = arg2
    local f21_local4 = function(arg0)
        local f87_local0 = arg1
        return f87_local0:IsTargetOutOfRangeInterruptSlot(arg0)
    end

    local f21_local5 = _GetInterruptFunc(arg0.Interrupt_TargetOutOfRange)
    return f21_local0(f21_local1, f21_local2, f21_local3, f21_local4, f21_local5)
end

function _InterruptTableGoal_TargetOutOfAngle(arg0, arg1, arg2)
    local f22_local0 = _InterruptTableGoal_TargetOutOfRange_Common
    local f22_local1 = arg0
    local f22_local2 = REG1_0
    local f22_local3 = arg2
    local f22_local4 = function(arg0)
        local f88_local0 = arg1
        return f88_local0:IsTargetOutOfAngleInterruptSlot(arg0)
    end

    local f22_local5 = _GetInterruptFunc(arg0.Interrupt_TargetOutOfAngle)
    return f22_local0(f22_local1, f22_local2, f22_local3, f22_local4, f22_local5)
end

function _InterruptTableGoal_Inside_ObserveArea(arg0, arg1, arg2)
    local observe_slot_num = arg1:GetAreaObserveSlotNum(AI_AREAOBSERVE_INTERRUPT__INSIDE)
    for i = 0, observe_slot_num - 1, 1 do
        local func = _GetInterruptFunc(arg0.Interrupt_Inside_ObserveArea)
        if func(arg0, arg1, arg2, arg1:GetAreaObserveSlot(AI_AREAOBSERVE_INTERRUPT__INSIDE, i)) then
            return true
        end
    end
end

function _InterruptTableGoal_Outside_ObserveArea(arg0, arg1, arg2)
    local observe_slot_num = arg1:GetAreaObserveSlotNum(AI_AREAOBSERVE_INTERRUPT__OUTSIDE)
    for i = 0, observe_slot_num - 1, 1 do
        local func = _GetInterruptFunc(arg0.Interrupt_Outside_ObserveArea)
        if func(arg0, arg1, arg2, arg1:GetAreaObserveSlot(AI_AREAOBSERVE_INTERRUPT__OUTSIDE, i)) then
            return true
        end
    end
end

function _InterruptTableGoal_ActivateSpecialEffect(arg0, arg1, arg2)
    local sp_int_num = arg1:GetSpecialEffectActivateInterruptNum()
    for i = 0, sp_int_num - 1, 1 do
        local func = _GetInterruptFunc(arg0.Interrupt_ActivateSpecialEffect)
        if func(arg0, arg1, arg2, arg1:GetSpecialEffectActivateInterruptType(i)) then
            return true
        end
    end
end

function _InterruptTableGoal_InactivateSpecialEffect(arg0, arg1, arg2)
    local sp_int_num = arg1:GetSpecialEffectInactivateInterruptNum()
    for i = 0, sp_int_num - 1, 1 do
        local func = _GetInterruptFunc(arg0.Interrupt_InactivateSpecialEffect)
        if func(arg0, arg1, arg2, arg1:GetSpecialEffectInactivateInterruptType(i)) then
            return true
        end
    end
end

function _InterruptTableGoal_InvadeTriggerRegion(arg0, arg1, arg2)
    local n = arg1:GetInvadeTriggerRegionInfoNum()
    for i = 0, n - 1, 1 do
        local func = _GetInterruptFunc(arg0.Interrupt_InvadeTriggerRegion)
        if func(arg0, arg1, arg2, arg1:GetInvadeTriggerRegionCategory(i)) then
            return true
        end
    end
end

function _InterruptTableGoal_LeaveTriggerRegion(arg0, arg1, arg2)
    local n = arg1:GetLeaveTriggerRegionInfoNum()
    for i = 0, n - 1, 1 do
        local func = _GetInterruptFunc(arg0.Interrupt_LeaveTriggerRegion)
        if func(arg0, arg1, arg2, arg1:GetLeaveTriggerRegionCategory(i)) then
            return true
        end
    end
end
