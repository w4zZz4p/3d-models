// Height
height = 200; // [10:200]

// Bottom radius
radius = 50; // [1:120]

// Top radius
radiusTop = 50; // [1:120]

// Number of Sides
sides = 10; // [3:100]

// Number of Levels
levels = 3; // [1:100]

// Spike size
spike = 10; // [0:20]

// Twist angle per layer
twist = 0; // [0:360]

function levelRadius(level) = radius + (radiusTop-radius)/levels * level;
function levelTwist(level) = level * twist;
/* function spikeRadius(level, side) = let(
  oddLayer = level % 2 == 1,
  evenPoint = side % 2 == 0
) (oddLayer && evenPoint) ? spike : 0; */
function spikeRadius(level, side) = let(
  oddLayer = level % 2 == 1,
  oddPoint = side % 2 == 1
) (oddLayer && oddPoint) ? spike : (!oddLayer && !oddPoint) ? spike : 0;

// ----------------------------------------------------------------------------
maxHeight = height - height % levels; // recalculated max height
levelHeight = floor(height / levels); // one level height
sideAngle = 360 / sides; // one side angle

points = [
  for(z = [0:levelHeight:maxHeight])
    for(i = [0:sideAngle:359])
      let(
        level = z / levelHeight,
        side = i / sideAngle,
        t = levelTwist(level),
        r = levelRadius(level) + spikeRadius(level, side),
        x = r * cos(i + t),
        y = r * sin(i + t)
      )
      [x, y, z]
];

function p(s, z) = [
  s + sides * z,
  s + sides * (z + 1),
  ((s + 1) % sides) + sides * (z + 1),
  ((s + 1) % sides) + sides * z
];

faces = concat(
  [
    for(z = [0:(maxHeight / levelHeight) - 1])
      for(s = [0:sides - 1])
        let (o = p(s, z))
        ((s + z) % 2 == 0) ? [o[0], o[1], o[2]] : [o[1], o[2], o[3]]
  ],
  [
    for(z = [0:(maxHeight / levelHeight) - 1])
      for(s = [0:sides - 1])
        let (o = p(s, z))
        ((s + z) % 2 == 0) ? [o[2], o[3], o[0]] : [o[3], o[0], o[1]]
  ],
  [[for(s = [sides - 1:-1:0]) maxHeight / levelHeight * sides + s]], // top
  [[for(s = [0:sides - 1]) s]] // bottom
);

translate([0,0,0])
  scale([1,1,height/maxHeight])
    polyhedron(points, faces);
