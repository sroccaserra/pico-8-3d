-- 3d

function rot(x, y, a)
  return cos(a)*x - sin(a)*y,
         cos(a)*y + sin(a)*x
end

function compute_camera_coords(points)
  for p in all(points) do
    p.cx, p.cz = rot(p.x, p.z, t()/8)
    p.cy, p.cz = rot(p.y, p.cz, t()/7)
    p.cz = p.cz + 2 + cos(t()/6)
  end
end

function sort_by_z(points)
  for pass=1,3 do
    for i=1,#points-1 do
      if points[i].cz < points[i+1].cz then
        points[i], points[i+1] = points[i+1], points[i]
      end
    end

    for i=#points-1,1-1 do
      if points[i].cz < points[i+1].cz then
        points[i], points[i+1] = points[i+1], points[i]
      end
    end
  end
end

function project_to_screen(p)
  sx = 64 + p.cx*64/p.cz
  sy = 64 + p.cy*64/p.cz
  return sx, sy
end
