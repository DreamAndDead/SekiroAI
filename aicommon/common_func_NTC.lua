--[[
    if sp is kengeki sp
]]
function is_kengeki_sp(arg0, arg1, sp)
    if sp == 200200 or sp == 200201 or sp == 200205 or sp == 200206 or sp == 200210 or sp == 200211 or sp == 200215 or sp == 200216 or sp == 200225 or sp == 200226 or sp == 200227 or sp == 200228 or sp == 200229 then
        return true
    end
    return false
end

--[[
    if self has kengeki sp, return it
    else return 0
]]
function get_kengeki_sp(self)
    if self:HasSpecialEffectId(TARGET_SELF, 200200) then
        return 200200
    elseif self:HasSpecialEffectId(TARGET_SELF, 200201) then
        return 200201
    elseif self:HasSpecialEffectId(TARGET_SELF, 200205) then
        return 200205
    elseif self:HasSpecialEffectId(TARGET_SELF, 200206) then
        return 200206
    elseif self:HasSpecialEffectId(TARGET_SELF, 200210) then
        return 200210
    elseif self:HasSpecialEffectId(TARGET_SELF, 200211) then
        return 200211
    elseif self:HasSpecialEffectId(TARGET_SELF, 200215) then
        return 200215
    elseif self:HasSpecialEffectId(TARGET_SELF, 200216) then
        return 200216
    elseif self:HasSpecialEffectId(TARGET_SELF, 200225) then
        return 200225
    elseif self:HasSpecialEffectId(TARGET_SELF, 200226) then
        return 200226
    elseif self:HasSpecialEffectId(TARGET_SELF, 200227) then
        return 200227
    elseif self:HasSpecialEffectId(TARGET_SELF, 200228) then
        return 200228
    elseif self:HasSpecialEffectId(TARGET_SELF, 200229) then
        return 200229
    elseif self:HasSpecialEffectId(TARGET_SELF, 200300) then
        return 200300
    elseif self:HasSpecialEffectId(TARGET_SELF, 200301) then
        return 200301
    elseif self:HasSpecialEffectId(TARGET_SELF, 200305) then
        return 200305
    elseif self:HasSpecialEffectId(TARGET_SELF, 200306) then
        return 200306
    elseif self:HasSpecialEffectId(TARGET_SELF, 200400) then
        return 200400
    elseif self:HasSpecialEffectId(TARGET_SELF, 200401) then
        return 200401
    elseif self:HasSpecialEffectId(TARGET_SELF, 200405) then
        return 200405
    elseif self:HasSpecialEffectId(TARGET_SELF, 200406) then
        return 200406
    end
    return 0
end


function YousumiAct_SubGoal(arg0, arg1, arg2, arg3, arg4, arg5)
    arg1:AddSubGoal(GOAL_COMMON_YousumiAct, 10, arg2, arg3, arg4, arg5)
    return true
end

