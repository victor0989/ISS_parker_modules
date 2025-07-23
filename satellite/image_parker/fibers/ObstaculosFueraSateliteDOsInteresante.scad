module polygonMoche() {
    polygon(points = [
        [0,0],
        [8,10],
        [20,10],
        [28,0],
        [20,-10],
        [8,-10]
    ]);
}

module blocDoubleMoteurs() {
    union() {
        difference() {
            linear_extrude(height=7, center=true)
                polygonMoche();

            scale([0.95,0.95,1])
            linear_extrude(height=13, scale=0.2)
                polygonMoche();

            //translate([0,0,-11])
            //cylinder()

            translate([0,0,-28])
                cylinder(h=18, r=4, $fn=7);

            translate([0,0,-36])
                cylinder(h=10, r2=4, r1=7, $fn=7);
        }
    }
}

rotate([0,90,0]) {
    blocDoubleMoteurs();
    translate([0,20,0])
        blocDoubleMoteurs();
    translate([0,-20,0])
        blocDoubleMoteurs();
}

translate([-36,0,0])
scale([1,1.9,1.1])
linear_extrude(height=18, scale=1.5)
    polygonTresMoche();

translate([-80,2,0])
    cube([20,20,20]);

translate([-80,35,-6])
    cube([10,10,10]);

module triangleMoche() {
    polygon(points = [
        [0,0],
        [-10,12],
        [10,12]
    ]);
}

rotate([-90,0,0])
    triangleMoche();

module formeCentreMoche() {
    union() {
        triangleMoche();

        scale([0.9,0.8,1])
        translate([0,15,0])
            triangleMoche();
    }
}

module centreMoche() {
    translate([0,0,12])
    rotate([-90,0,0])
    linear_extrude(height=21)
        formeCentreMoche();
}

nbModules = 16;
largeurModule = 25;

for (i = [0 : nbModules - 1]) {
    translate([0, i * largeurModule, 0])
        centreMoche();
}

rotate([-90,0,0])
    cylinder(h = nbModules * largeurModule, r=4, $fn=8);

translate([0,0,3.9])
rotate([-90,22.5,0])
cylinder(h = nbModules * largeurModule, r=6, $fn=8);

translate([0,-30,0])
    sphere(r=35, $fn=15);

// Esfera a añadir
module trucPlat() {
    scale([0.2,1,1])
        sphere(r=30, $fn=16);
}

difference() {
    trucPlat();

    scale([0.2,1,1])
        //translate([-1,0,0])
        sphere(r=30, $fn=16);
}











