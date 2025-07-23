// Spacecraft components
echo_base = 84.8; // [84:0.1:86]
// Amount of Area for Wire Storage in Base (mm)
wire_storage = 20;
// Wall Thickness (mm)
Wall = 3;
// Resolution of circles
sides = 150; //[60:5:100]
// Number of rocket or solar Parker fins
fin_count = 4; //[2:1:12]

// Execute
echo_base_module();

// Modules
module echo_base_module() {
    difference() {
        union() { // start union
            // Aquí podrías poner la geometría base principal si tienes alguna
            // Por ejemplo un cilindro base
            cylinder(h = 22 + Wall, r = echo_base / 2, $fn = sides, center = true);

            // Ejemplo para crear las aletas con un for
            for (i = [0 : 360 / fin_count : 359]) {
                rotate([0, 0, i])
                translate([echo_base / 2, 0, 0])
                fin();
            }
        } // end union

        // start subtraction of difference
        // Remove Echo base interior (hueco)
        translate([0, 0, Wall])
            cylinder(h = 22 + Wall, r = echo_base / 2 - Wall, $fn = sides, center = true);

        // Removing ring area for wire storage
        translate([0, 0, -2])
            ring();

        // Remove keyhole 1 to allow plug passage
        translate([
            (echo_base / 2) * cos(45),
            (echo_base / 2) * sin(45),
            0
        ])
            rotate([-45, 90, 0])
            keyhole(10, 15, Wall * 2);

        // Remove keyhole 2
        translate([
            ((echo_base + wire_storage) / 2) * cos(45),
            ((echo_base + wire_storage) / 2) * sin(45),
            -5
        ])
            rotate([-45, 90, 0])
            keyhole(6, 9, Wall * 2);
    }
}

// Ejemplo módulo fin
module fin() {
    // Una aleta sencilla como un cubo pequeño, por ejemplo
    cube([5, 1, 10], center = true);
}

// Ejemplo módulo ring (puedes ajustar a lo que necesites)
module ring() {
    difference() {
        cylinder(h = 5, r1 = (echo_base + wire_storage) / 2, r2 = (echo_base + wire_storage) / 2 - Wall, $fn = sides, center = true);
        cylinder(h = 5, r1 = (echo_base + wire_storage) / 2 - Wall * 1.5, r2 = (echo_base + wire_storage) / 2 - Wall * 1.5, $fn = sides, center = true);
    }
}

// Ejemplo módulo keyhole (













