local unitTest = {}

unitTest.tests = {}

-- Funzione per aggiungere un test
function unitTest:add(name, func)
  table.insert(self.tests, { name = name, func = func })
end

-- Funzione per eseguire tutti i test
function unitTest:run()
  local passed, failed = 0, 0

  print("Running unit tests...\n")

  for _, test in ipairs(self.tests) do
    local success, err = pcall(test.func)
    if success then
      print("✔️  PASSED: " .. test.name)
      passed = passed + 1
    else
      print("❌ FAILED: " .. test.name .. "\n   Error: " .. err)
      failed = failed + 1
    end
  end

  print("\nUnit Test Results:")
  print("✅ Passed: " .. passed)
  print("❌ Failed: " .. failed)
end
--[[
unitTest:add("GameManger: check strSchedule",
      function()
        for i = 1, #allActivities do
          if allActivities[i]:getStrSchedule() == nil then
            print('error')
          else
            print(i .. " " .. allActivities[i]:getName() .. " " ..  allActivities[i]:getStrSchedule())
          end
        end
      end)

unitTest:add("GameManger: Get Current Month:", function()
  local m1 = GameManager:getMonth()
  assert(m1 == 3)
end)

unitTest:add("GameManger check players",
  function()
    local guild =  GameManager:getGuild()
  for i = 1, #guild do
    local p_name = guild[i]:getName()
    local a_name = guild[i]:getActivity():getName()
    local a_schedule = guild[i]:getActivity():getStrSchedule()
    print(p_name .. " " .. a_name .. " " .. a_schedule)
    local a_calendar = guild[i]:getActivity():printActivity()
  end

  CalendarManager:printCalendar()
end)
]]
return unitTest
