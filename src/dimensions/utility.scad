function total_width_with_pad(pad) = redox_total_width
    + (pad * (1 + (cos(redox_thumb_angle) - sin(redox_thumb_angle))));

function total_height_with_pad(pad) = redox_total_height
    + (pad * (2 + (sin(redox_thumb_angle) + cos(redox_thumb_angle))));

function thumb_rotate_x(posX, posY) = posX * cos(redox_thumb_angle)
    - posY * sin(redox_thumb_angle);

function thumb_rotate_y(posX, posY) = posX * sin(redox_thumb_angle)
    + posY * cos(redox_thumb_angle);
