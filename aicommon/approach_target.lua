REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 0, "移动到哪个目标", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 1, "到达判定距离，需要接近到目标多近", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 2, "旋转对象？", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 3, "走 or 跑？", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 4, "state", 0)

REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_ApproachTarget, true)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ApproachTarget, true)

function ApproachTarget_Activate(arg0, arg1)
    local lifetime = arg1:GetLife()
    local target_to = arg1:GetParam(0)
    local approach_dist = arg1:GetParam(1)
    local rotate_target = arg1:GetParam(2)
    local if_walk = arg1:GetParam(3)
    local state = arg1:GetParam(4)
    local dir = AI_DIR_TYPE_CENTER
    local f1_local7 = 0
    local f1_local8 = arg1:GetParam(5)
    local f1_local9 = arg1:GetParam(6)
    local f1_local10 = arg1:GetParam(7)

    arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, lifetime, target_to, dir, approach_dist, rotate_target, if_walk,
        dir, f1_local7, f1_local10, state, f1_local8, f1_local9)
end

function ApproachTarget_Update(arg0, arg1, arg2)

end

function ApproachTarget_Terminate(arg0, arg1)

end

function ApproachTarget_Interupt(arg0, arg1)
    return false
end
