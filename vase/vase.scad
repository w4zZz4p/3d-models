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

function levelRadius(level) = radius + (radiusTop-radius) / levels * level;
function levelTwist(level) = level * twist;
function spikeRadius(level, side) = let(
  oddLayer = level % 2 == 1,
  oddPoint = side % 2 == 1
) (oddLayer && oddPoint) ? spike : (!oddLayer && !oddPoint) ? spike : 0;

// ----------------------------------------------------------------------------
maxHeight = height - height % levels; // recalculated max height
levelHeight = maxHeight / levels; // one level height
sideAngle = 360 / sides; // one side angle

points = [
  for(level = [0:levels])
    for(side = [0:sides - 1])
      let(
        t = levelTwist(level),
        r = levelRadius(level) + spikeRadius(level, side),
        x = r * cos(sideAngle * side + t),
        y = r * sin(sideAngle * side + t)
      )
      [x, y, level * levelHeight]
];

function p(level, side) = [
  side + sides * level,
  side + sides * (level + 1),
  ((side + 1) % sides) + sides * (level + 1),
  ((side + 1) % sides) + sides * level
];

faces = concat(
  [
    for(level = [0:levels - 1])
      for(side = [0:sides - 1])
        let (o = p(level, side))
        ((level + side) % 2 == 0) ? [o[0], o[1], o[2]] : [o[1], o[2], o[3]]
  ],
  [
    for(level = [0:levels - 1])
      for(side = [0:sides - 1])
        let (o = p(level, side))
        ((level + side) % 2 == 0) ? [o[2], o[3], o[0]] : [o[3], o[0], o[1]]
  ],
  [[for(s = [sides - 1:-1:0]) levels * sides + s]], // top
  [[for(s = [0:sides - 1]) s]] // bottom
);

translate([0, 0, 0])
  scale([1, 1, height / maxHeight])
    polyhedron(points, faces);
