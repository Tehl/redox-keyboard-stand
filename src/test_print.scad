render_fragments = 16;
baseplate_fragments = 4;

include <dimensions/redox.scad>;
include <dimensions/plate.scad>;

include <modules/outlines/keyboard.scad>;
include <modules/volumes/keyboard.scad>;
include <modules/plate.scad>;

keyboard_plate_with_shields();
//keyboard_volume();
