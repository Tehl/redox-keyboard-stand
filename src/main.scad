render_fragments = 16;
baseplate_fragments = 4;

include <library/rotation.scad>;

include <dimensions/redox.scad>;
include <dimensions/plate.scad>;
include <dimensions/stand.scad>;
include <dimensions/utility.scad>;

include <modules/hex.scad>;
include <modules/footprint.scad>;
include <modules/plate.scad>;
include <modules/support.scad>;
include <modules/baseplate_common.scad>;
include <modules/keyboard_volume.scad>;

include <modules/v2/stand.scad>;
include <modules/v2/baseplate.scad>;

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
                    baseplate_projection(baseplate_depth);
    }
}

main();