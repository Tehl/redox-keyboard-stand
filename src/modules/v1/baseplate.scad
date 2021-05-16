// hull of contact points between the stand and floor plane
module baseplate_projection(slice_z) {
    union() {
        hull() {
            // project main body
            projection(cut = true)
                translate([0, 0, -slice_z])
                    keyboard_stand(4, 0);
            
            // fix for top left corner projection differing by slice_z
            translate([
                plate_wall_thickness / 2,
                plate_total_height - plate_wall_thickness,
                0
            ])
                circle(plate_wall_thickness, $fn = render_fragments);
            
            // fix for bottom left corner projection differing by slice_z
            translate([
                plate_wall_thickness / 2,
                plate_total_height - plate_main_height + plate_wall_thickness,
                0
            ])
                circle(plate_wall_thickness, $fn = render_fragments);
        }

        hull()
            // project thumb plate
            projection(cut = true)
                translate([0, 0, -slice_z])
                    keyboard_stand(0, 4);
    }
}