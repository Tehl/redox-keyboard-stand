// 3d extrusion of the projected hull; produces a hollow rim which contains all the strut contact points
module baseplate_rim() {
    step = baseplate_depth / baseplate_fragments;

    difference () {
        // step the baseplate up in layers so that it
        // follows the angle of the struts.
        for (i = [0:baseplate_fragments - 1]) {    
            thisStep = step * i;
            
            translate([0, 0, thisStep]) {
                linear_extrude(step)
                    baseplate_projection(max(thisStep, 0.01));
            }
        }
        
        // inset the smallest layer as a cutout
        // to save plastic
        translate([0, 0, -0.5])
            linear_extrude(baseplate_depth + 1)
                offset(r = -strut_size - 1)
                    baseplate_projection(baseplate_depth);
    }
}

// fills the hollow rim with an open hex grid for structural support
module baseplate_hex() {
    intersection() {
        translate([0, 0, -0.5])
            linear_extrude(baseplate_depth + 1)
                offset(r = -strut_size - 1)
                    baseplate_projection(baseplate_depth);             

        translate([-5,0,0])    
            hex_grid(baseplate_depth);
    }
}

// rigid support for the angled keyboard stand and struts
module baseplate() {
    union() {
        baseplate_rim();        
        baseplate_hex();
    }
}