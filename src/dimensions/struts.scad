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
