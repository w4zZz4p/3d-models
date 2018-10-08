$fn = 50;
BODY_RADIUS = 12.5;
BODY_HEIGHT = 5;
BODY_PADDING = 0.8;
RING_WIDTH = 1.8;
RING_HEIGHT = 1;
RING_ROUND = 0.8;
RING_COUNT = 4;
RING_STEP = BODY_RADIUS / RING_COUNT;

module ring(r, h, n) {
  rotate_extrude()
    union(){
      offset(r = n) offset(delta = -n) translate([r - RING_WIDTH, 0, 0]) square([RING_WIDTH,h]);
    }
}

module checker() {
  for (a = [0 : RING_STEP: RING_STEP * (RING_COUNT - 1)]) {
    ring(
      BODY_RADIUS - a,
      BODY_HEIGHT - BODY_PADDING * (a > 0 ? 1 : 0),
      RING_ROUND
    );
  }
  translate([0, 0, BODY_PADDING]) linear_extrude(BODY_HEIGHT - BODY_PADDING * 2) circle(BODY_RADIUS-RING_WIDTH);
  translate([0, 1, BODY_HEIGHT - RING_HEIGHT - 0.2]) linear_extrude(RING_HEIGHT) scale([0.046, 0.065 , 1]) import("crown.svg");
}

checker();
