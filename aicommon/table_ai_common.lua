LogicTable = {}
GoalTable = {}
Logic = nil
Goal = nil

function RegisterTableLogic(logic_id)
    REGISTER_LOGIC_FUNC(logic_id, "TableLogic_" .. logic_id, "TableLogic_" .. logic_id .. "_Interrupt")
    Logic = {}
    LogicTable[logic_id] = Logic
end

function RegisterTableGoal(goal_id, goal_name)
    REGISTER_GOAL(goal_id, goal_name)
    Goal = {}
    GoalTable[goal_id] = Goal
end

function SetupScriptLogicInfo(logic_id, arg1)
    local f3_local0 = LogicTable[logic_id]
    if f3_local0 ~= nil then
        local f3_local1 = CreateInterruptTypeInfoTable(f3_local0)
        local f3_local2 = f3_local0.Update ~= nil
        local f3_local3 = IsInterruptFuncExist(f3_local1, f3_local0)
        f3_local0.InterruptInfoTable = f3_local1
        arg1:SetTableLogic(f3_local2, f3_local3)
    else
        arg1:SetNormalLogic()
    end
end

function SetupScriptGoalInfo(goal_id, arg1)
    local goal = GoalTable[goal_id]
    if goal ~= nil then
        local int_table = CreateInterruptTypeInfoTable(goal)
        local can_update = goal.Update ~= nil
        local can_terminate = goal.Terminate ~= nil
        local can_interupt = IsInterruptFuncExist(int_table, goal)
        local can_init = goal.Initialize ~= nil
        goal.InterruptInfoTable = int_table
        arg1:SetTableGoal(can_update, can_terminate, can_interupt, can_init)
    else
        arg1:SetNormalGoal()
    end
end

function ExecTableLogic(arg0, arg1)
    local f5_local0 = LogicTable[arg1]
    if f5_local0 ~= nil then
        local f5_local1 = f5_local0.Main
        if f5_local1 ~= nil then
            f5_local1(f5_local0, arg0)
        end
    end
end

function UpdateTableLogic(arg0, arg1)
    local f6_local0 = LogicTable[arg1]
    if f6_local0 ~= nil then
        local f6_local1 = f6_local0.Update
        if f6_local1 ~= nil then
            f6_local1(f6_local0, arg0)
        end
    end
end

function InitializeTableGoal(arg0, arg1, goal_id)
    local if_init = false
    local goal = GoalTable[goal_id]
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
    local goal = GoalTable[goal_id]
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
    local goal = GoalTable[goal_id]
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
    local goal = GoalTable[goal_id]
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
    local logic = LogicTable[logic_id]
    if logic ~= nil then
        interrupt_res = InterruptTableGoal_TypeCall(arg0, arg1, logic, int_id)
    end
    return interrupt_res
end

