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
                    keyboard_footprint(0, body, thumb);
    
        // inset actual Redox dimensions to hold the keyboard
        translate([
            offset_x,
            offset_y,
            plate_thickness
        ])
            linear_extrude(plate_total_depth)
                // allow space to insert the keyboard
                offset(r = plate_wall_offset, $fn = render_fragments)
                    keyboard_footprint(0, body, thumb);
        
        // remove the center of the plate to save plastic;
        // just need to leave a shelf to support the edges of the keyboard
        translate([
            offset_x,
            offset_y,
            -0.5
        ])
            linear_extrude(plate_total_depth)
                offset(r = -plate_shelf_width)
                    keyboard_footprint(0, body, thumb);
        
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
