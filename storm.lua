
storm = {}

function storm:new(x,y,xdir,ydir,number)
  stormImage = love.graphics.newImage("assets/evilspritesheet.png")
  fontStorm = love.graphics.newFont("assets/sitka-small-bold.ttf",58)
  collOffX = 25
  collOffY = 30
  collBoxW = 40

  numOffx = -16
  numOffy = -18

  speed = math.random(200,300)

  animations = {
    idle = {
      love.graphics.newQuad(0, 0, 125, 125, stormImage:getDimensions()),
      love.graphics.newQuad(125, 0, 125, 125, stormImage:getDimensions()),
      love.graphics.newQuad(250, 0, 125, 125, stormImage:getDimensions()),
      love.graphics.newQuad(375, 0, 125, 125, stormImage:getDimensions()),
      love.graphics.newQuad(500, 0, 125, 125, stormImage:getDimensions()),
      love.graphics.newQuad(375, 0, 125, 125, stormImage:getDimensions()),
      love.graphics.newQuad(250, 0, 125, 125, stormImage:getDimensions()),
      love.graphics.newQuad(125, 0, 125, 125, stormImage:getDimensions())
    }
  }

  numPositions = {
    x = {-1,0,1,0,-1,0,1,0},
    y = {0,0,0,0,0,0,0,0}
  }

  o = {
    spriteSheet = stormImage,
    animations = animations,
    currAnim = animations.idle,
    currFrame = 1,
    elapsedTime = 0,
    frameDuration = 0.1,
    font = fontStorm,

    x = x,
    y = y,
    w = 125,
    h = 125,
    xdir = xdir,
    ydir = ydir,
    speed = speed,
    number = number,
    numOffx = numOffx,
    numOffy = numOffy,
    sign = "-",
    numPositions = numPositions,
    collOffX = collOffX,
    collOffY = collOffY,
    collBoxW = collBoxW,

    collBox = {
      x = x + collOffX,
      y = y + collOffY,
      w = collBoxW,
      h = collBoxW
    },

    rot = 0,
    scalex = 0.75,
    scaley = 0.75,
    offsetx = 0,
    offsety = 0
  }

  setmetatable(o, self)
  self.__index = self
  return o
end

function storm:update(dt)
  self.x = self.x + self.xdir*self.speed*dt
  self.y = self.y + self.ydir*self.speed*dt

  self.collBox.x = self.x + self.collOffX
  self.collBox.y = self.y + self.collOffY

  self.elapsedTime = self.elapsedTime + dt

  if self.elapsedTime >= self.frameDuration then
    if self.currFrame < #self.currAnim then
      self.currFrame = self.currFrame + 1
    else
      self.currFrame = 1
    end
    self.elapsedTime = 0
  end

end

function storm:draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(
  self.spriteSheet,
  self.currAnim[self.currFrame],
  self.x,
  self.y,
  self.rot,
  self.scalex,
  self.scaley,
  self.offsetx,
  self.offsety
  )

  love.graphics.setFont(self.font)
--  love.graphics.setColor(27,61,80)
  love.graphics.setColor(30,30,30)

  if self.number > 0 then
    self.sign = "+"
  else
    self.sign = "-"
  end

  noWidth = self.font:getWidth(self.sign)
  noHeight = self.font:getHeight(self.sign)
  numX = self.x + self.w/2 - noWidth/2 + self.numOffx
  numY = self.y + self.h/2 - noHeight/2 + self.numOffy

  love.graphics.print(
  self.sign,
  numX + self.numPositions.x[self.currFrame],
  numY + self.numPositions.y[self.currFrame]
  )
end

return storm
