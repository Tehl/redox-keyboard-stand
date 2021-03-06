// step configuration
stand_steps = 5;
stand_step_angle = stand_angle / stand_steps;

function apply_step_rotation(point)
    = rotate(-stand_step_angle, [0, 1, 0]) * point;

// one step in the arc of supports
module support_step(points = strut_coords) {
    last_step = len(points) - 1;
    for (i = [0:last_step]) {
        thisPoint = concat(points[i], [0]);

        // vertical strut at these coords
        support_strut(
            thisPoint,
            apply_step_rotation(thisPoint),
            strut_half
        );

        // cross brace to the next set of coords
        if (i != last_step) {
            nextPoint = concat(points[i + 1], [0]);
        
            support_strut(
                thisPoint,
                apply_step_rotation(nextPoint),
                strut_brace_half
            );

            support_strut(
                nextPoint,
                apply_step_rotation(thisPoint),
                strut_brace_half
            );
        }
    }
}

// fill gaps between angled cylinders
module support_joint(points = strut_coords) {
    last_step = len(points) - 1;
    for (i = [0:last_step]) {
        thisPoint = concat(points[i], [0]);
        
        // add a sphere in the midpoint between each strut
        translate(thisPoint)
            rotate([0, -stand_step_angle / 2, 0])
                sphere(strut_half, $fn=render_fragments);
    }
}

// tented stand with support struts
module keyboard_stand(show_keyboard_volume = false) {
    difference() {
        union() {
            // keyboard plate
            rotate([0, -stand_angle, 0]) {
                keyboard_plate_with_shields(true, true);

                if (show_keyboard_volume) {
                    keyboard_volume();
                }
            }

            // support struts
            for (i = [0:stand_steps - 1]) {
                rotate([0, -stand_step_angle * i, 0]) {
                    support_step();
                }
            }

            // joints for struts
            for (i = [0:stand_steps]) {
                rotate([0, -stand_step_angle * i, 0]) {
                    support_joint();
                }
            }
        }

        // clip struts to floor plane
        translate([0, -100, -strut_size])
            cube([
                plate_main_width + 100,
                plate_main_height + 100,
                strut_size
            ]);
    }
}