--[[
  一些常规logic行动？
]]
function COMMON_HiPrioritySetup(self, arg1)
    self:AddObserveSpecialEffectAttribute(TARGET_ENE_0, SP_DEAD)
    self:AddObserveSpecialEffectAttribute(TARGET_ENE_0, SP_RETURN_FROM_FALLING)
    self:AddObserveSpecialEffectAttribute(TARGET_ENE_0, SP_NINSATSU)
    self:AddObserveSpecialEffectAttribute(TARGET_ENE_0, SP_REVIVAL_AFTER_2)
    self:AddObserveSpecialEffectAttribute(TARGET_ENE_0, SP_REVIVAL_AFTER_3)
    self:AddObserveSpecialEffectAttribute(TARGET_ENE_0, SP_HIDE_IN_BLOOD)
    self:AddObserveSpecialEffectAttribute(TARGET_ENE_0, SP_PC_BREAK)

    self:AddObserveSpecialEffectAttribute(TARGET_SELF, SP_ENEMY_TURN)
    self:AddObserveSpecialEffectAttribute(TARGET_SELF, SP_TURN_AT_START_OF_CONVERSATION)
    self:AddObserveSpecialEffectAttribute(TARGET_SELF, SP_BLOOD_SMOKE)
    self:AddObserveSpecialEffectAttribute(TARGET_SELF, SP_FINGER_WHISTLE_ENEMY_MADNESS)
    self:AddObserveSpecialEffectAttribute(TARGET_SELF, SP_FINGER_WHISTLE_ENEMY_MADNESS_MINOR)

    self:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)

    local f1_local0 = self:GetEventRequest(2)

    if self:HasSpecialEffectId(TARGET_ENE_0, 110010) and not self:HasSpecialEffectId(TARGET_SELF, 205090) then
        if not self:HasSpecialEffectId(TARGET_SELF, 205091) then
            self:ClearEnemyTarget()
            self:ClearSoundTarget()
            self:ClearIndicationPosTarget()
            self:ClearLastMemoryTargetPos()

            self:AddTopGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
            return true
        end
    end

    if self:HasSpecialEffectId(TARGET_SELF, SP_DIZZINESS) and self:HasSpecialEffectId(TARGET_ENE_0, SP_HIDE_IN_BUSH) and self:IsVisibleCurrTarget() == false then
        if self:HasSpecialEffectId(TARGET_SELF, SP_ZAKO_REACTION) or self:HasSpecialEffectId(TARGET_SELF, SP_ZAKO_NOREACTION) then
            self:ClearEnemyTarget()
            self:ClearSoundTarget()
            self:ClearIndicationPosTarget()

            self:AddTopGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
            return true
        elseif self:HasSpecialEffectId(TARGET_SELF, SP_CHUBOSS_REACTION) or self:HasSpecialEffectId(TARGET_SELF, SP_CHUBOSS_NOREACTION) then
            if self:GetRandam_Int(1, 100) <= 50 then
                pcSearchAnim = 400600
            else
                pcSearchAnim = 400610
            end

            self:AddTopGoal(GOAL_COMMON_WaitWithAnime, 30, pcSearchAnim, TARGET_SELF)
            self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)

            self:AddObserveChrDmyArea(COMMON_OBSERVE_SLOT_BATTLE_STEALTH, TARGET_ENE_0, 7, 90, 120, 30, 4)
            return true
        end
    end

    if f1_local0 + 10 <= self:GetDist(TARGET_ENE_0) and f1_local0 >= 0 and self:GetCurrTargetType() ~= AI_TARGET_TYPE__NONE and self:GetTopNormalEnemyForgettingTime() >= 5 then
        self:ClearEnemyTarget()
        self:ClearSoundTarget()
        self:ClearIndicationPosTarget()
        self:ClearLastMemoryTargetPos()

        self:AddTopGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
        return true
    end

    if not self:IsCautionState() then
        self:SetNumber(AI_NUMBER_LATEST_SOUND_ID, 0)
    end

    return false
end

