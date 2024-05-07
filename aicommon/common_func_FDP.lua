--[[
    接近玩家，计算距离，添加 approach target subgoal
]]
function Approach_Act_Flex(self, goal_manager, approach_dist, min_dist, max_dist, odd, arg6, walk_lifetime, run_lifetime, force_move)
    if walk_lifetime == nil then
        walk_lifetime = 3
    end
    if run_lifetime == nil then
        run_lifetime = 8
    end
    if force_move == nil then
        force_move = 0
    end

    local dist_to_player = self:GetDist(TARGET_ENE_0)
    local walk_or_run = true

    if max_dist <= dist_to_player then
        walk_or_run = false
    elseif min_dist <= dist_to_player and self:GetRandam_Int(1, 100) <= odd then
        walk_or_run = false
    end

    if self:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0) or self:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_1) then
        walk_or_run = true
    end

    local state = -1
    if self:GetRandam_Int(1, 100) <= arg6 then
        state = 9910
    end

    local life = 0
    if walk_or_run == true then
        life = walk_lifetime
    else
        life = run_lifetime
    end

    if approach_dist <= dist_to_player or force_move > 0 then
        if walk_or_run == true then
            approach_dist = approach_dist + self:GetStringIndexedNumber("AddDistWalk")
        else
            approach_dist = approach_dist + self:GetStringIndexedNumber("AddDistRun")
        end

        goal_manager:AddSubGoal(GOAL_COMMON_ApproachTarget, life, TARGET_ENE_0, approach_dist, TARGET_SELF, walk_or_run, state)
    end
end

--[[
    self中心的扇形区域是否有障碍物

           ^
           |
           0
    -90          90
          180
           
    return true 没有障碍物
]]
function NoCollisionAround(self, xxxx, angle, radius)
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
    self:SetStringIndexedNumber("BaseDir_AAA", DIR_FRONT)
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