function InterruptTableLogic_Common(self, parent_logic, logic_id)
    local f12_local0 = false
    local logic = LogicTable[logic_id]

    if logic ~= nil and logic.Interrupt ~= nil and logic:Interrupt(self, parent_logic) then
        f12_local0 = true
    end

    if self:IsInterupt(INTERUPT_MovedEnd_OnFailedPath) then
        self:DecideWalkAroundPos()
        local act_type = self:GetActTypeOnFailedPathEnd()
        if act_type == 0 then
            f12_local0 = true
        elseif act_type == 1 then
            parent_logic:ClearSubGoal()
            self:AddTopGoal(GOAL_COMMON_Wait_On_FailedPath, -1, 0.1)
            f12_local0 = true
        elseif act_type == 2 then
            parent_logic:ClearSubGoal()
            self:AddTopGoal(GOAL_COMMON_Wait_On_FailedPath, 0.5, 0.1)
            f12_local0 = true
        elseif act_type == 3 then
            parent_logic:ClearSubGoal()
            self:AddTopGoal(GOAL_COMMON_WalkAround_On_FailedPath, -1, 0.1)
            f12_local0 = true
        elseif act_type == 4 then
            parent_logic:ClearSubGoal()
            self:AddTopGoal(GOAL_COMMON_BackToHome_On_FailedPath, 100, 1, 2)
            f12_local0 = true
        end

        self:SetStringIndexedNumber("Reach_EndOnFailedPath", 1)
        return f12_local0
    end

    if self:HasSpecialEffectId(TARGET_SELF, SP_CANT_BE_INTERRUPTED_PERSISTENT) or self:HasSpecialEffectId(TARGET_SELF, SP_CANT_BE_INTERRUPTED_MOMENT) then
        return false
    end

    if self:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        local int_sp = self:GetSpecialEffectActivateInterruptType(0)

        if int_sp == SP_RETURN_FROM_FALLING then
            self:Replanning()
            return true
        elseif int_sp == SP_DEAD then
            self:SetStringIndexedNumber("targetDeadFlag", 1)
            self:Replanning()
            return false
        elseif int_sp == SP_REVIVAL_AFTER_2 and self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_NORMAL) then
            if self:HasSpecialEffectId(TARGET_SELF, SP_BOSS) then
                self:Replanning()
                return true
            else
                parent_logic:ClearSubGoal()
                self:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif int_sp == SP_REVIVAL_AFTER_2 and self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then
            if self:HasSpecialEffectId(TARGET_SELF, SP_BOSS) then
                self:Replanning()
                return true
            else
                parent_logic:ClearSubGoal()
                self:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif int_sp == SP_REVIVAL_AFTER_3 then
            self:Replanning()
            return true
        elseif int_sp == SP_TURN_AT_START_OF_CONVERSATION then
            parent_logic:ClearSubGoal()
            local topgoal = self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_LOCALPLAYER, 20, -1, GOAL_RESULT_Success, true)
            topgoal:SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
            self:AddTopGoal(GOAL_COMMON_Wait, 0.5, TARGET_LOCALPLAYER, 0, 0, 0)
            return true
        elseif int_sp == SP_ENEMY_TURN then
            if self:HasSpecialEffectId(TARGET_SELF, SP_LOST_SIGHT_OF_PC_BY_TURNING) == false then
                self:ClearEnemyTarget()
            end
            self:SetTimer(AI_TIMER_TEKIMAWASHI_REACTION, 3)
            self:Replanning()
            return true
        elseif int_sp == SP_BLOOD_SMOKE then
            if self:IsBattleState() or self:IsFindState() then
                if self:HasSpecialEffectId(TARGET_SELF, SP_ZAKO_REACTION) or self:HasSpecialEffectId(TARGET_SELF, SP_ZAKO_NOREACTION) then
                    self:ClearEnemyTarget()
                    return true
                elseif self:HasSpecialEffectId(TARGET_SELF, SP_CHUBOSS_REACTION) then
                    self:SetNumber(AI_NUMBER_BLOOD_SMOKE_BLINDNESS, 1)
                end
            end
        elseif int_sp == SP_HIDE_IN_BLOOD then
            if (self:IsBattleState() or self:IsFindState()) and (self:HasSpecialEffectId(TARGET_SELF, SP_ZAKO_REACTION) or self:HasSpecialEffectId(TARGET_SELF, SP_ZAKO_NOREACTION)) then
                self:ClearEnemyTarget()
                return true
            end
        elseif int_sp == SP_GUARD_COUNT then
            if self:IsFinishTimer(13) then
                self:SetStringIndexedNumber("ConsecutiveGuardCount", 1)
            else
                self:SetStringIndexedNumber("ConsecutiveGuardCount",
                    self:GetStringIndexedNumber("ConsecutiveGuardCount") + 1)
            end
            self:SetTimer(13, 1)
        elseif int_sp == SP_PARRY_COUNT_RIGHT or int_sp == SP_PARRY_COUNT_LEFT then
            self:SetStringIndexedNumber("ConsecutiveGuardCount", 0)
            self:SetTimer(13, 0)
        elseif int_sp == SP_FINGER_WHISTLE_ENEMY_MADNESS or int_sp == SP_FINGER_WHISTLE_ENEMY_MADNESS_MINOR then
            self:Replanning()
            return true
        end
    end

    if self:IsInterupt(INTERUPT_InactivateSpecialEffect) then
        local f12_local2 = self:GetSpecialEffectInactivateInterruptType(0)
        if f12_local2 == SP_ENEMY_AI_REFERENCE_SHINOBI then
            self:Replanning()
            return true
        end
    end

    if self:IsInterupt(INTERUPT_ChangeSoundTarget) and self:HasSpecialEffectId(TARGET_SELF, SP_NOT_REACT_TO_SOUND_PERSISTENT) == false and self:HasSpecialEffectId(TARGET_SELF, SP_NOT_REACT_TO_SOUND_MOMENT) == false and self:GetLatestSoundTargetID() ~= SOUND_ENEMY_TURN and (self:HasSpecialEffectId(TARGET_SELF, SP_ZAKO_REACTION) or self:HasSpecialEffectId(TARGET_SELF, SP_CHUBOSS_REACTION)) then
        local sound_target_type = self:GetLatestSoundTargetRank()

        if sound_target_type == AI_SOUND_RANK__IMPORTANT then
            if self:IsFinishTimer(11) and self:GetLatestSoundTargetID() ~= self:GetNumber(AI_NUMBER_LATEST_SOUND_ID) then
                parent_logic:ClearSubGoal()

                local f12_local3 = self:AddTopGoal(GOAL_COMMON_Wait, self:GetRandam_Float(0, 0.3), TARGET_SELF, 0, 0, 0)
                f12_local3:TimingSetTimer(11, 5, AI_TIMING_SET__ACTIVATE)

                self:AddTopGoal(GOAL_COMMON_EndureAttack, 1, 710, TARGET_SELF, 9999, 0)
                self:SetNumber(AI_NUMBER_LATEST_SOUND_ID, self:GetLatestSoundTargetID())
                return true
            else
                self:Replanning()
            end
        elseif self:IsFinishTimer(12) and self:GetLatestSoundTargetID() ~= self:GetNumber(AI_NUMBER_LATEST_SOUND_ID) then
            parent_logic:ClearSubGoal()

            local f12_local3 = self:AddTopGoal(GOAL_COMMON_Wait, self:GetRandam_Float(0, 0.3), TARGET_SELF, 0, 0, 0)
            f12_local3:TimingSetTimer(12, 5, AI_TIMING_SET__ACTIVATE)

            self:AddTopGoal(GOAL_COMMON_EndureAttack, 1, 700, TARGET_SELF, 9999, 0)
            self:SetNumber(AI_NUMBER_LATEST_SOUND_ID, self:GetLatestSoundTargetID())
            return true
        else
            self:Replanning()
        end
    end

    if self:IsInterupt(INTERUPT_FindCorpseTarget) then
        parent_logic:ClearSubGoal()
        self:AddTopGoal(GOAL_COMMON_EndureAttack, 1, 710, TARGET_ENE_0, 9999, 0)
        return true
    end

    if self:IsInterupt(INTERUPT_Inside_ObserveArea) and self:IsBattleState() and self:IsInsideObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH) then
        if self:IsVisibleCurrTarget() then
            self:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
            parent_logic:ClearSubGoal()
            self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 1, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        else
            self:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
            self:AddObserveChrDmyArea(COMMON_OBSERVE_SLOT_BATTLE_STEALTH, TARGET_ENE_0, 7, 90, 120, 30, 4)
            return false
        end
    end

    if self:IsInterupt(INTERUPT_InvadeTriggerRegion) and self:IsCautionState() then
        local f12_local2 = self:GetLatestSoundTargetInstanceID()
        local f12_local3 = self:GetInvadeTriggerRegionInfoNum()
        local act_id = 600

        if self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_NON_COMBAT_VIGILANCE) then
            if self:GetRandam_Int(1, 100) <= 50 then
                act_id = 610
            end
        elseif self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then
            if self:GetRandam_Int(1, 100) <= 50 then
                act_id = 400600
            else
                act_id = 400610
            end
        end

        for i = 0, f12_local3 - 1, 1 do
            local f12_local8 = self:GetInvadeTriggerRegionCategory(i)
            local f12_local9 = self:GetInvadeTriggerRegionUnitID(i)

            if f12_local8 == 1000 and f12_local9 == f12_local2 then
                self:RemoveTriggerRegionObserver(1000)
                parent_logic:ClearSubGoal()
                self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, act_id, TARGET_SELF, self:GetRandam_Float(3, 4),
                    TARGET_SELF)
                return true
            end
        end
    end

    if self:IsInterupt(INTERUPT_Inside_ObserveArea) and self:IsInsideObserve(30) then
        parent_logic:ClearSubGoal()
        parent_logic:AddSubGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
    end

    return f12_local0
