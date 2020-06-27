require "planet"
require "planetling"
local moonshine = require 'moonshine' --post-processing

-- Run once on load
function love.load()
  planets = {};

  gravity = 80000;
  pause = false;

  planets[1] = planet:new(70, 70, (SCREEN_WIDTH/2) + 100, (SCREEN_HEIGHT/2) - 100, 2, 100, 200)
  planets[2] = planet:new(70, 70, (SCREEN_WIDTH/2) - 100, (SCREEN_HEIGHT/2) + 100, 1, -100, -200)
  -- Each planet has a vaguely random mass and position. They will move away from each other naturally. 
  for i = 3, 90 do
    planets[i] = planetling:new(math.random(10)*20, 2+math.random(4), 900+math.random(50), 300+math.random(100), 100, 200)
  end
  love.graphics.setBackgroundColor(10/255,14/255,23/255) 

  effect = moonshine(moonshine.effects.glow).chain(moonshine.effects.filmgrain)
  effect.filmgrain.size = 1.5
  effect.filmgrain.opacity = .5
  effect.glow.strength = 5
end

-- dist between in 2d land
function math.dist(ax, az, bx, bz) 
  return math.sqrt((bx - ax)*(bx - ax) + (bz - az)*(bz - az));
end

function love.draw()
  effect(function()
      for i = 1, #planets do
        planets[i]:draw()
      end
    end)
end

function love.update(dt)
  if not pause then    
    for i = 1, #planets do
      planets[i]:update(dt)
    end
  end
end

function love.keypressed(key)
  if key == 'p' then
    pause = not pause;
  end
end
