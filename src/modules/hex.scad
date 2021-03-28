hex_size = 20;
hex_thickness = 3;

// hollow hexagon for structural supports
module hex(height) {
    rotate([0, 0, 30])
        difference() {
            cylinder(h = height, r = hex_size, $fn = 6);
            translate([0, 0, -0.5])
                cylinder(h = height + 1, r = hex_size - hex_thickness, $fn = 6);
        }
}

// 7x5 grid of interlocking hexagons for structural supports
module hex_grid(height) {
    for (i = [0:7], j = [0:5]) {
        translate([
            i * (hex_size * 2 * cos(30) - hex_thickness)
                + (j % 2) * (hex_size * cos(30) - hex_thickness / 2),
            j * (hex_size + hex_size / 2 * cos(30)),
            0
        ])
            hex(height);
    }
}
