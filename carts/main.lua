-- main

local header = [[
▤▤▤▤▤ pico-8.com ▤▤▤▤▤
]]

local points

function _init()
  points = {}
  for x=-1,1,1/3 do
    for y=-1,1,1/3 do
      for z=-1,1,1/3 do
        local p = {
          x = x,
          y = y,
          z = -z,
          col = 8 + (x*2 + y*3)%8
        }
        add(points, p)
      end
    end
  end
end

function _draw()
  cls()

  compute_camera_coords(points)
  sort_by_z(points)

  for p in all(points) do
    sx, sy = project_to_screen(p)

    rad = 6/p.cz
    if p.cz > 0.1 then
      circfill(sx, sy, rad, p.col)
      circfill(sx+rad/3, sy-rad/3, rad/3, 7)
    end
  end

  print(header)
end