--[[
    跟随行动

    still_odd 当已经在合适范围内，保持静止的概率
    - 0 一直在调整站位，即使已经满足跟随距离

    return true 已经调整好位置，在合适距离内
]]
function TorimakiAct(self, goal_manager, keep_dist, still_odd, arg4)
    local dist_to_player = self:GetDist(TARGET_ENE_0)
    local rand_lifetime = self:GetRandam_Float(1, 2)
    local lifetime = 1.5
    local rand_angle = self:GetRandam_Int(30, 45)
    local f6_local4 = -1
    local left_or_right_dir = 0
    local f6_local6 = self:GetRandam_Int(1, 100)
    local f6_local7 = true
    local f6_local8 = self:GetRandam_Float(-1, 1)

    if keep_dist == nil or keep_dist == -1 then
        keep_dist = 6
    end
    if still_odd == nil or still_odd == -1 then
        still_odd = 10
    end
    if arg4 == nil then
        arg4 = false
    end

    -- too close
    if keep_dist ~= 0 and dist_to_player <= keep_dist - 2 then
        goal_manager:AddSubGoal(GOAL_COMMON_LeaveTarget, lifetime, TARGET_ENE_0, keep_dist, TARGET_ENE_0, true, f6_local4)
        -- too far
    elseif keep_dist ~= 0 and keep_dist + 2 <= dist_to_player then
        if not arg4 and keep_dist + 3 <= dist_to_player then
            f6_local7 = false
        end
        goal_manager:AddSubGoal(GOAL_COMMON_ApproachTarget, lifetime, TARGET_ENE_0, keep_dist + f6_local8, TARGET_SELF,
            f6_local7, -1)
    elseif still_odd ~= nil and f6_local6 <= still_odd then
        return true
    elseif SpaceCheck(self, goal_manager, 90, 1) == true or SpaceCheck(self, goal_manager, -90, 1) == true then
        left_or_right_dir = GetDirection_Sideway(self)
        goal_manager:AddSubGoal(GOAL_COMMON_SidewayMove, rand_lifetime, TARGET_ENE_0, left_or_right_dir, rand_angle, true,
            true, f6_local4)
    elseif SpaceCheck(self, goal_manager, 180, 1) == true then
        goal_manager:AddSubGoal(GOAL_COMMON_LeaveTarget, lifetime, TARGET_ENE_0, 999, TARGET_ENE_0, true, f6_local4)
    else
        goal_manager:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    end

    return false
end

--[[
    观看行动，比如在忍杀时，在一旁当观众

    return true 已经调整好位置
]]
function KankyakuAct(self, goal_manager, keep_dist, still_odd, arg4)
    if keep_dist == nil or keep_dist == -1 then
        keep_dist = 10
    end
    if still_odd == nil or still_odd == -1 then
        still_odd = 0
    end

    return TorimakiAct(self, goal_manager, keep_dist, still_odd, arg4)
end

--[[
    和角色死亡 复活 守尸相关
    
    return true 如果执行了相应的act
]]
function Common_ActivateAct(self, goal_manager, arg2, arg3)
    local dist_to_player = self:GetDist(TARGET_ENE_0)
    local rand_float_1t2 = self:GetRandam_Float(1, 2)
    local rand_int_30t45 = self:GetRandam_Int(30, 45)
    local f8_local3 = -1
    local f8_local4 = 0

    if arg2 == nil then
        arg2 = 0
    end
    if arg3 == nil then
        arg3 = 0
    end

    -- pc 死亡
    if self:HasSpecialEffectId(TARGET_ENE_0, 110060) then
        if self:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            goal_manager:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        else
            goal_manager:AddSubGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 45, -1, GOAL_RESULT_Success, true)
        end
        -- 半血复活
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110015) and self:GetStringIndexedNumber("Steped") ~= 1 then
        if arg2 == 0 and SpaceCheck(self, goal_manager, 180, self:GetStringIndexedNumber("Dist_Step_Small")) == true then
            if (arg3 == 0 or arg3 == 2) and SpaceCheck(self, goal_manager, 180, self:GetStringIndexedNumber("Dist_Step_Large")) == true then
                if not (arg3 ~= 0 or dist_to_player <= 4) or arg3 == 1 then
                    goal_manager:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                else
                    goal_manager:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                end
            else
                goal_manager:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            end
            self:SetStringIndexedNumber("Steped", 1)
        elseif arg2 <= 1 and (SpaceCheck(self, goal_manager, 90, 1) == true or SpaceCheck(self, goal_manager, -90, 1) == true) then
            f8_local4 = GetDirection_Sideway(self)
            goal_manager:AddSubGoal(GOAL_COMMON_SidewayMove, rand_float_1t2, TARGET_ENE_0, f8_local4, rand_int_30t45,
                true, true, f8_local3)
        else
            goal_manager:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        end
    elseif arg2 <= 1 and (self:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_REVIVAL_AFTER_1) or self:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_REVIVAL_AFTER_2)) then
        KankyakuAct(self, goal_manager, 0)
        -- 正在忍杀
    elseif arg2 <= 1 and self:HasSpecialEffectId(TARGET_ENE_0, 110030) then
        KankyakuAct(self, goal_manager, 0)
    else
        self:SetStringIndexedNumber("Steped", 0)
        return false
    end

    return true
