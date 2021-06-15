--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerWalkState:update(dt)
    
    --debug
    --print("PlayerWalkState update - solidObject:", self.entity.solidObject)

    if self.entity.solidObject == false then
        
        if love.keyboard.isDown('left') then
            self.entity.direction = 'left'
            self.entity:changeAnimation('walk-left')
        elseif love.keyboard.isDown('right') then
            self.entity.direction = 'right'
            self.entity:changeAnimation('walk-right')
        elseif love.keyboard.isDown('up') then
            self.entity.direction = 'up'
            self.entity:changeAnimation('walk-up')
        elseif love.keyboard.isDown('down') then
            self.entity.direction = 'down'
            self.entity:changeAnimation('walk-down')
        else
            self.entity:changeState('idle')
        end
    end 

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('swing-sword')
    end

    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)


    -- todo next - OK refactor/modify the code if desired, because I was hoping to use all the self.bumped code below but it doesn't look like a good way to do it
    -- so instead I am making a new section in here just for colliding with solid objects (pots) 
    -- some stuff I did before this decision will therefore not make sense anymore 
    -- also I am not using the onCollide of the object which would be better eh?

    if self.entity.solidObject then
        --debug
        --print("solidObject code")
        
        if self.entity.direction == 'left' then

            -- temporarily adjust position away
            self.entity.x = self.entity.x + 2 + PLAYER_WALK_SPEED * dt
            
            
        elseif self.entity.direction == 'right' then
            
            -- temporarily adjust position
            self.entity.x = self.entity.x - 2 - PLAYER_WALK_SPEED * dt
            
            
        elseif self.entity.direction == 'up' then
            
            -- temporarily adjust position
            self.entity.y = self.entity.y + 2 + PLAYER_WALK_SPEED * dt
                        
        else
            
            -- temporarily adjust position
            self.entity.y = self.entity.y - 2 - PLAYER_WALK_SPEED * dt
                        
        end
        --debug
        --print("ran solidobject code - setting back to false")
        self.entity.solidObject = false
    end

    
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