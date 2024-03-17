--[[
    接近玩家，计算距离，添加 approach target subgoal
]]
function Approach_Act_Flex(self, goal_manager, arg2, min_dist, max_dist, odd, arg6, short_life, long_life, arg9)
    if short_life == nil then
        short_life = 3
    end
    if long_life == nil then
        long_life = 8
    end
    if arg9 == nil then
        arg9 = 0
    end

    local dist_to_player = self:GetDist(TARGET_ENE_0)
    local short_or_long = true

    if max_dist <= dist_to_player then
        short_or_long = false
    elseif min_dist <= dist_to_player and self:GetRandam_Int(1, 100) <= odd then
        short_or_long = false
    end

    if self:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0) or self:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_1) then
        short_or_long = true
    end

    local f1_local3 = -1
    if self:GetRandam_Int(1, 100) <= arg6 then
        f1_local3 = 9910
    end

    local life = 0
    if short_or_long == true then
        life = short_life
    else
        life = long_life
    end

    if arg2 <= dist_to_player or arg9 > 0 then
        if short_or_long == true then
            arg2 = arg2 + self:GetStringIndexedNumber("AddDistWalk")
        else
            arg2 = arg2 + self:GetStringIndexedNumber("AddDistRun")
        end
        goal_manager:AddSubGoal(GOAL_COMMON_ApproachTarget, life, TARGET_ENE_0, arg2, TARGET_SELF, short_or_long,
            f1_local3)
    end
end

--[[
    self中心的扇形区域是否有障碍物

    - 正前方 0 度
    - 正右方 90 度
    - 正左方 -90 度
    - 正后方 180 度

    return true 没有障碍物
]]
function SpaceCheck(self, goal_manager, angle, radius)
    local capsule_radius = self:GetMapHitRadius(TARGET_SELF)
    local f2_local1 = self:GetExistMeshOnLineDistSpecifyAngleEx(TARGET_SELF, angle, radius + capsule_radius,
        AI_SPA_DIR_TYPE_TargetF, capsule_radius, 0)

    if radius * 0.95 <= f2_local1 then
        return true
    else
        return false
    end
end

function InsideRange(self, arg1, arg2, arg3, min_dist, max_dist)
    local f5_local0 = self:GetDist(TARGET_ENE_0)

    if min_dist <= f5_local0 and f5_local0 <= max_dist then
        local f5_local1 = self:GetToTargetAngle(TARGET_ENE_0)
        local f5_local2 = 0
        if arg2 < 0 then
            f5_local2 = -1
        else
            f5_local2 = 1
        end
        if not (arg2 + arg3 / -2 > f5_local1 or f5_local1 > arg2 + arg3 / 2) or arg2 + arg3 / -2 <= f5_local1 + 360 * f5_local2 and f5_local1 + 360 * f5_local2 <= arg2 + arg3 / 2 then
            return true
        else
            return false
        end
    else
        return false
    end
end

--[[
    if act is cooldown ready, use normal weight
    else use cooldown weight, usually 1
]]
function get_weight_base_on_cooldown(arg0, arg1, act_id, cooldown_time, normal_weight, cooldown_weight)
    if normal_weight <= 0 then
        return 0
    elseif arg0:GetAttackPassedTime(act_id) <= cooldown_time then
        return cooldown_weight
    end
    return normal_weight
end

function Init_Pseudo_Global(self, arg1)
    self:SetStringIndexedNumber("Dist_SideStep", 5)
    self:SetStringIndexedNumber("Dist_BackStep", 5)
    self:SetStringIndexedNumber("AddDistWalk", 0)
    self:SetStringIndexedNumber("AddDistRun", 0)
    self:SetStringIndexedNumber("DistMin_AAA", -999)
    self:SetStringIndexedNumber("DistMax_AAA", 999)
    self:SetStringIndexedNumber("BaseDir_AAA", AI_DIR_TYPE_F)
    self:SetStringIndexedNumber("Angle_AAA", 360)
    self:SetStringIndexedNumber("Odds_Guard_AAA", 0)
    self:SetStringIndexedNumber("Odds_NoAct_AAA", 0)
    self:SetStringIndexedNumber("Odds_BackAndSide_AAA", 0)
    self:SetStringIndexedNumber("Odds_Back_AAA", 0)
    self:SetStringIndexedNumber("Odds_Backstep_AAA", 0)
    self:SetStringIndexedNumber("Odds_Sidestep_AAA", 0)
    self:SetStringIndexedNumber("Odds_BitWait_AAA", 0)
    self:SetStringIndexedNumber("Odds_BsAndSide_AAA", 0)
    self:SetStringIndexedNumber("Odds_BsAndSs_AAA", 0)
    self:SetStringIndexedNumber("DistMin_Inter_AAA", -999)
    self:SetStringIndexedNumber("DistMax_Inter_AAA", 999)
    self:SetStringIndexedNumber("BaseAng_Inter_AAA", 0)
    self:SetStringIndexedNumber("Ang_Inter_AAA", 360)
    self:SetStringIndexedNumber("BackAndSide_BackLife_AAA", 2)
    self:SetStringIndexedNumber("BackAndSide_SideLife_AAA", self:GetRandam_Float(2.5, 3.5))
    self:SetStringIndexedNumber("BackLife_AAA", self:GetRandam_Float(2, 3))
    self:SetStringIndexedNumber("BsAndSide_SideLife_AAA", self:GetRandam_Float(2.5, 3.5))
    self:SetStringIndexedNumber("BackAndSide_BackDist_AAA", 1.5)
    self:SetStringIndexedNumber("BackDist_AAA", self:GetRandam_Float(2.5, 3.5))
    self:SetStringIndexedNumber("BackAndSide_SideDir_AAA", self:GetRandam_Int(45, 60))
    self:SetStringIndexedNumber("BsAndSide_SideDir_AAA", self:GetRandam_Int(45, 60))
end

--[[
    if no sub goal, return success
    else return continue
]]
function default_update(arg0, arg1, arg2)
    if arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end
    
    return GOAL_RESULT_Continue
end
