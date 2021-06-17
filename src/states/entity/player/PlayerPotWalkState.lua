

-- todo check this if needed
PlayerPotWalkState = Class{__includes = EntityWalkState}



function PlayerPotWalkState:init()

    print("PlayerPotWalkState:init")

    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 0

    
    local direction = self.player.direction
  

     -- todo
     self.player:changeAnimation('pot-walk-' .. self.player.direction)

end


function PlayerPotWalkState:enter()

end

function PlayerPotWalkState:update(dt)




      -- todo ?
  -- if we've fully elapsed through one cycle of animation, change back to idle state
  --[[
  if self.player.currentAnimation.timesPlayed > 0 then
    self.player.currentAnimation.timesPlayed = 0
    self.player:changeState('idle')
    end
    ]]
end

function PlayerPotWalkState:render()


    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))


end

