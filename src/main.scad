render_fragments = 32;
baseplate_fragments = 16;

include <dimensions/redox.scad>;
include <dimensions/plate.scad>;
include <dimensions/stand.scad>;
include <dimensions/utility.scad>;

include <modules/hex.scad>;
include <modules/footprint.scad>;
include <modules/plate.scad>;
include <modules/keyboard_volume.scad>;
include <modules/v1/main.scad>;

main(show_keyboard_volume = true);