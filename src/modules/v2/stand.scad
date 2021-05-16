// coordinates for strut start points, before tenting is applied
strut_coords = [
    // top edge, mid-point (aligned with thumb plate corner)
    [thumb_plate_center_x + thumb_rotate_x(-thumb_half_x + strut_half, -thumb_half_y + strut_half),
     plate_total_height - strut_half],
    // top edge, corner
    [plate_main_width - strut_half,
     plate_total_height - strut_half],
    // thumb plate corners
    [thumb_plate_center_x + thumb_rotate_x(-strut_half, thumb_half_y - strut_half),
     thumb_plate_center_y + thumb_rotate_y(-strut_half, thumb_half_y - strut_half)],
    [thumb_plate_center_x + thumb_rotate_x(thumb_half_x - strut_half, thumb_half_y - strut_half),
     thumb_plate_center_y + thumb_rotate_y(thumb_half_x - strut_half, thumb_half_y - strut_half)],
    [thumb_plate_center_x + thumb_rotate_x(thumb_half_x - strut_half, -thumb_half_y + strut_half),
     thumb_plate_center_y + thumb_rotate_y(thumb_half_x - strut_half, -thumb_half_y + strut_half)],
    [thumb_plate_center_x + thumb_rotate_x(-thumb_half_x + strut_half, -thumb_half_y + strut_half),
     thumb_plate_center_y + thumb_rotate_y(-thumb_half_x + strut_half, -thumb_half_y + strut_half)]
];

// step configuration
stand_steps = 5;
stand_step_angle = stand_angle / stand_steps;

function apply_step_rotation(point)
    = rotate(-stand_step_angle, [0, 1, 0]) * point;

// one step in the arc of supports
module support_step() {
    last_step = len(strut_coords) - 1;
    for (i = [0:last_step]) {
        thisPoint = concat(strut_coords[i], [0]);

        // vertical strut at these coords
        support_strut(
            thisPoint,
            apply_step_rotation(thisPoint),
            strut_half
        );

        // cross brace to the next set of coords
        if (i != last_step) {
            nextPoint = concat(strut_coords[i + 1], [0]);
        
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
module support_joint() {
    last_step = len(strut_coords) - 1;
    for (i = [0:last_step]) {
        thisPoint = concat(strut_coords[i], [0]);
        
        // 
        translate(thisPoint)
            rotate([0, -stand_step_angle / 2, 0])
                sphere(strut_half, $fn=render_fragments);
    }
}

// tented stand with support struts
module keyboard_stand(show_keyboard_volume = false) {
    rotate([0, -stand_angle, 0]) {
        keyboard_plate(true, true);

        if (show_keyboard_volume) {
            keyboard_volume();
        }
    }

    for (i = [0:stand_steps - 1]) {
        rotate([0, -stand_step_angle * i, 0]) {
            support_step();
        }
    }

    for (i = [0:stand_steps]) {
        rotate([0, -stand_step_angle * i, 0]) {
            support_joint();
        }
    }
}