end

function InterruptTableGoal(arg0, arg1, goal_id, int_id)
    local interrupt_res = false
    local goal = GoalTable[goal_id]
    if goal ~= nil then
        interrupt_res = InterruptTableGoal_TypeCall(arg0, arg1, goal, int_id)
    end
    return interrupt_res
end

function InterruptTableGoal_Common(arg0, arg1, goal_id)
    local if_interrupt = false
    local goal = GoalTable[goal_id]

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

function IsInterruptFuncExist(int_table, goal)
    for i = INTERUPT_First, INTERUPT_Last, 1 do
        if not int_table[i].bEmpty then
            return true
        end
    end

    return false
end

function InterruptTableGoal_TypeCall(arg0, arg1, goal, int_id)
    if goal.InterruptInfoTable[int_id].func(arg0, arg1, goal) then
        return true
    end

    return false
end

function CreateInterruptTypeInfoTable(goal)
    local int_info_table = {}

    local int_id = INTERUPT_FindEnemy
    local int_info = {
        func = function(arg0, arg1, arg2)
            local int_func = GetInterruptFunc(arg2.Interrupt_FindEnemy)
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
            local f30_local0 = GetInterruptFunc(arg2.Interrupt_FindAttack)
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
            local f31_local0 = GetInterruptFunc(arg2.Interrupt_Damaged)
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
            local f32_local0 = GetInterruptFunc(arg2.Interrupt_Damaged_Stranger)
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
            local f33_local0 = GetInterruptFunc(arg2.Interrupt_FindMissile)
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
            local f34_local0 = GetInterruptFunc(arg2.Interrupt_SuccessGuard)
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
            local f35_local0 = GetInterruptFunc(arg2.Interrupt_MissSwing)
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
            local f36_local0 = GetInterruptFunc(arg2.Interrupt_GuardBegin)
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
            local f37_local0 = GetInterruptFunc(arg2.Interrupt_GuardFinish)
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
            local f38_local0 = GetInterruptFunc(arg2.Interrupt_GuardBreak)
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
            local f39_local0 = GetInterruptFunc(arg2.Interrupt_Shoot)
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
            local f40_local0 = GetInterruptFunc(arg2.Interrupt_ShootImpact)
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
            local f41_local0 = GetInterruptFunc(arg2.Interrupt_UseItem)
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
            local f42_local0 = GetInterruptFunc(arg2.Interrupt_EnterBattleArea)
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
            local f43_local0 = GetInterruptFunc(arg2.Interrupt_LeaveBattleArea)
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
            local f44_local0 = GetInterruptFunc(arg2.Interrupt_CANNOT_MOVE)
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
            if InterruptTableGoal_Inside_ObserveArea(arg2, arg0, arg1) then
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
            local f46_local0 = GetInterruptFunc(arg2.Interrupt_ReboundByOpponentGuard)
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
            local f47_local0 = GetInterruptFunc(arg2.Interrupt_ForgetTarget)
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
            local f48_local0 = GetInterruptFunc(arg2.Interrupt_FriendRequestSupport)
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
            local f49_local0 = GetInterruptFunc(arg2.Interrupt_TargetIsGuard)
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
            local f50_local0 = GetInterruptFunc(arg2.Interrupt_HitEnemyWall)
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
            local f51_local0 = GetInterruptFunc(arg2.Interrupt_SuccessParry)
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
            local f52_local0 = GetInterruptFunc(arg2.Interrupt_CANNOT_MOVE_DisableInterupt)
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
            local f53_local0 = GetInterruptFunc(arg2.Interrupt_ParryTiming)
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
            local f54_local0 = GetInterruptFunc(arg2.Interrupt_RideNode_LadderBottom)
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
            local f55_local0 = GetInterruptFunc(arg2.Interrupt_FLAG_RideNode_Door)
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
            local f56_local0 = GetInterruptFunc(arg2.Interrupt_StraightByPath)
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
            local f57_local0 = GetInterruptFunc(arg2.Interrupt_ChangedAnimIdOffset)
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
            local f58_local0 = GetInterruptFunc(arg2.Interrupt_SuccessThrow)
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
            local f59_local0 = GetInterruptFunc(arg2.Interrupt_LookedTarget)
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
            local f60_local0 = GetInterruptFunc(arg2.Interrupt_LoseSightTarget)
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
            local f61_local0 = GetInterruptFunc(arg2.Interrupt_RideNode_InsideWall)
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
            local f62_local0 = GetInterruptFunc(arg2.Interrupt_MissSwingSelf)
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
            local f63_local0 = GetInterruptFunc(arg2.Interrupt_GuardBreakBlow)
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
            if InterruptTableGoal_TargetOutOfRange(arg2, arg0, arg1) then
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
            local f65_local0 = GetInterruptFunc(arg2.Interrupt_UnstableFloor)
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
            local f66_local0 = GetInterruptFunc(arg2.Interrupt_BreakFloor)
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
            local f67_local0 = GetInterruptFunc(arg2.Interrupt_BreakObserveObj)
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
            local f68_local0 = GetInterruptFunc(arg2.Interrupt_EventRequest)
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
            if InterruptTableGoal_Outside_ObserveArea(arg2, arg0, arg1) then
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
            if InterruptTableGoal_TargetOutOfAngle(arg2, arg0, arg1) then
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
            local f71_local0 = GetInterruptFunc(arg2.Interrupt_PlatoonAiOrder)
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
            if InterruptTableGoal_ActivateSpecialEffect(arg2, arg0, arg1) then
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
            if InterruptTableGoal_InactivateSpecialEffect(arg2, arg0, arg1) then
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
            local f74_local0 = GetInterruptFunc(arg2.Interrupt_MovedEnd_OnFailedPath)
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
            local f75_local0 = GetInterruptFunc(arg2.Interrupt_ChangeSoundTarget)
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
            local f76_local0 = GetInterruptFunc(arg2.Interrupt_OnCreateDamage)
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
            if InterruptTableGoal_InvadeTriggerRegion(arg2, arg0, arg1) then
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
            if InterruptTableGoal_LeaveTriggerRegion(arg2, arg0, arg1) then
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
            local f79_local0 = GetInterruptFunc(arg2.Interrupt_AIGuardBroken)
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
            local f80_local0 = GetInterruptFunc(arg2.Interrupt_AIReboundByOpponentGuard)
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
            local f81_local0 = GetInterruptFunc(arg2.Interrupt_BackstabRisk)
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
            local f82_local0 = GetInterruptFunc(arg2.Interrupt_FindIndicationTarget)
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
            local f83_local0 = GetInterruptFunc(arg2.Interrupt_FindCorpseTarget)
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
            local f84_local0 = GetInterruptFunc(arg2.Interrupt_FindFailedPath)
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
            local f85_local0 = GetInterruptFunc(arg2.Interrupt_GuardedMyAttack)
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
            local f86_local0 = GetInterruptFunc(arg2.Interrupt_WanderedOffPathRepath)
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

function GetInterruptFunc(func)
    if func ~= nil then
        return func
    end
    return InterruptTableGoal_TypeCall_Dummy
end

function InterruptTableGoal_TypeCall_Dummy()
    return false
end

function InterruptTableGoal_TargetOutOfRange_Common(arg0, arg1, arg2, arg3, arg4)
    for i = 0, 31, 1 do
        if arg3(i) then
            if arg4(arg0, arg1, arg2, i) then
                return true
            end
        end
    end

    local f20_local1 = bSlotEnable
    if f20_local1 then
        return false
    else
        return arg4(arg0, arg1, arg2, -1)
    end
end

function InterruptTableGoal_TargetOutOfRange(arg0, arg1, arg2)
    local f21_local0 = InterruptTableGoal_TargetOutOfRange_Common
    local f21_local1 = arg0
    local f21_local2 = REG1_0
    local f21_local3 = arg2

    local f21_local4 = function(p)
        return arg1:IsTargetOutOfRangeInterruptSlot(p)
    end

    local f21_local5 = GetInterruptFunc(arg0.Interrupt_TargetOutOfRange)
    return f21_local0(f21_local1, f21_local2, f21_local3, f21_local4, f21_local5)
end

function InterruptTableGoal_TargetOutOfAngle(arg0, arg1, arg2)
    local f22_local0 = InterruptTableGoal_TargetOutOfRange_Common
    local f22_local1 = arg0
    local f22_local2 = REG1_0
    local f22_local3 = arg2
    local f22_local4 = function(arg0)
        local f88_local0 = arg1
        return f88_local0:IsTargetOutOfAngleInterruptSlot(arg0)
    end

    local f22_local5 = GetInterruptFunc(arg0.Interrupt_TargetOutOfAngle)
    return f22_local0(f22_local1, f22_local2, f22_local3, f22_local4, f22_local5)
end

function InterruptTableGoal_Inside_ObserveArea(arg0, arg1, arg2)
    local observe_slot_num = arg1:GetAreaObserveSlotNum(AI_AREAOBSERVE_INTERRUPT__INSIDE)

    for i = 0, observe_slot_num - 1, 1 do
        local func = GetInterruptFunc(arg0.Interrupt_Inside_ObserveArea)
        if func(arg0, arg1, arg2, arg1:GetAreaObserveSlot(AI_AREAOBSERVE_INTERRUPT__INSIDE, i)) then
            return true
        end
    end
end

function InterruptTableGoal_Outside_ObserveArea(arg0, arg1, arg2)
    local observe_slot_num = arg1:GetAreaObserveSlotNum(AI_AREAOBSERVE_INTERRUPT__OUTSIDE)
    for i = 0, observe_slot_num - 1, 1 do
        local func = GetInterruptFunc(arg0.Interrupt_Outside_ObserveArea)
        if func(arg0, arg1, arg2, arg1:GetAreaObserveSlot(AI_AREAOBSERVE_INTERRUPT__OUTSIDE, i)) then
            return true
        end
    end
end

function InterruptTableGoal_ActivateSpecialEffect(arg0, arg1, arg2)
    local sp_int_num = arg1:GetSpecialEffectActivateInterruptNum()
    for i = 0, sp_int_num - 1, 1 do
        local func = GetInterruptFunc(arg0.Interrupt_ActivateSpecialEffect)
        if func(arg0, arg1, arg2, arg1:GetSpecialEffectActivateInterruptType(i)) then
            return true
        end
    end
end

function InterruptTableGoal_InactivateSpecialEffect(arg0, arg1, arg2)
    local sp_int_num = arg1:GetSpecialEffectInactivateInterruptNum()
    for i = 0, sp_int_num - 1, 1 do
        local func = GetInterruptFunc(arg0.Interrupt_InactivateSpecialEffect)
        if func(arg0, arg1, arg2, arg1:GetSpecialEffectInactivateInterruptType(i)) then
            return true
        end
    end
end

function InterruptTableGoal_InvadeTriggerRegion(arg0, arg1, arg2)
    local n = arg1:GetInvadeTriggerRegionInfoNum()
    for i = 0, n - 1, 1 do
        local func = GetInterruptFunc(arg0.Interrupt_InvadeTriggerRegion)
        if func(arg0, arg1, arg2, arg1:GetInvadeTriggerRegionCategory(i)) then
            return true
        end
    end
end

function InterruptTableGoal_LeaveTriggerRegion(arg0, arg1, arg2)
    local n = arg1:GetLeaveTriggerRegionInfoNum()
    for i = 0, n - 1, 1 do
        local func = GetInterruptFunc(arg0.Interrupt_LeaveTriggerRegion)
        if func(arg0, arg1, arg2, arg1:GetLeaveTriggerRegionCategory(i)) then
            return true
        end
    end
end
