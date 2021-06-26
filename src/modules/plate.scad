// hollow shield to protect jack contact points
module shield_plate(width, height, depth, gap, thickness) {
    total_pad = (gap + thickness) * 2;

    translate([width + total_pad, 0, 0])
        rotate([0, 270, 0])
            intersection() {
                // bounding volume
                linear_extrude(width + total_pad)
                    square([depth + total_pad, height + total_pad]);

                difference() {
                    // outer edge of shell
                    linear_extrude(width + total_pad)
                        offset(r = gap + thickness, $fn = render_fragments)
                            square([depth, height]);

                    // inner edge of shell
                    translate([0, 0, thickness])
                        linear_extrude(width + gap * 2)
                            offset(r = gap, $fn = render_fragments)
                                square([depth, height]);
                }
            }
}

// walled plate to hold the redox keyboard body
module keyboard_plate(body = true, thumb = true) {
    offset_x = plate_wall_thickness;
    offset_y = plate_wall_thickness * (
            1 + (sin(redox_thumb_angle) + cos(redox_thumb_angle))
        );
    
    difference() {
        // padded dimensions for the outer wall, with rounded corners
        translate([
            offset_x,
            offset_y,
            0
        ])
            linear_extrude(plate_total_depth)
                offset(r = plate_wall_thickness, $fn = render_fragments)
                    keyboard_outline(body, thumb);
    
        // inset actual Redox dimensions to hold the keyboard
        translate([
            offset_x,
            offset_y,
            plate_thickness
        ])
            linear_extrude(plate_total_depth)
                // allow space to insert the keyboard
                offset(r = plate_wall_offset, $fn = render_fragments)
                    keyboard_outline(body, thumb);
        
        // remove the center of the plate to save plastic;
        // just need to leave a shelf to support the edges of the keyboard
        translate([
            offset_x,
            offset_y,
            -0.5
        ])
            linear_extrude(plate_total_depth)
                offset(r = -plate_shelf_width)
                    keyboard_outline(body, thumb);
        
        // hole for LED strip
        translate([
            redox_lightstrip_offset_x,
            plate_total_height - redox_lightstrip_height - redox_lightstrip_offset_y,
            -1
        ])
            linear_extrude(plate_total_depth)
                square([
                    redox_lightstrip_width,
                    redox_lightstrip_height
                ], false);
        
        // hole for TRRS cable
        translate([
            redox_main_width + plate_wall_thickness - redox_trrs_offset_x - redox_trrs_width,
            plate_total_height - plate_wall_thickness - 0.12,
            -0.5
        ])
            cube([
                redox_trrs_width,
                plate_wall_thickness + 1,
                plate_total_depth + 1
            ]);
            
        // hole for USB cable
        translate([
            redox_main_width + plate_wall_thickness - redox_usb_offset_x - redox_usb_width,
            plate_total_height - plate_wall_thickness - 0.1,
            -0.5
        ])
            cube([
                redox_usb_width,
                plate_wall_thickness + 1,
                plate_total_depth + 1
            ]);
    }
}

// walled keyboard plate with shields to project cable jacks
module keyboard_plate_with_shields(body = true, thumb = true) {
    union() {
        keyboard_plate(body, thumb);

        // shield for TRRS cable
        translate([
            redox_main_width + plate_wall_thickness - redox_trrs_offset_x - redox_trrs_width - shield_thickness,
            plate_total_height - plate_wall_thickness + plate_wall_offset,
            plate_thickness - (redox_volume_trrs_depth - redox_volume_body_depth) - redox_volume_trrs_drop - shield_depth_pad
        ])
            shield_plate(
                redox_volume_trrs_width,
                redox_volume_trrs_height,
                redox_volume_trrs_depth + (shield_depth_pad * 2),
                (redox_trrs_width - redox_volume_trrs_width) / 2,
                shield_thickness
            );

        // shield for USB cable
        translate([
            redox_main_width + plate_wall_thickness - redox_usb_offset_x - redox_usb_width - shield_thickness,
            plate_total_height - plate_wall_thickness + plate_wall_offset,
            plate_thickness - (redox_volume_usb_depth - redox_volume_body_depth) - redox_volume_usb_drop - shield_depth_pad
        ])
            shield_plate(
                redox_volume_usb_width,
                redox_volume_usb_height,
                redox_volume_usb_depth + (shield_depth_pad * 2),
                (redox_usb_width - redox_volume_usb_width) / 2,
                shield_thickness
            );
    }
}