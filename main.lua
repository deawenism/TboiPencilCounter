local PencilCounter = RegisterMod("PencilCounter",1)
local counter = 0
local hasShot = false
PencilCounter.COLLECTIBLE_LEAD_PENCIL = Isaac.GetItemIdByName("Lead Pencil")

-- initialises variables on start   
function PencilCounter:onInit()
    counter = 0
    hasShot = false
end
-- counts shots
function PencilCounter:onCount()  
    if not hasShot then
        counter = counter + 1 
        hasShot = true
    end
    if counter == 15 then
        counter = 0
    end
end
function PencilCounter:OnRender()
    if player:HasCollectible(PencilCounter.COLLECTIBLE_LEAD_PENCIL) then 
        Isaac.RenderText(counter, 150, 20, 1, 1, 1,1)
    end   
    hasShot = false
end

PencilCounter:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, PencilCounter.onCount)
PencilCounter:AddCallback(ModCallbacks.MC_POST_RENDER, PencilCounter.OnRender)
PencilCounter:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, PencilCounter.onInit)
