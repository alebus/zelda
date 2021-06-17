PlayerPotWalkState = Class{__includes = EntityWalkState}

function PlayerPotWalkState:init(player, dungeon)

    print("PlayerPotWalkState:init")

    self.entity = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.entity.offsetY = 5
    self.entity.offsetX = 0

    self.entity.bumped = false

    self.entity.potCarry = true

end



function PlayerPotWalkState:update(dt)
 
   
    -- todo need to add a bunch of different state changes etc etc
    -- and test different directions etc etc
    -- NOTE this is mostly based on PlayerWalkState but with a lot of changes
        
        if love.keyboard.isDown('left') then
            self.entity.direction = 'left'
            self.entity:changeAnimation('pot-walk-left')
        elseif love.keyboard.isDown('right') then
            self.entity.direction = 'right'
            self.entity:changeAnimation('pot-walk-right')
        elseif love.keyboard.isDown('up') then
            self.entity.direction = 'up'
            self.entity:changeAnimation('pot-walk-up')
        elseif love.keyboard.isDown('down') then
            self.entity.direction = 'down'
            self.entity:changeAnimation('pot-walk-down')
        else
    
            -- for now I am setting property on the player
            -- so that when he does walk again, it goes to pot-walk state
            -- todo optional - later can make a pot-idle state or something else to have that graphic when player is idle
            self.entity:changeState('idle')
        end
        
    

    -- wall collision
    EntityWalkState.update(self, dt)


    -- this is all code from PlayerWalkState

    self.entity.bumped = false

     -- if we bumped something when checking collision, check any object collisions
     if self.bumped then
        -- debug
        --print("self is bumped")
        if self.entity.direction == 'left' then

            -- temporarily adjust position into the wall, since bumping pushes outward
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
            -- check for colliding into doorway to transition
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.entity:collides(doorway) and doorway.open then

                    -- shift entity to center of door to avoid phasing through wall
                    self.entity.y = doorway.y + 4
                    Event.dispatch('shift-left')
                end
            end

            -- readjust
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'right' then
            
            -- temporarily adjust position
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
            
            -- check for colliding into doorway to transition
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.entity:collides(doorway) and doorway.open then

                    -- shift entity to center of door to avoid phasing through wall
                    self.entity.y = doorway.y + 4
                    Event.dispatch('shift-right')
                end
            end

            -- readjust
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'up' then
            
            -- temporarily adjust position
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
            
            -- check for colliding into doorway to transition
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.entity:collides(doorway) and doorway.open then

                    -- shift entity to center of door to avoid phasing through wall
                    self.entity.x = doorway.x + 8
                    Event.dispatch('shift-up')
                end
            end

            -- readjust
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
        else
            
            -- temporarily adjust position
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
            
            -- check for colliding into doorway to transition
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.entity:collides(doorway) and doorway.open then

                    -- shift entity to center of door to avoid phasing through wall
                    self.entity.x = doorway.x + 8
                    Event.dispatch('shift-down')
                end
            end

            -- readjust
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
        end
    end
end


function PlayerPotWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
    
    
end