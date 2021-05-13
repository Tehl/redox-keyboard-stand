// basic volumes of the actual keyboard, for sizing/visualisation
module keyboard_volume() {
    // keyboard body
    translate([
        plate_wall_thickness,
        plate_total_height - redox_total_height - plate_wall_thickness,
        plate_thickness
    ])
    color("red", 0.3)
        linear_extrude(15)
            keyboard_footprint(0, true, true);

    // switches/keycaps
    translate([
            plate_wall_thickness,
            plate_total_height - redox_total_height - plate_wall_thickness,
            plate_thickness + 15
        ])
        color("teal", 0.3)
            linear_extrude(18)
                offset(-9)
                    keyboard_footprint(0, true, true);
}