end

--[[
    检测两边的障碍物情况，返回一个侧面移动的方向

    return 0 左边
    return 1 右边
]]
function GetDirection_Sideway(self)
    if SpaceCheck(self, goal, -90, 1) == true then
        if SpaceCheck(self, goal, 90, 1) == true then
            if self:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                return 1
            else
                return 0
            end
        else
            return 0
        end
    elseif SpaceCheck(self, goal, 90, 1) == true then
        return 1
    else
        return 0
    end
end

--[[
    获取连续招架的次数
]]
function Get_ConsecutiveGuardCount(self)
    local count = 0
    if self:IsFinishTimer(13) then
        count = 0
    else
        count = self:GetStringIndexedNumber("ConsecutiveGuardCount")
    end
    return count
end

--[[
    设置连续招架的次数

    在 1s 内连续招架的次数
    弹开时清零
]]
function Set_ConsecutiveGuardCount(self, sp)
    if sp == 200215 or sp == 200216 then
        if self:IsFinishTimer(13) then
            self:SetStringIndexedNumber("ConsecutiveGuardCount", 1)
        else
            self:SetStringIndexedNumber("ConsecutiveGuardCount", self:GetStringIndexedNumber("ConsecutiveGuardCount") + 1)
        end
        self:SetTimer(13, 1)
    elseif sp == 200210 or sp == 200211 then
        self:SetStringIndexedNumber("ConsecutiveGuardCount", 0)
        self:SetTimer(13, 0)
    end
end

--[[
    与连续招架次数相关的 sp 中断点，包含弹开与招架
]]
function Set_ConsecutiveGuardCount_Interrupt(arg0)
    arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 200250)
    arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 200210)
    arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 200211)
end

-- TODO
function JuzuReaction(arg0, arg1, arg2, arg3, arg4)
    local f13_local0 = arg3
    local f13_local1 = 400600
    local f13_local2 = arg0:GetRandam_Int(1, 100)
    local f13_local3 = arg0:GetRandam_Int(1, 100)

    if arg4 ~= nil and f13_local2 <= 50 then
        f13_local0 = arg4
    end
    if arg2 == 0 then
        local f13_local4 = arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local0, TARGET_NONE, 9999, 0, 0, 0, 0)
        f13_local4:TimingSetTimer(AI_TIMER_TEKIMAWASHI_REACTION, 0, AI_TIMING_SET__ACTIVATE)
    else
        local f13_local4 = arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local0, TARGET_NONE, 9999, 0, 0, 0, 0)
        f13_local4:TimingSetTimer(AI_TIMER_TEKIMAWASHI_REACTION, 0, AI_TIMING_SET__ACTIVATE)
    end

    return true
end

--[[
    get sideway diretion no collision
]]
function SpaceCheck_SidewayMove(arg0, arg1, arg2)
    local f14_local0 = nil
    if SpaceCheck(arg0, arg1, -90, arg2) == true then
        if SpaceCheck(arg0, arg1, 90, arg2) == true then
            f14_local0 = 2
        else
            f14_local0 = 0
        end
    elseif SpaceCheck(arg0, arg1, 90, arg2) == true then
        f14_local0 = 1
    else
        f14_local0 = 3
    end
    return f14_local0
end

