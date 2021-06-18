// coordinates for strut start points, before tenting is applied
strut_coords_body = [
    [plate_main_width / 2 - strut_half,
     plate_total_height - strut_half],
    [plate_main_width - strut_half,
     plate_total_height - strut_half],
    [plate_main_width - strut_half,
     plate_total_height - plate_main_height + strut_half],
    [plate_main_width / 2 - strut_half,
     plate_total_height - plate_main_height + strut_half]
];

strut_coords_thumb = [
    [thumb_plate_center_x + thumb_rotate_x(-strut_half, thumb_half_y - strut_half),
     thumb_plate_center_y + thumb_rotate_y(-strut_half, thumb_half_y - strut_half)],
    [thumb_plate_center_x + thumb_rotate_x(thumb_half_x - strut_half, thumb_half_y - strut_half),
     thumb_plate_center_y + thumb_rotate_y(thumb_half_x - strut_half, thumb_half_y - strut_half)],
    [thumb_plate_center_x + thumb_rotate_x(thumb_half_x - strut_half, -thumb_half_y + strut_half),
     thumb_plate_center_y + thumb_rotate_y(thumb_half_x - strut_half, -thumb_half_y + strut_half)],
    [thumb_plate_center_x + thumb_rotate_x(-thumb_half_x + strut_half, -thumb_half_y + strut_half),
     thumb_plate_center_y + thumb_rotate_y(-thumb_half_x +    strut_half, -thumb_half_y + strut_half)]
];

// support strut to hold the stand at the tenting angle
module strut(posX, posY) {
    length = (sin(stand_angle) * posX) / sin(90 - stand_angle)
        + (tan(stand_angle) * strut_size / 2);
    
    translate([posX, posY, -length * 0.5])
        cylinder(
            h = length,
            d = strut_size,
            center = true,
            $fn = render_fragments
        );
}

// tented stand with support struts
module keyboard_stand(body_struts = 2, thumbStruts = 4, show_keyboard_volume = false) {
    difference() {
        rotate([0, -stand_angle, 0]) {
            union() {
                keyboard_plate_with_shields(body_struts > 0, thumbStruts > 0);

                if (show_keyboard_volume) {
                    keyboard_volume();
                }

                if (body_struts > 0) {
                    for (i = [0:body_struts - 1]) {
                        strut(
                            strut_coords_body[i][0],
                            strut_coords_body[i][1]
                        );
                    }
                }
                if (thumbStruts > 0) {
                    for (i = [0:thumbStruts - 1]) {
                        strut(
                            strut_coords_thumb[i][0],
                            strut_coords_thumb[i][1]
                        );
                    }
                }
            }
        };
        
        // clip struts to floor plane
        translate([0, 0, -strut_size])
            cube([
                plate_total_width / cos(stand_angle),
                plate_total_height,
                strut_size
            ]);
    }
}