function COMMON_EzSetup(self, flag)
    if not self:HasSpecialEffectId(TARGET_SELF, 205050) and not self:HasSpecialEffectId(TARGET_SELF, 205051) and COMMON_AddStateTransitionGoal(self, flag) then
        return true
    end

    COMMON_SetBattleActLogic(self, flag)

    if self:IsLadderAct(TARGET_SELF) and not self:HasGoal(GOAL_COMMON_LadderAct) then
        local top_goal = self:GetTopGoal()

        if top_goal ~= nil then
            top_goal:AddSubGoal_Front(GOAL_COMMON_LadderAct, -1, 3000, TARGET_SELF, self:GetLadderDirMove(TARGET_SELF))
        else
            self:AddTopGoal(GOAL_COMMON_LadderAct, -1, 3000, TARGET_SELF, self:GetLadderDirMove(TARGET_SELF))
        end
    end
end

--[[
    no return value
]]
function COMMON_SetBattleActLogic(self, flag)
    local max_backhome_dist = self:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist)
    local backhome_dist = self:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__backhomeDist)
    local backhome_battle_dist = self:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__backhomeBattleDist)
    local non_battle_act_lifetime = self:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__nonBattleActLife)
    local call_help_forget_time_by_arrival = self:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__callHelp_ForgetTimeByArrival)

    local is_search_target = self:IsSearchTarget(TARGET_ENE_0)
    local move_point_effect_range = self:GetMovePointEffectRange()
    local dist_to_player = self:GetDist(TARGET_ENE_0)

    if self:TeamHelp_IsValidReply() then
        self:AddTopGoal(GOAL_COMMON_TeamReplyHelp, call_help_forget_time_by_arrival)
        return true
    elseif self:IsForceBattleGoal() then
        self:ClearForceBattleGoal()
        self:ReqPlatoonState(PLATOON_STATE_Battle)
        COMMON_AddBattleGoal(self, flag)
    elseif is_search_target == true then
        if max_backhome_dist < move_point_effect_range then
            COMMON_AddNonBattleGoal(self, non_battle_act_lifetime, -1, false)
        elseif backhome_dist < move_point_effect_range then
            if dist_to_player < backhome_battle_dist then
                self:ReqPlatoonState(PLATOON_STATE_Battle)
                COMMON_AddBattleGoal(self, flag)
            else
                COMMON_AddNonBattleGoal(self, non_battle_act_lifetime, backhome_battle_dist, false)
            end
        else
            COMMON_AddBattleGoal(self, flag)
        end
    else
        COMMON_AddNonBattleGoal(self, -1, -1, true)
    end
end

function COMMON_AddBattleGoal(self, flag)
    local cur_target_type = self:GetCurrTargetType()
    local situation = 0

    if self:IsFindState() or self:IsBattleState() then
        if self:GetNumber(AI_NUMBER_BLOOD_SMOKE_BLINDNESS) == 1 and self:HasSpecialEffectId(TARGET_SELF, SP_CHUBOSS_REACTION) then
            if self:GetRandam_Int(1, 100) <= 50 then
                pcSearchAnim = 400600
            else
                pcSearchAnim = 400610
            end

            local topgoal = self:AddTopGoal(GOAL_COMMON_WaitWithAnime, 30, pcSearchAnim, TARGET_SELF)
            -- 注册回调，在 activate 时才清 0 计数器
            topgoal:TimingSetNumber(AI_NUMBER_BLOOD_SMOKE_BLINDNESS, 0, AI_TIMING_SET__ACTIVATE)

            self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            self:AddObserveChrDmyArea(COMMON_OBSERVE_SLOT_BATTLE_STEALTH, TARGET_ENE_0, 7, 90, 120, 30, 4)
        elseif self:IsBattleState() or self:HasSpecialEffectId(TARGET_SELF, SP_PUPPET_SHINOBI) then
            self:ReqPlatoonState(PLATOON_STATE_Battle)
            COMMON_SetBattleGoal(self)
        elseif self:IsFindState() then
            self:ReqPlatoonState(PLATOON_STATE_Find)
            situation = 2
            COMMON_AddCautionAndFindGoal(self, situation, flag)
        end
    elseif self:IsCautionState() then
        if cur_target_type == AI_TARGET_TYPE__MEMORY_ENEMY then
            situation = 0
            COMMON_AddCautionAndFindGoal(self, situation, flag)
        elseif cur_target_type == AI_TARGET_TYPE__SOUND then
            self:ReqPlatoonState(PLATOON_STATE_Caution)
            situation = 1
            COMMON_AddCautionAndFindGoal(self, situation, flag)
        elseif cur_target_type == AI_TARGET_TYPE__CORPSE_POS then
            self:ReqPlatoonState(PLATOON_STATE_Caution)
            situation = 4
            COMMON_AddCautionAndFindGoal(self, situation, flag)
        else
            self:ReqPlatoonState(PLATOON_STATE_Caution)
            situation = 3
            COMMON_AddCautionAndFindGoal(self, situation, flag)
        end
    else
        COMMON_AddNonBattleGoal(self, 10, -1, true)
    end

    self:SetNumber(AI_NUMBER_LATEST_ACTION, COMMON_LATEST_ACTION_BATTLEGOAL)
