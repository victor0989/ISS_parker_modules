// Execute
DownAdapter(101, 24, 2, 30, 48, 5, true);

// Modules
module DownAdapter(base_dia_ID, base_h, wall, cone_h, tail_dia_OD, tail_h, center_flag) {
    difference() {
        union() {  // create base structure
            // create base
            translate([0, 0, base_h / 2])
                cylinder(h = base_h, r1 = (base_dia_ID / 2) + wall, r2 = (base_dia_ID / 2) + wall, $fn = 60, center = center_flag);

            // create tail
            translate([0, 0, base_h + (cone_h / 2)])
                cylinder(h = cone_h, r1 = (base_dia_ID / 2) + wall, r2 = tail_dia_OD / 2, $fn = 60, center = center_flag);
        } // end union

        // start subtraction of difference
        // remove base inside
        translate([0, 0, (base_h / 2) - 0.5])
            cylinder(h = base_h + 1, r = base_dia_ID / 2, $fn = 60, center = center_flag);

        // remove cone inside
        translate([0, 0, base_h + (cone_h / 2) + 0.25])
            cylinder(h = cone_h + 1, r1 = base_dia_ID / 2, r2 = (tail_dia_OD / 2) - wall, $fn = 60, center = center_flag);

        // remove tail inside
        translate([0, 0, base_h + cone_h + (tail_h / 2) + 0.5])
            cylinder(h = tail_h + 1, r = (tail_dia_OD / 2) - wall, $fn = 60, center = center_flag);
    } // end difference
} // end module












