
PlayerPotLiftState = Class{__includes = BaseState}  

-- check if a pot is in front of the player 
-- lift it up only if in a special hitbox


function PlayerPotLiftState:init(player, dungeon)

    print("PlayerPotLiftState:init")
    
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 0

    -- create hitbox based on where the player is and facing
    local direction = self.player.direction
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.player.x - hitboxWidth
        hitboxY = self.player.y + 2
    elseif direction == 'right' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.player.x + self.player.width
        hitboxY = self.player.y + 2
    elseif direction == 'up' then
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.player.x
        hitboxY = self.player.y - hitboxHeight
    else
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.player.x
        hitboxY = self.player.y + self.player.height
    end

     -- will only be active during this state
    self.potHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)

    -- todo
    self.player:changeAnimation('pot-lift-' .. self.player.direction)

end


function PlayerPotLiftState:enter()

  
end



function PlayerPotLiftState:update(dt)

    for k, object in pairs(self.dungeon.currentRoom.objects) do

        --print(object.type)

        if object.solid then
            
            if object:collides(self.potHitbox) then
            --print("object collide")
                      
                -- todo ensure the animation is completed, see sword swing etc
                if self.player.currentAnimation.timesPlayed > 0 then
            
                    self.player.currentAnimation.timesPlayed = 0
                    -- if a pot was not in the hitbox then go back to idle
                    self.player:changeState('pot-walk')
                    object.state = 'carried'
                
                end
            
            end
        end
    end 

    
    
    if self.player.currentAnimation.timesPlayed > 0 then
        
        self.player.currentAnimation.timesPlayed = 0
        -- if a pot was not in the hitbox then go back to idle
        print("changing back to idle state")
        self.player:changeState('idle')
    
    end
    

end

function PlayerPotLiftState:render()
 
 
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))


    -- debug for player and hurtbox collision rects VV
    --
    --[[
     love.graphics.setColor(255, 0, 255, 255)
     love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
     love.graphics.rectangle('line', self.potHurtbox.x, self.potHurtbox.y,
         self.potHurtbox.width, self.potHurtbox.height)
     love.graphics.setColor(255, 255, 255, 255)
]]

end