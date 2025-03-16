local Timer = {}
local timeouts = {}

--- Sets a timeout to execute a function after a specified delay
-- @param func (function) The function to execute
-- @param delay (number) The delay in seconds
function Timer.setTimeout(func, delay)
  local timeout = {
    func = func,
    time = love.timer.getTime() + delay
  }
  table.insert(timeouts, timeout)
end

--- Updates the timeouts and executes functions when the timeout is reached
function Timer.update()
  local currentTime = love.timer.getTime()
  for i = #timeouts, 1, -1 do
    local timeout = timeouts[i]
    if currentTime >= timeout.time then
      timeout.func()
      table.remove(timeouts, i)
    end
  end
end

return Timer
