--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

-- added to object for the pot collision detection (was only for entity in the distro)
function GameObject:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end


function GameObject:init(def, x, y)
    
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.consumable = def.consumable

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    self.distanceTraveled = 0

    self.dx = 0
    self.dy = 0

    
    -- default empty collision callback
    self.onCollide = def.onCollide or function() end
end

function GameObject:update(dt)


    if self.state == 'flying' then
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt
        

        -- note you can't do this here, because you need the values to increment properly
        --self.x = math.floor(self.x)
        --self.y = math.floor(self.y)
        

        -- smash the pot after it has traveled 4 tiles
        self.distanceTraveled = self.distanceTraveled + math.max(math.abs(self.dx * dt), math.abs(self.dy * dt))
        print("self.distanceTraveled: ", self.distanceTraveled)

        if self.distanceTraveled >= TILE_SIZE * 4 then
            self.state = 'broken'
            gSounds['door']:play()
        end
                

         -- check to see if we collide with a wall
        local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
         + MAP_RENDER_OFFSET_Y - TILE_SIZE

        if self.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
            self.state = 'broken'
            gSounds['door']:play()
        elseif self.x + 16 >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
            self.state = 'broken'
            gSounds['door']:play()
        elseif self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - 16 / 2 then 
            self.state = 'broken'
            gSounds['door']:play()
        elseif self.y + 16 >= bottomEdge then
            self.state = 'broken'
            gSounds['door']:play()
        end
        
        --print(self.x, "--> self.x")   
    end








end
-- NOTE check out math.floor in here
function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        math.floor(self.x + adjacentOffsetX), math.floor(self.y + adjacentOffsetY))
end