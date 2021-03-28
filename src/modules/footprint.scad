// outline of the redox keyboard
module keyboard_footprint(pad = 0, body = true, thumb = true) {
    pad2 = pad * 2;
    main_width = redox_main_width + pad2;
    main_height = redox_main_height + pad2;
    thumb_width = redox_thumb_width + pad2;
    thumb_height = redox_thumb_height + pad2;
    total_width = total_width_with_pad(pad);
    total_height = total_height_with_pad(pad);
    
    union() {
        if (body)
            translate([
                main_width / 2,
                main_height / 2
                    + (total_height - main_height),
                0
            ])
                square([
                    main_width,
                    main_height
                ], true);
       
        if (thumb)
            translate([
                total_width - thumb_rotate_x(
                    thumb_width / 2,
                    thumb_height / 2
                ),
                thumb_rotate_y(
                    -thumb_width / 2,
                    thumb_height / 2
                ),
                0
            ])
                rotate([0, 0, redox_thumb_angle])
                    square([
                        thumb_width,
                        thumb_height
                    ], true);
    };
}
