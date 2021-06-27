baseplate_coords_main = [ 
    strut_coords[1],
    strut_coords[2],
    strut_coords[5]
];

baseplate_coords_thumb = [
    strut_coords[2],
    strut_coords[3],
    strut_coords[4],
    strut_coords[5]
];

// hull of contact points between the stand and floor plane
module baseplate_outline(slice_z) {
    union() {
        hull() {
            // project main body
            projection(cut = true)
                translate([0, 0, -slice_z]) {
                    support_step(baseplate_coords_main);
                    support_joint(baseplate_coords_main);
                }
            
            // fix for top left corner projection differing by slice_z
            translate([
                plate_wall_thickness / 2,
                plate_main_height - plate_wall_thickness,
                0
            ])
                circle(plate_wall_thickness, $fn = render_fragments);
            
            // fix for bottom left corner projection differing by slice_z
            translate([
                plate_wall_thickness / 2,
                plate_wall_thickness,
                0
            ])
                circle(plate_wall_thickness, $fn = render_fragments);
        }

        hull()
            // project thumb plate
            projection(cut = true)
                translate([0, 0, -slice_z]) {
                    support_step(baseplate_coords_thumb);
                    support_joint(baseplate_coords_thumb);
                }
    }
}