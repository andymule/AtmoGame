-- Game Scale
-- Global
scale = 9 -- Screen scale
speed = 50 -- Base speed for stuff
bounciness = 1.1 -- Bounce factor for shapes
SCREEN_WIDTH = 160*scale
SCREEN_HEIGHT = 90*scale
function love.conf(t)
  t.title = "Gravity - OO"
  t.window.width = SCREEN_WIDTH
  t.window.height = SCREEN_HEIGHT
end