--[[
    执行架刀动作，开始防御

    return true 如果可执行parry动作

back_step_type
- -1 no
- 0 large step
- 1 small step
]]
function Common_Parry(self, goal_manager, endure_percent_per_guard, back_step_odd, back_step_type, parry_act_id)
    local parry_dist = GetDist_Parry(self)
    local f15_local5 = self:HasSpecialEffectId(TARGET_ENE_0, 109970)
    local is_pc_continuous_attack = self:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_ATTACK_RUSH)

    -- 招架中断等级
    -- 2 的级别最高
    local parry_int_level = -1
    if self:HasSpecialEffectId(TARGET_SELF, 221000) then
        parry_int_level = 0
    elseif self:HasSpecialEffectId(TARGET_SELF, 221001) then
        parry_int_level = 1
    elseif self:HasSpecialEffectId(TARGET_SELF, 221002) then
        parry_int_level = 2
    end

    -- ai 用来连续防御的计时器
    if self:IsFinishTimer(AI_TIMER_PARRY_INTERVAL) == false then
        return false
    end

    if parry_int_level == -1 then
        return false
    end

    -- super armor 霸体？
    if self:HasSpecialEffectId(TARGET_SELF, 220062) then
        return false
    end

    if self:HasSpecialEffectId(TARGET_ENE_0, 110450) or self:HasSpecialEffectId(TARGET_ENE_0, 110501) or self:HasSpecialEffectId(TARGET_ENE_0, 110500) then
        return false
    end

    self:SetTimer(AI_TIMER_PARRY_INTERVAL, 0.1)

    if endure_percent_per_guard == nil then
        endure_percent_per_guard = 50
    end

    if back_step_odd == nil then
        back_step_odd = 0
    end
    if back_step_type == nil then
        back_step_type = 0
    end
    if parry_act_id == nil then
        parry_act_id = 3100
    end

    if self:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and self:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, parry_dist) then
        if is_pc_continuous_attack then
            goal_manager:ClearSubGoal()
            goal_manager:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, parry_act_id, TARGET_ENE_0, 9999, 0)
            return true
        elseif f15_local5 then
            if self:IsTargetGuard(TARGET_SELF) and get_kengeki_sp(self) == false then
                return false
            else
                if parry_int_level == 2 then
                    return false
                elseif parry_int_level == 1 then
                    if self:GetRandam_Int(1, 100) <= 50 then
                        goal_manager:ClearSubGoal()
                        goal_manager:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                        return true
                    end
                elseif parry_int_level == 0 then
                    goal_manager:ClearSubGoal()
                    goal_manager:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                    return true
                end
                -- parry_int_level == -1
                return false
            end
            -- 109980 pc在施放鞭炮
        elseif self:HasSpecialEffectId(TARGET_ENE_0, 109980) and back_step_type ~= -1 and parry_int_level == 0 then
            if back_step_type == 1 then
                goal_manager:ClearSubGoal()
                goal_manager:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                return true
            else
                goal_manager:ClearSubGoal()
                goal_manager:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                return true
            end
        elseif self:GetRandam_Int(1, 100) <= Get_ConsecutiveGuardCount(self) * endure_percent_per_guard then
            goal_manager:ClearSubGoal()
            goal_manager:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
            return true
        else
            goal_manager:ClearSubGoal()
            goal_manager:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif self:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, parry_dist + 1) then
        if back_step_type ~= -1 and self:GetRandam_Int(1, 100) <= back_step_odd then
            if back_step_type == 1 then
                goal_manager:ClearSubGoal()
                goal_manager:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                return true
            else
                goal_manager:ClearSubGoal()
                goal_manager:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                return true
            end
        else
            return false
        end
    else
        return false
    end
end

