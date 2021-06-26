render_fragments = 16;
baseplate_fragments = 4;

include <library/rotation.scad>;

include <dimensions/redox.scad>;
include <dimensions/plate.scad>;
include <dimensions/stand.scad>;
include <dimensions/struts.scad>;
include <dimensions/utility.scad>;

include <modules/outlines/keyboard.scad>;
include <modules/outlines/baseplate.scad>;

include <modules/volumes/keyboard.scad>;

include <modules/hex.scad>;
include <modules/plate.scad>;
include <modules/support.scad>;
include <modules/stand.scad>;
include <modules/baseplate.scad>;

module main() {
    difference() {
        union() {
            keyboard_stand(show_keyboard_volume = false);
            baseplate();
        }

        // recess the baseplate to add a neoprene layer for grip
        translate([0, 0, -0.01])
            linear_extrude(2)
                offset(r = -4)
                    baseplate_outline(baseplate_depth);
    }
}

main();