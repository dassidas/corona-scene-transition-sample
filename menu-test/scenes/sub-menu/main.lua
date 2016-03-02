-- this file is virtually identical to main-menu.lua; see main-menu.lua for comments
local composer = require 'composer'
local controls = require 'engine.controls.controls'
-- local player = require 'engine.player.player'
local generateCharacter = require 'engine.player.character'

local scene = composer.newScene()

function scene:create( event )

    local sceneGroup = self.view

    local text = display.newText({parent=sceneGroup, text='Sub', x=display.contentWidth/2, y=display.contentHeight/4, fontSize=30})
end


function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    composer.removeHidden(false)

    if ( phase == "will" ) then
        
        -- character
        local character = generateCharacter("Jedi","right",1,"Helvetica")
        character.group.x = math.random( 50, display.contentWidth - 50 )
        character.group.y = math.random( 50, display.contentHeight - 50 )

        -- insert the character into the sceneGroup (so it is removed upon scene transition)
        sceneGroup:insert(character.group)
        -- apply controls to the player object (note that the variable now references the initialized controls object, NOT the controlWrapper returned by 'require "controls"')
        controls = controls(character)
        -- attach controls to the sceneGroup
        sceneGroup:insert(controls)

        local function transitionScene ()
            local options = {
                effect = "fade",
                time = 500,
                params = {
                    someKey = "someValue",
                    someOtherKey = 10
                }
            }

            timer.performWithDelay(100, composer.gotoScene('scenes.main-menu.main', options))
        end
        -- circle for clickin'
        local circle = display.newCircle(sceneGroup, display.contentWidth/2, display.contentHeight/5*4, 30)
        local collisionFilter = { categoryBits = 4, maskBits = 2 }
        local body = { filter=collisionFilter, isSensor=true }
        physics.addBody ( circle, body )

        circle:addEventListener('collision', transitionScene)
    end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )

return scene