_G.owo = true
spawn(function()
  while true do
    if not task.wait(0.5) or not _G.owo then
      break
    end
    if not (game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator:FindFirstChild("Prompt") and game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt:FindFirstChild("AlertContents") and game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents:FindFirstChild("Footer")) or not game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer:FindFirstChild("Buttons") then
    elseif not game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons:FindFirstChild("2") then
      game:GetService("VirtualInputManager"):SendMouseButtonEvent(game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons[1].AbsolutePosition.X + tonumber(250), game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons[1].AbsolutePosition.Y + tonumber(50), 0, true, game, 1)
      task.wait()
      game:GetService("VirtualInputManager"):SendMouseButtonEvent(game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons[1].AbsolutePosition.X + tonumber(250), game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons[1].AbsolutePosition.Y + tonumber(50), 0, false, game, 1)
    end
  end
  return
end
)
return
