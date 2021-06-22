// outline of the main redox body
module keyboard_footprint_body() {
    translate([
        redox_main_width / 2,
        redox_main_height / 2
            + (redox_total_height - redox_main_height),
        0
    ])
        square([
            redox_main_width,
            redox_main_height
        ], true);
}

// outline of the redox thumb cluster
module keyboard_footprint_thumb() {
    translate([
        redox_total_width - thumb_rotate_x(
            redox_thumb_width / 2,
            redox_thumb_height / 2
        ),
        thumb_rotate_y(
            -redox_thumb_width / 2,
            redox_thumb_height / 2
        ),
        0
    ])
        rotate([0, 0, redox_thumb_angle])
            square([
                redox_thumb_width,
                redox_thumb_height
            ], true);
}

// outline of the redox keyboard
module keyboard_footprint(body = true, thumb = true) {
    union() {
        if (body) {
            keyboard_footprint_body();
        }            
       
        if (thumb) {
            keyboard_footprint_thumb();
        }            
    };
}
