Thickness = 4;
Angle = -10;
Insert = -15;
Inches = 6;

// Create a body of cup geometry
RCup_Holder();

// créate base
translate([0, -((25.4 * Inches) / 2) - 2, 0])
    base();

// --- Modules ---
module KCup_Holder_SpaceCraft() {
    difference() {
        union() { // start union
            // base body
            translate([0, 0, 0])
                SpaceCup();
        } // end union

        // start subtraction of difference
        // difference KCups from (ejemplo comentado con # para no ejecutar)
        /*
        translate([((25.4 * Inches) / 2) + 1, -((25.4 * Inches) / 8) - 10, Insert])
            rotate([Angle, 0, 0])
            KCup();

        translate([(25.4 * Inches) / 2 - 55, -((25.4 * Inches) / 6) - 10, Insert])
            rotate([Angle, 0, 0])
            KCup();

        translate([(25.4 * Inches) / 2 - 110, -((25.4 * Inches) / 8) - 10, Insert])
            rotate([Angle, 0, 0])
            KCup();
        */
    } // end difference
} // end module

// Execute
KCup_Holder_SpaceCraft();

translate([150, 0, 0])
kCupSpace();

module kCupSpace() {
    union() { // start union
        // base body
        translate([0, 0, 0])
            rotate([0, 0, 0])
            cylinder(h = 45, r1 = 36 / 2, r2 = 43 / 2, $fn = 100, center = false);

        // top ring
        translate([0, 0, 45 - 6])
            rotate([0, 0, 0])
            cylinder(h = 6, r1 = 45.2 / 2, r2 = 45.5 / 2, $fn = 100, center = false);

        // top lip
        translate([0, 0, 45 - 1])
            rotate([0, 0, 0])
            cylinder(h = 1.5, r1 = 50.8 / 2, r2 = 50.0 / 2, $fn = 100, center = false);
    } // end union
} // end module













