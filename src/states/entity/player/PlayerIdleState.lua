--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = BaseState}



-- todo next NOTE -- I changed the include above and will put stuff from EntityIdle as needed 
-- because it's confusing me and crashing etc, to not have explicity stuff in here etc

function PlayerIdleState:init(player, dungeon)
    
    
    self.entity = player
    self.dungeon = dungeon
    print("playeridlestate init")
    print(self.dungeon)

    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 5
    self.entity.offsetX = 0

   

    self.entity:changeAnimation('idle-' .. self.entity.direction)

end


function PlayerIdleState:enter(params)
   
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

    
    if self.entity.potCarry then
        self.entity:changeAnimation('pot-idle-' .. self.entity.direction)
    end
    


    if love.keyboard.wasPressed('space') and self.entity.potCarry == false then
        self.entity:changeState('swing-sword')
    end

    -- todo next need to add states to thow pot etc using player.potCarry attribute
    if love.keyboard.wasPressed('return') then
        print("return was pressed") 
        if self.entity.potCarry then 
            print("self.entity.potCarry")
            -- todo next - throw pot! needs to fly off etc etc
            for k, object in pairs(self.dungeon.currentRoom.objects) do
                print(object.type)
                if object.type == 'pot' then
                    object:flying()
                    print("object state is FLYING!")
                end   
            end

            -- todo then go back to idle eh?
            self.entity.potCarry = false
            self.entity:changeState('idle')
            

        else      
            -- todo very optional -- he shouldn't do the anim if there is not a pot to pick up, 
            -- so when you hit enter he is not going through the motions with nothing there
            self.entity:changeState('pot-lift')
        end
    end
    

end



function PlayerIdleState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
    
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end