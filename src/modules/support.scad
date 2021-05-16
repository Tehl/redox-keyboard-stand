module support_strut(pointFrom, pointTo, radius = 1) {
    localPointTo = [
        pointTo.x - pointFrom.x,
        pointTo.y - pointFrom.y,
        pointTo.z - pointFrom.z
    ];
    
    length = norm(localPointTo);
    b = acos(localPointTo.z / length);
    c = atan2(localPointTo.y, localPointTo.x);

    translate(pointFrom)
        rotate([0, b, c])
            cylinder(
                h = length,
                r = radius,
                center = false,
                $fn = render_fragments
            );
}