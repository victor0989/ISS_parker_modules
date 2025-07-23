module SpaceCup() {
    difference() {
        union() {
            translate([0, 0, 0])
                rotate([0, 0, 0])
                cylinder(h = 45, r1 = 36 / 2, r2 = 43 / 2, $fn = 60, center = false);

            translate([0, 0, 45 - 6])
                rotate([0, 0, 0])
                cylinder(h = 6, r1 = 45.5 / 2, r2 = 45.5 / 2, $fn = 100, center = false);

            translate([0, 0, 45 - 1])
                rotate([0, 0, 0])
                cylinder(h = 1.5, r1 = 50.8 / 2, r2 = 50.8 / 2, $fn = 100, center = false);
        }

        // Aquí podrías añadir diferencias para detalles internos
    }
}

SpaceCup();













