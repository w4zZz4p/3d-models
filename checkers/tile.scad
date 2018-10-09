/*
Print settings
  layer height: 0.2
*/

include <variables.scad>;

$fn=50;

module clip(r = CLIP_CORNER_RADIUS) {
  linear_extrude(CLIP_HEIGHT)
    offset(r = r)
        polygon([
          [-CLIP_WIDTH / 2, 0],
          [-CLIP_WIDTH / 2, CLIP_LENGTH - CLIP_CAP_LENGTH],
          [-CLIP_CAP_WIDTH / 2, CLIP_LENGTH],
          [CLIP_CAP_WIDTH / 2, CLIP_LENGTH],
          [CLIP_WIDTH / 2, CLIP_LENGTH - CLIP_CAP_LENGTH],
          [CLIP_WIDTH / 2, 0]
        ]);
}

module tile() {
  for (a=[0:90:270]) rotate([0, 0, a]) translate([-TILE_SIZE/4, TILE_SIZE/2, 0]) clip();
  difference() {
    translate([-TILE_SIZE/2, -TILE_SIZE/2, 0]) linear_extrude(TILE_HEIGHT) offset(r=1) offset(delta=-1) square(TILE_SIZE, TILE_SIZE);
    translate([0, 0, TILE_HEIGHT - TILE_CIRCLE_DEPTH]) linear_extrude(TILE_CIRCLE_DEPTH) circle(TILE_CIRCLE_RADIUS);
    for (a=[0:90:270]) rotate([0, 0, a]) translate([TILE_SIZE/4, TILE_SIZE/2, 0]) rotate([0,0,180]) clip(CLIP_CORNER_RADIUS + 0.1);
  }
}

tile();
