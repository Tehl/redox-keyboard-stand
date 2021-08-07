render_fragments = 32;
baseplate_fragments = 8;

include <library/rotation.scad>;

include <dimensions/redox.scad>;
include <dimensions/plate.scad>;
include <dimensions/stand.scad>;
include <dimensions/struts.scad>;

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

        // remove any additional material which clips into the space
        // that holds the keyboard
        rotate([0, -stand_angle, 0])
            keyboard_inset_for_plate(true, true);

        // recess the baseplate to add a neoprene layer for grip
        translate([0, 0, -baseplate_grip_offset])
            linear_extrude(baseplate_grip_thickness)
                offset(r = -baseplate_grip_wall)
                    baseplate_outline(baseplate_depth);
    }
}

main();