end

function COMMON_AddCautionAndFindGoal(self, situation, flag)
    local to_caution_act = self:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCaution)
    local to_caution_important_act = self:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCautionImportant)
    local to_caution_corpse_target_act = self:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCautionCorpseTarget)
    local to_find_act = self:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToFind)
    local to_disappear_act = self:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToDisappear)
    local to_caution_indication_target_act = self:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCautionIndicationTarget)

    --[[
        0 non battle
        1 turn and stay
        2 try to approach
        3
        4 stay?
        5 leave
    ]]
    local goal_action = 0

    local dist_to_player = self:GetDist(TARGET_ENE_0)
    local approach_dist = 2.5
    local latest_sound_rank = self:GetLatestSoundTargetRank()
    local rand_int_1t100 = self:GetRandam_Int(1, 100)

    if situation == 0 then
        goal_action = to_disappear_act
    elseif situation == 1 and latest_sound_rank == AI_SOUND_RANK__IMPORTANT then
        goal_action = to_caution_important_act
    elseif situation == 1 then
        goal_action = to_caution_act
    elseif situation == 2 then
        goal_action = to_find_act
    elseif situation == 3 then
        goal_action = to_caution_indication_target_act
    elseif situation == 4 then
        goal_action = to_caution_corpse_target_act
    end

    -- space check useless 2nd param
    local goal = nil

    if self:HasSpecialEffectId(TARGET_SELF, 205050) or self:HasSpecialEffectId(TARGET_SELF, 205051) then
        if self:IsFindState() then
            COMMON_SetBattleGoal(self)
        else
            COMMON_AddNonBattleGoal(self, 3, -1, false)
        end
    end

    if self:IsFindState() then
        if goal_action == 1 then
            self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
            self:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
        elseif goal_action == 2 then
            if self:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                if SpaceCheck(self, goal, 0, 3) == true then
                    self:AddTopGoal(GOAL_COMMON_ApproachTarget, 5, POINT_UnreachTerminate, approach_dist, TARGET_SELF, true, -1)
                elseif self:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
                    self:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
                else
                    self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                end
            elseif approach_dist + 0.5 < dist_to_player then
                self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)

                if not self:HasSpecialEffectId(TARGET_SELF, SP_BLOOD_SMOKE) and not self:HasSpecialEffectId(TARGET_SELF, SP_FIRE_CRACKER) then
                    self:AddTopGoal(GOAL_COMMON_MoveToSomewhere, -1, TARGET_ENE_0, AI_DIR_TYPE_CENTER, approach_dist, TARGET_SELF, true)
                end
            end
        elseif goal_action == 3 then
            if self:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                if SpaceCheck(self, goal, 0, 4) == true then
                    local f7_local20 = false

                    if self:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0) then
                        f7_local20 = true
                    end

                    self:AddTopGoal(GOAL_COMMON_ApproachTarget, 5, POINT_UnreachTerminate, approach_dist, TARGET_SELF, f7_local20, -1)
                elseif SpaceCheck(self, goal, 0, 3) == true then
                    self:AddTopGoal(GOAL_COMMON_ApproachTarget, 5, POINT_UnreachTerminate, approach_dist, TARGET_SELF, true, -1)
                elseif self:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
                    self:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
                else
                    self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                end
            elseif approach_dist + 0.5 < dist_to_player and not self:HasSpecialEffectId(TARGET_SELF, SP_BLOOD_SMOKE) then
                local f7_local20 = self:HasSpecialEffectId(TARGET_SELF, SP_FIRE_CRACKER)
                if not f7_local20 then
                    if self:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0) then
                        f7_local20 = true
                    end
                    self:AddTopGoal(GOAL_COMMON_MoveToSomewhere, -1, TARGET_ENE_0, AI_DIR_TYPE_CENTER, approach_dist,
                        TARGET_SELF, f7_local20)
                end
            end
        elseif goal_action == 4 then
            self:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
        elseif goal_action == 5 then
            if approach_dist <= dist_to_player then
                self:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
            elseif approach_dist / 2 <= dist_to_player then
                self:AddTopGoal(GOAL_COMMON_LeaveTarget, -1, TARGET_ENE_0, approach_dist, TARGET_ENE_0, true, -1)
            else
                self:AddTopGoal(GOAL_COMMON_LeaveTarget, -1, TARGET_ENE_0, approach_dist, TARGET_SELF, false, -1)
            end
        else
            COMMON_AddNonBattleGoal(self, 1, -1, false)
        end
    else
        if situation == 1 then
            if self:GetLatestSoundTargetID() == SOUND_FINGER_WHISTLE_NO_LOCK or self:GetLatestSoundTargetID() == SOUND_FINGER_WHISTLE_LOCK_ON_TARGET then
                approach_dist = 0.4
            elseif self:GetLatestSoundTargetID() == SOUND_CERAMIC_HIT_TARGET then
                approach_dist = 0.2
            end
        end

        local f7_local20 = 600
        if self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) or self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then
            if rand_int_1t100 <= 50 then
                f7_local20 = 400600
            else
                f7_local20 = 400610
            end
        elseif rand_int_1t100 <= 50 then
            f7_local20 = 610
        end
        self:RegisterTriggerRegionObserver(1000)
        if self:GetNumber(AI_NUMBER_LATEST_ACTION) == COMMON_LATEST_ACTION_NONBATTLEGOAL_BATTLE then
            self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, self:GetRandam_Float(4, 6),
                TARGET_SELF)
        elseif self:GetCurrTargetType() == AI_TARGET_TYPE__SOUND and self:GetLatestSoundTargetID() == 7700 then
            self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, self:GetRandam_Float(4, 6),
                TARGET_SELF)
        elseif goal_action == 1 then
            self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
            self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, self:GetRandam_Float(6, 7),
                TARGET_SELF)
        elseif goal_action == 2 then
            if self:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                if situation == 0 then
                    local f7_local21 = self:GetDist_Point(POINT_INITIAL)
                    if approach_dist + 0.5 < f7_local21 then
                        self:AddTopGoal(GOAL_COMMON_MoveToSomewhere, -1, POINT_INITIAL, AI_DIR_TYPE_CENTER, approach_dist,
                            TARGET_ENE_0, false)
                    else
                        self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF,
                            self:GetRandam_Float(3, 4), TARGET_SELF)
                    end
                else
                    self:AddTopGoal(GOAL_COMMON_YousumiAct, 10, false, 60, 30, -1)
                    self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                    self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF,
                        self:GetRandam_Float(3, 4), TARGET_SELF)
                end
            elseif approach_dist + 0.5 < dist_to_player then
                if not self:HasSpecialEffectId(TARGET_SELF, SP_BLOOD_SMOKE) and not self:HasSpecialEffectId(TARGET_SELF, SP_FIRE_CRACKER) then
                    self:AddTopGoal(GOAL_COMMON_MoveToSomewhere, -1, TARGET_ENE_0, AI_DIR_TYPE_CENTER, approach_dist,
                        TARGET_SELF, true)
                else
                    self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF,
                        self:GetRandam_Float(7, 8), TARGET_SELF)
                end
            else
                self:RegisterTriggerRegion(1000, self:GetLatestSoundTargetInstanceID(), 5, 5, TARGET_SELF, AI_DIR_TYPE_F,
                    0)
                self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, self:GetRandam_Float(3, 4),
                    TARGET_SELF)
            end
        elseif goal_action == 3 then
            if self:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                if situation == 0 then
                    local f7_local21 = self:GetDist_Point(POINT_INITIAL)
                    if approach_dist + 0.5 < f7_local21 then
                        self:AddTopGoal(GOAL_COMMON_MoveToSomewhere, -1, POINT_INITIAL, AI_DIR_TYPE_CENTER, approach_dist,
                            TARGET_ENE_0, false)
                    else
                        self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF,
                            self:GetRandam_Float(3, 4), TARGET_SELF)
                    end
                else
                    self:AddTopGoal(GOAL_COMMON_YousumiAct, 10, false, 60, 30, -1)
                    self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                    self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF,
                        self:GetRandam_Float(3, 4), TARGET_SELF)
                end
            elseif approach_dist + 0.5 < dist_to_player then
                if not self:HasSpecialEffectId(TARGET_SELF, SP_BLOOD_SMOKE) then
                    local f7_local21 = self:HasSpecialEffectId(TARGET_SELF, SP_FIRE_CRACKER)
                    if not f7_local21 then
                        f7_local21 = false
                        if self:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0) then
                            f7_local21 = true
                        end
                        self:AddTopGoal(GOAL_COMMON_MoveToSomewhere, -1, TARGET_ENE_0, AI_DIR_TYPE_CENTER,
                            approach_dist, TARGET_SELF, f7_local21)
                    else
                        self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF,
                            self:GetRandam_Float(3, 4), TARGET_SELF)
                    end
                end
                self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, self:GetRandam_Float(3, 4),
                    TARGET_SELF)
            else
                self:RegisterTriggerRegion(1000, self:GetLatestSoundTargetInstanceID(), 5, 5, TARGET_SELF, AI_DIR_TYPE_F,
                    0)
                self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, self:GetRandam_Float(3, 4),
                    TARGET_SELF)
            end
        elseif goal_action == 4 then
            self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
            self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, self:GetRandam_Float(6, 7),
                TARGET_SELF)
        elseif goal_action == 5 then
            if approach_dist <= dist_to_player then
                self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, self:GetRandam_Float(3, 4),
                    TARGET_SELF)
            elseif approach_dist / 2 <= dist_to_player then
                self:AddTopGoal(GOAL_COMMON_LeaveTarget, -1, TARGET_ENE_0, approach_dist, TARGET_ENE_0, true, -1)
            else
                self:AddTopGoal(GOAL_COMMON_LeaveTarget, -1, TARGET_ENE_0, approach_dist, TARGET_SELF, false, -1)
            end
        else
            self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
            self:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, self:GetRandam_Float(6, 7),
                TARGET_SELF)
        end
    end
