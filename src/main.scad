render_fragments = 32;
baseplate_fragments = 16;

include <dimensions/redox.scad>;
include <dimensions/plate.scad>;
include <dimensions/stand.scad>;
include <dimensions/utility.scad>;

include <modules/hex.scad>;
include <modules/footprint.scad>;
include <modules/plate.scad>;
include <modules/stand.scad>;
include <modules/baseplate.scad>;

module main() {
    difference() {
        union() {
            keyboard_stand();
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
