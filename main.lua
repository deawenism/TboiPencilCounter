local PencilCounter = RegisterMod("PencilCounter",1)
local counter = 0
local hasShot = false
PencilCounter.COLLECTIBLE_LEAD_PENCIL = Isaac.GetItemIdByName("Lead Pencil")
local myEntity = nil
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
        if myEntity == nil then
            myEntity = Isaac.Spawn(65592309, 0,0, player.Position,  Vector(0,0), player)
            myEntity:AddEntityFlags(EntityFlag.FLAG_FRIENDLY|EntityFlag.FLAG_PERSISTENT)
            myEntity.PositionOffset = Vector(0,-50)
            print(myEntity)
        end
        if myEntity ~= nil then
            myEntity.Position = player.Position
            myEntity:GetSprite():SetFrame(counter)
        end
       
    else
        myEntity = nil
    end
    hasShot = false
end

PencilCounter:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, PencilCounter.onCount)
PencilCounter:AddCallback(ModCallbacks.MC_POST_RENDER, PencilCounter.OnRender)
PencilCounter:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, PencilCounter.onInit)


