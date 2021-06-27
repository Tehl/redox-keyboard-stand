// the top left thumb strut should sit on the intersection of the main body
// with the top edge of the thumb plate.
// we know that the post-rotation x coordinate will match the right edge of
// the body, so we can solve backwards from there to find where on the
// thumb plate to place the strut.
thumb_contact_to_edge_offset = redox_main_width - redox_thumb_contact_point;
thumb_strut_offset_x = (thumb_contact_to_edge_offset + redox_thumb_height * sin(redox_thumb_angle))
                        / cos(redox_thumb_angle);

// coordinates of the thumb struts if the thumb plate was at [0,0,0],
// prior to applying the thumb angle
thumb_strut_baseline = [
    [thumb_strut_offset_x,
     redox_thumb_height,
     0],
    [redox_thumb_width,
     redox_thumb_height,
     0],
    [redox_thumb_width,
     0,
     0],
    [0,
     0,
     0]
];


// coordinates of the thumb struts if the thumb plate was at [0,0,0],
// with thumb angle applied
thumb_strut_rotated = [
    rotate(redox_thumb_angle, [0, 0, 1]) * thumb_strut_baseline[0],
    rotate(redox_thumb_angle, [0, 0, 1]) * thumb_strut_baseline[1],
    rotate(redox_thumb_angle, [0, 0, 1]) * thumb_strut_baseline[2],
    rotate(redox_thumb_angle, [0, 0, 1]) * thumb_strut_baseline[3]
];

// coordinates for strut start points, before tenting is applied
strut_coords = [
    // top edge, mid-point (aligned with thumb plate corner)
    [redox_thumb_contact_point,
     plate_main_height - strut_half],
    // top edge, corner
    [plate_main_width - strut_half,
     plate_main_height - strut_half],
    // thumb plate corners
    [thumb_strut_rotated[0].x + redox_thumb_contact_point + plate_wall_thickness,
     thumb_strut_rotated[0].y + plate_wall_thickness],
    [thumb_strut_rotated[1].x + redox_thumb_contact_point + plate_wall_thickness,
     thumb_strut_rotated[1].y + plate_wall_thickness],
    [thumb_strut_rotated[2].x + redox_thumb_contact_point + plate_wall_thickness,
     thumb_strut_rotated[2].y + plate_wall_thickness],
    [thumb_strut_rotated[3].x + redox_thumb_contact_point + plate_wall_thickness,
     thumb_strut_rotated[3].y + plate_wall_thickness]
];
