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

    -- todo
    
    
    self.dx = 0
    self.dy = 0

    -- todo alter this if needed 
    -- default empty collision callback
    self.onCollide = def.onCollide or function() end
end

function GameObject:update(dt)


    -- todo next 1 update the dx / dy 
    -- check examples from earlier projects
    -- there is a lot of other code in diff places that needs to be updated too
    -- note I am not using projectile.lua at all 

    if self.state == 'flying' then
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt
        
        -- I think you can't do this here, because you need the values to increment properly
        --self.x = math.floor(self.x)
        --self.y = math.floor(self.y)
        
        --print(self.x, "--> self.x")   
    end








end
-- todo look at math.floor in here
function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        math.floor(self.x + adjacentOffsetX), math.floor(self.y + adjacentOffsetY))
end