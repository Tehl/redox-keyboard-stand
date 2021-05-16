include <stand.scad>;
include <baseplate.scad>;

module main(show_keyboard_volume = false) {
    difference() {
        union() {
            keyboard_stand(show_keyboard_volume = show_keyboard_volume);
            baseplate();
        }

        // recess the baseplate to add a neoprene layer for grip
        translate([0, 0, -0.01])
            linear_extrude(2)
                offset(r = -4)
                    baseplate_projection(baseplate_depth);
    }
}
