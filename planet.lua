planet = {}

function planet:new(mass, radius, xpos, ypos, grabbed)
  local object = {
    mass = mass;
    radius = radius;
    xpos = xpos;
    ypos = ypos;
    xvel = 100;
    yvel = 100;
    grabbed = grabbed;
    isBig = true;
    maxSpeed = radius*5;
  }
  setmetatable(object, { __index = planet })
  return object
end

function planet:new(mass, radius, xpos, ypos, grabbed, xvel, yvel)
  local object = {
    mass = mass;
    radius = radius;
    xpos = xpos;
    ypos = ypos;
    xvel = xvel;
    yvel = yvel;
    grabbed = grabbed;
    isBig = true;
    maxSpeed = radius*5;
  }
  setmetatable(object, { __index = planet })
  return object
end

function planet:update(dt)
  -- Update big planet
  local dist;
  local grav;
  local coll;

  dist = math.atan2((planets[self.grabbed].xpos - self.xpos), (planets[self.grabbed].ypos - self.ypos));
  grav = (gravity * self.mass) / (math.pow((math.abs(self.xpos) + math.abs(planets[self.grabbed].xpos)), 2) + math.pow((math.abs(self.ypos) + math.abs(planets[self.grabbed].ypos)), 2));

  self.xvel = self.xvel + math.sin(dist) * grav;
  self.yvel = self.yvel + math.cos(dist) * grav;

  if ( self.xpos + self.xvel * dt > SCREEN_WIDTH or self.xpos + self.xvel * dt < 0 ) then
    self.xvel = -self.xvel;
  end
  if ( self.ypos + self.yvel * dt > SCREEN_HEIGHT or self.ypos + self.yvel * dt < 0 ) then
    self.yvel = -self.yvel;
  end

  if (self.yvel > self.maxSpeed) then self.yvel = self.maxSpeed end
  if (self.xvel > self.maxSpeed) then self.xvel = self.maxSpeed end
  if (self.yvel < -self.maxSpeed) then self.yvel = -self.maxSpeed end
  if (self.xvel < -self.maxSpeed) then self.xvel = -self.maxSpeed end

  if (math.dist(self.xpos, self.ypos, planets[self.grabbed].xpos, planets[self.grabbed].ypos) - (self.radius + planets[self.grabbed].radius) < 0) then -- if collided with grabee
    self.xvel = -self.xvel
    self.yvel = -self.yvel
  end  


  -- remove movement from planet amun 
  self.xvel = 0;
  self.yvel = 0;

  self.xpos = self.xpos + self.xvel * dt;
  self.ypos = self.ypos + self.yvel * dt;


end

function planet:draw()
  love.graphics.setColor(250/255, 180/255, 25/255) 
  love.graphics.setColor(0/255, 0/255, 0/255) 

  love.graphics.circle("fill", self.xpos, self.ypos, self.radius, 18)
end