end

function COMMON_AddNonBattleGoal(arg0, arg1, arg2, arg3)
    arg0:TeamHelp_ValidateCall()
    arg0:TeamHelp_ValidateReply()
    local f8_local0 = -1
    if not not arg0:HasSpecialEffectId(TARGET_SELF, 205100) or arg0:HasSpecialEffectId(TARGET_SELF, 205101) then
        f8_local0 = 9920
    end
    arg0:AddTopGoal(GOAL_COMMON_NonBattleAct, arg1, arg2, arg3, false, POINT_INIT_POSE, 0, 0, f8_local0)
    if not not arg0:IsBattleState() or not not arg0:IsFindState() or arg0:IsCautionState() then
        arg0:SetNumber(AI_NUMBER_LATEST_ACTION, COMMON_LATEST_ACTION_NONBATTLEGOAL_BATTLE)
    else
        arg0:SetNumber(AI_NUMBER_LATEST_ACTION, COMMON_LATEST_ACTION_NONBATTLEGOAL_NON)
    end
end

--[[
    状态转换，明确当前状态
    状态切换的优先级很高，都是用 add topgoal 实现的

    return true 如果进行了切换
    return false 如果不需要切换
]]
function COMMON_AddStateTransitionGoal(self, flag)
    -- 状态切换相关的 sp
    if self:HasSpecialEffectId(TARGET_SELF, 205080) and self:HasSpecialEffectId(TARGET_SELF, 205081) then
        return false
    end

    local cur_target_type = self:GetCurrTargetType()
    if flag == COMMON_FLAG_BOSS then

    elseif self:IsFindState() or self:IsBattleState() then
        self:ClearSoundTarget()
        self:ClearIndicationPosTarget()

        if self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then
            if self:IsChangeState() and self:GetPrevTargetState() ~= AI_TARGET_STATE__FIND then
                self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then
            if self:HasSpecialEffectId(TARGET_SELF, 220070) and self:IsVisibleCurrTarget() == false then
                if not self:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
                    self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                else
                    self:AddTopGoal(GOAL_COMMON_ClearTarget, 3, AI_TARGET_TYPE__NORMAL_ENEMY)
                end
            else
                self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 201040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            end

            return true
        elseif self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_NON_COMBAT_VIGILANCE) then
            if self:HasSpecialEffectId(TARGET_SELF, 220070) and self:IsVisibleCurrTarget() == false then
                if not self:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
                    self:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                else
                    self:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 101040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                    self:AddTopGoal(GOAL_COMMON_ClearTarget, 3, AI_TARGET_TYPE__NORMAL_ENEMY)
                end
            else
                self:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 101040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            end

            return true
        else
            self:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        end
    elseif self:IsCautionState() then
        if cur_target_type == AI_TARGET_TYPE__MEMORY_ENEMY then
            if self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then
                self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif not self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then
                if not self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_NON_COMBAT_VIGILANCE) then
                    self:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                    return true
                end
            end
        elseif cur_target_type == AI_TARGET_TYPE__SOUND then
            if self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then
                self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif not self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then
                if not self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_NON_COMBAT_VIGILANCE) then
                    self:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                    return true
                end
            end
        elseif cur_target_type == AI_TARGET_TYPE__INDICATION_POS then
            if self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then
                self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif not self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then
                if not self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_NON_COMBAT_VIGILANCE) then
                    if self:IsChangeState() then
                        self:AddTopGoal(GOAL_COMMON_Wait, self:GetRandam_Float(0, 0.3), TARGET_SELF, 0, 0, 0)
                        self:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 700, TARGET_ENE_0, 9999, 0)
                        return true
                    end

                    self:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                    return true
                end
            end
        elseif cur_target_type == AI_TARGET_TYPE__CORPSE_POS then
            if self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then
                self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif not self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then
                if not self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_NON_COMBAT_VIGILANCE) then
                    if self:IsChangeState() then
                        self:AddTopGoal(GOAL_COMMON_Wait, self:GetRandam_Float(0, 0.3), TARGET_SELF, 0, 0, 0)
                        self:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 710, TARGET_ENE_0, 9999, 0)
                        return true
                    end

                    self:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                    return true
                end
            end
        end
        -- 回到 normal 状态，如果身上有其它状态的 sp，则由 1000 清除，回到 SP_AI_STATE_NORMAL
    elseif self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_DISCOVERY_OR_COMBAT) then
        self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    elseif self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_COMBAT_ALERT) then
        self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 201000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    elseif self:HasSpecialEffectId(TARGET_SELF, SP_AI_STATE_NON_COMBAT_VIGILANCE) then
        self:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 101000, TARGET_SELF, 9999, 0, 0, 0, 0)
        return true
    end

    return false
end

function COMMON_SetBattleGoal(arg0)
    local battle_goal_id = arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__battleGoalID)
    local f10_local1 = arg0:AddTopGoal(battle_goal_id, -1)
    if f10_local1 then
        f10_local1:SetManagementGoal()
    end

    return true
end
