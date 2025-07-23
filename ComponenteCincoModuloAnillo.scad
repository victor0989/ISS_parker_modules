quality = 40;

// --- Módulo principal: TrucRond ---
module TrucRond(rayon=20) {
    union() {
        // Cuerpo circular con extrusión rotacional
        rotate_extrude(convexity = 10, $fn = quality / 2)
            translate([rayon, 0, 0])
                circle(3);

        // Cilindros distribuidos alrededor del centro
        RotateStuff(radius = rayon, number = 5)
            rotate([90, 0, 0])
                cylinder(h = 12, r1 = 6, r2 = 6, center = true, $fn = quality / 2);
    }
}

// --- Módulo para rotar elementos alrededor de un círculo ---
module RotateStuff(radius=20, number=5) {
    for (azimut = [0:360/number:359])
        rotate([0, 0, azimut])
            translate([radius, 0, 0])
                children();
}

// --- Ejecuciones ---
rotate([90, 0, 0])
    TrucRond();

translate([0, 30, 0])
    rotate([90, 0, 0])
        TrucRond();

// Ejemplo extra: distribuir cubos
RotateStuff(radius = 20, number = 5)
    cube([8, 12, 8], center = true);