--[[
    pc的攻击招式不同，应对的距离也不同
]]
function GetDist_Parry(self)
    local dist = PC_ATTACK_DIST_STAND

    if self:HasSpecialEffectId(TARGET_ENE_0, 110271) then
        dist = PC_ATTACK_DIST_TESSEN
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110231) then
        dist = PC_ATTACK_DIST_AXE
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110250) then
        dist = PC_ATTACK_DIST_KODACHI
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110291) then
        dist = PC_ATTACK_DIST_LANCE_1
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110292) then
        dist = PC_ATTACK_DIST_LANCE_2
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110290) then
        dist = PC_ATTACK_DIST_LANCE_TYPE1_CHARGE
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110293) then
        dist = PC_ATTACK_DIST_LANCE_TYPE2_CHARGE
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110400) then
        dist = PC_ATTACK_DIST_SPIN
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110410) then
        dist = PC_ATTACK_DIST_JUMP_FRONT
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110411) then
        dist = PC_ATTACK_DIST_JUMP_BACK
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110420) then
        dist = PC_ATTACK_DIST_MEN_1
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110421) then
        dist = PC_ATTACK_DIST_MEN_2
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110430) then
        dist = PC_ATTACK_DIST_KENSEI_IAI
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110440) then
        dist = PC_ATTACK_DIST_IAI
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110450) then
        dist = PC_ATTACK_DIST_INVISIBLE_IAI_1
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110451) then
        dist = PC_ATTACK_DIST_INVISIBLE_IAI_2
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110460) then
        dist = PC_ATTACK_DIST_HASSOU
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110470) then
        dist = PC_ATTACK_DIST_HUSHIGIRI_LV1
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110480) then
        dist = PC_ATTACK_DIST_KICK_RUSH
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110490) then
        dist = PC_ATTACK_DIST_PUNCHI
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 110501) then
        dist = PC_ATTACK_DIST_GATOTSU
    elseif self:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        dist = PC_ATTACK_DIST_THRUST
    end

    return dist
end

--[[
    是否可对 pc 的药检采取行动
]]
function Interupt_Use_Item(arg0, arg1, arg2)
    local f18_local0 = false
    if arg0:IsInterupt(INTERUPT_UseItem) and arg0:IsStartAttack() == false then
        if arg1 ~= nil then
            if arg0:IsFinishTimer(arg1) then
                f18_local0 = true
                arg0:SetTimer(arg1, arg2)
            end
        else
            f18_local0 = true
        end
    end
    return f18_local0
end

--[[
    是否对 pc 崩躯干采取行动
]]
function Interupt_PC_Break(arg0, arg1, arg2)
    local f19_local0 = false
    if arg0:IsInterupt(INTERUPT_ActivateSpecialEffect) and arg0:GetSpecialEffectActivateInterruptType(0) == COMMON_SP_EFFECT_PC_BREAK and arg0:IsStartAttack() == false then
        if arg1 ~= nil then
            if arg0:IsFinishTimer(arg1) then
                f19_local0 = true
                arg0:SetTimer(arg1, arg2)
            end
        else
            f19_local0 = true
        end
    end
    return f19_local0
end

-- TODO
function Check_ReachAttack(self, dist)
    local f20_local0 = POSSIBLE_ATTACK
    local f20_local1 = self:GetDist(TARGET_ENE_0)
    local f20_local2 = self:GetDistYSigned(TARGET_ENE_0)

    if self:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        if dist < f20_local1 then
            f20_local0 = UNREACH_ATTACK
        elseif f20_local2 >= 0 then
            f20_local0 = REACH_ATTACK_TARGET_HIGH_POSITION
        else
            f20_local0 = REACH_ATTACK_TARGET_LOW_POSITION
        end
    elseif not not self:HasSpecialEffectId(TARGET_ENE_0, 109220) or self:HasSpecialEffectId(TARGET_ENE_0, 109221) then
        if dist < f20_local1 then
            f20_local0 = UNREACH_ATTACK
        elseif f20_local2 >= 0 then
            f20_local0 = REACH_ATTACK_TARGET_HIGH_POSITION
        else
            f20_local0 = REACH_ATTACK_TARGET_LOW_POSITION
        end
    end
    return f20_local0
end
