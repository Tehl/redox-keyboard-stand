// outline of the main redox body
module keyboard_outline_body() {
    square([
        redox_main_width,
        redox_main_height
    ]);
}

// outline of the redox thumb cluster
module keyboard_outline_thumb() {
    translate([redox_thumb_contact_point, 0, 0])
        rotate([0, 0, redox_thumb_angle])
            square([
                redox_thumb_width,
                redox_thumb_height
            ]);
}

// outline of the redox keyboard
module keyboard_outline(body = true, thumb = true) {
    union() {
        if (body) {
            keyboard_outline_body();
        }            
       
        if (thumb) {
            keyboard_outline_thumb();
        }            
    };
}
