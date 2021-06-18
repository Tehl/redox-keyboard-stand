plate_thickness = 3;
plate_wall_thickness = 3;
plate_wall_height = 5;
plate_wall_offset = 0.5;
plate_shelf_width = 15;

plate_main_width = redox_main_width + plate_wall_thickness * 2;
plate_main_height = redox_main_height + plate_wall_thickness * 2;
plate_thumb_width = redox_thumb_width + plate_wall_thickness * 2;
plate_thumb_height = redox_thumb_height + plate_wall_thickness * 2;
plate_total_width = total_width_with_pad(plate_wall_thickness);
plate_total_height = total_height_with_pad(plate_wall_thickness);
plate_total_depth = plate_thickness + plate_wall_height;

thumb_plate_center_x = plate_total_width - thumb_rotate_x(
    plate_thumb_width / 2,
    plate_thumb_height / 2
);

thumb_plate_center_y = thumb_rotate_y(
    -plate_thumb_width / 2,
    plate_thumb_height / 2
);

thumb_half_x = plate_thumb_width / 2;
thumb_half_y = plate_thumb_height / 2;

shield_thickness = 3;
shield_depth_pad = 3;
