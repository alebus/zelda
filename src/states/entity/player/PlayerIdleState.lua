--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)

    
    -- todo optional - it crashes with "self.entity = player" - why?
    -- look at the diff in other files, I think it has something to do with the state including EntityXState?
    -- self.entity = player

    self.dungeon = dungeon


    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 5
    self.entity.offsetX = 0

   
   
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        
        -- can't swing sword if carrying pot
        if self.entity.potCarry then 
            self.entity:changeState('pot-walk')
        else
            self.entity:changeState('walk')
        end
    end

    -- todo put this in init if needed etc, see similar examples 
    if self.entity.potCarry then
        self.entity:changeAnimation('pot-idle-' .. self.entity.direction)
    end
    


    if love.keyboard.wasPressed('space') and self.entity.potCarry == false then
        self.entity:changeState('swing-sword')
    end

    -- todo next need to add states to thow pot etc using player.potCarry attribute
    if love.keyboard.wasPressed('return') then
        print("return was pressed")            
        self.entity:changeState('pot-lift')
    end
    

end