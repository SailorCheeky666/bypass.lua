_G.limsniperautoclicker2 = true
spawn(function()
  while true do
    if not task.wait(0.1) or not _G.limsniperautoclicker2 then
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
                local buttonContent = button:FindFirstChild("ButtonContent")
                if buttonContent then
                    local buttonMiddle = buttonContent:FindFirstChild("ButtonMiddleContent")
                    if buttonMiddle then
                        local textLabel = buttonMiddle:FindFirstChildOfClass("TextLabel")
                        if textLabel then
                            local buttonText = textLabel.Text:lower()

                            if buttonText:find("buy") or buttonText:find("satın") or buttonText:find("purchase") or tonumber(textLabel.Text) then
                                local pos = button.AbsolutePosition
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(pos.X + 100, pos.Y + 35, 0, true, game, 1)
                                task.wait(0.1)
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(pos.X + 100, pos.Y + 35, 0, false, game, 1)
                                break
                            end
                        end
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
