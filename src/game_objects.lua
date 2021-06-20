--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        consumable = false,
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['heart'] = {
        
        type = 'heart',
        texture = 'hearts',
        frame = 5,
        width = 16,
        height = 16,
        solid = false,
        consumable = true,
        defaultState = 'default',  -- this stuff is needed for the graphics part to work
        states = {
            ['default'] = {
                frame = 5
            }
        }

    },
    ['pot'] = {
                
        type = 'pot',
        texture = 'tiles',
        frame = 33,
        width = 16,
        height = 16,
        solid = true,
        distanceTraveled = 0,
        consumable = false,
        defaultState = 'default',  
        states = { 
            ['default'] = {
                frame = 33
            },
            ['carried'] = {
                frame = 33
            },
            ['broken'] = {
                frame = 52
            },
            ['flying'] = {
                frame = 33
            }
        }


    }
}