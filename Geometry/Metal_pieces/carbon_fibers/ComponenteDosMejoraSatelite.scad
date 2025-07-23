module TrucRond(rayon=30, numberModules=9)
{
    union()  {
        rotate_extrude(convexity = 10, $fn=quality)
            translate([rayon, 0, 0])
                // cube(3);
                square(3, center=true);
                // circle(2);

        RotateStuff(radius=rayon, number=numberModules)
            rotate([90,0,0])
                cylinder(h = 8, r = 2.5, center = true, $fn = 10);

        RotateStuff(radius=rayon, number=4)
            rotate([90, [0,-1,0]])  // corregido paréntesis
                cylinder(h = rayon, r = 1.5, $fn = 7);

        rayonCentre = 8;
        rayonBord = 5;

        translate([0,0,-3])
            cylinder(h = 6, r2 = rayonCentre, r1 = rayonBord, center = true, $fn = 10);

        translate([0,0,3])
            cylinder(h = 6, r2 = 7, r1 = 9, center = true, $fn = 10);
    }
}

longueurVaisseau = 30;

rotate([90,0,0]) {
    translate([0,0,-(longueurVaisseau/2)])
        TrucRond();

    translate([0, 0, longueurVaisseau/2])
        TrucRond();

    // rotate([90,36,0])
    // cylinder(h = Vaisseau + 8, r = 3, center = true); // Vaisseau no está definido

    translate([0, 0, longueurVaisseau/2]);
}


