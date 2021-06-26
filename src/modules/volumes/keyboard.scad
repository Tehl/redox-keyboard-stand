// basic volumes of the actual keyboard, for sizing/visualisation
module keyboard_volume(opacity = 0.3) {
    // keyboard body
    translate([
        plate_wall_thickness,
        plate_total_height - redox_total_height - plate_wall_thickness,
        plate_thickness
    ])
    color("red", opacity)
        linear_extrude(redox_volume_body_depth)
            keyboard_outline(true, true);

    // switches/keycaps
    translate([
        plate_wall_thickness,
        plate_total_height - redox_total_height - plate_wall_thickness,
        plate_thickness + redox_volume_body_depth
    ])
    color("teal", opacity)
        linear_extrude(redox_volume_keycap_depth)
            offset(-redox_volume_keycap_inset)
                keyboard_outline(true, true);

    // TRRS jack
    translate([
        redox_main_width + plate_wall_thickness - redox_trrs_offset_x - redox_trrs_width / 2 - redox_volume_trrs_width / 2,
        plate_total_height - plate_wall_thickness,
        plate_thickness - (redox_volume_trrs_depth - redox_volume_body_depth) - redox_volume_trrs_drop
    ])
    color("green", opacity)
        cube([
            redox_volume_trrs_width,
            redox_volume_trrs_height,
            redox_volume_trrs_depth
        ]);

    // USB jack
    translate([
        redox_main_width + plate_wall_thickness - redox_usb_offset_x - redox_usb_width / 2 - redox_volume_usb_width / 2,
        plate_total_height - plate_wall_thickness,
        plate_thickness - (redox_volume_usb_depth - redox_volume_body_depth) - redox_volume_usb_drop
    ])
    color("green", opacity)
        cube([
            redox_volume_usb_width,
            redox_volume_usb_height,
            redox_volume_usb_depth
        ]);
}