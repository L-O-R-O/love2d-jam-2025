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

unitTest:add("GameManager: Game Over Reset Test", function()
  -- Force game over
  GameManager.strikes = constants.MAX_STRIKES
  assert(GameManager:getStrikes() == constants.MAX_STRIKES)

  -- Simulate returning to title
  GameManager:resetStrikes()
  assert(GameManager:getStrikes() == 0)
end)

return unitTest
