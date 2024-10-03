local LLoveStateMachine = {}
LLoveStateMachine.__index = LLoveStateMachine

------ DEFINITIONS -------
---@class State
---@field enter function
---@field update function
---@field exit function

local StateMachine = {}
StateMachine.__index = StateMachine

local State = {}
State.__index = State

------ State ------
--- enter
function State:enter() end
--- update
function State:update(dt) end
--- exit
function State:exit() end


------ StateMachine ------
function StateMachine:new(states, initial_state_name)
    local instance = {
        states = states or {},
        current_state = nil
    }
    if initial_state_name then
        StateMachine.change(instance, initial_state_name)
    end
    return setmetatable(instance, self)
end

-- change
function StateMachine:change(state_name)
    if self.current_state then
        self.current_state:exit()
    end
    self.current_state = self.states[state_name]
    if self.current_state then
        self.current_state:enter()
    end
end

-- register state
function StateMachine:registerState(state_name, state)
    if state_name then
        self.states[state_name] = state
    end
end

-- update
function StateMachine:update(dt)
    if self.current_state then
        self.current_state:update(dt)
    end
end



-----------
LLoveStateMachine.StateMachine = StateMachine
LLoveStateMachine.State = State

return LLoveStateMachine