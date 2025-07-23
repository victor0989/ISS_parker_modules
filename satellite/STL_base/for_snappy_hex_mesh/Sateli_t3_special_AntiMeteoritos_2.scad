$fn = 100;
quality = 20;

// ---------- Módulos básicos ----------

module polygonMoche() {
    translate([-14, 0, 0])
        polygon(points = [
            [0, 0], [8, 10], [20, 10], [28, 0], [20, -10], [8, -10]
        ]);
}

module polygonTresMoche() {
    polygon(points = [
        [10, -40], [15, -35], [15, 35], [10, 40],
        [-10, 30], [-15, 15], [-15, -15], [-10, -20]
    ]);
}

module moteurMoche() {
    difference() {
        cylinder(h = 5, r1 = 5, r2 = 6);
        translate([0, 0, 1])
            scale([0.95, 0.95, 1.2])
                cylinder(h = 5, r1 = 5, r2 = 6);
    }
}

module SpaceCup() {
    union() {
        cylinder(h = 45, r1 = 36/2, r2 = 43/2);
        translate([0, 0, 39])
            cylinder(h = 6, r1 = 45.2/2, r2 = 45.5/2);
        translate([0, 0, 44])
            cylinder(h = 1.5, r = 50.8/2);
    }
}

module RotateStuff(radius = 20, number = 5) {
    for (azimut = [0 : 360 / number : 359])
        rotate([0, 0, azimut])
            translate([radius, 0, 0])
                children();
}

module TrucRond(rayon = 30, numberModules = 4) {
    union() {
        rotate_extrude(convexity = 10, $fn = quality)
            translate([rayon, 0, 0])
                square([3, 3], center = true);
        RotateStuff(radius = rayon, number = numberModules)
            rotate([90, 0, 0])
                cylinder(h = 8, r = 2.5, center = true, $fn = 10);
        rotate([0, -90, 0])
            cylinder(h = rayon, r = 1.5, $fn = 7);
        translate([0, 0, -3])
            cylinder(h = 6, r1 = 7, r2 = 9, center = true, $fn = 10);
        translate([0, 0, 3])
            cylinder(h = 6, r1 = 9, r2 = 7, center = true, $fn = 10);
    }
}

module blocDoubleMoteurs() {
    echelleMoteur = 0.7;
    union() {
        difference() {
            linear_extrude(height = 7, center = true)
                polygonMoche();
            translate([0, 0, 3])
                scale([0.95, 0.95, 1])
                    linear_extrude(height = 7, center = true)
                        polygonMoche();
        }
        scale([echelleMoteur, echelleMoteur, 1])
            translate([7.6, 0, -1])
                moteurMoche();
        scale([echelleMoteur, echelleMoteur, 1])
            translate([-7.6, 0, -1])
                moteurMoche();
        linear_extrude(height = 20, scale = 0.2)
            polygonMoche();
        translate([0, 0, -28])
            cylinder(h = 18, r = 4, $fn = 7);
        translate([0, 0, -36])
            cylinder(h = 10, r1 = 7, r2 = 4, $fn = 7);
    }
}

// Ensamblaje motores
rotate([0, 90, 0]) {
    blocDoubleMoteurs();
    translate([0, -20, 0])
        blocDoubleMoteurs();
}
translate([-36, 0, 0])
    rotate([90, 0, 90])
        linear_extrude(height = 18, scale = 1.5)
            polygonTresMoche();
translate([-80, 2, 0]) cube([20, 20, 20]);
translate([-80, 35, -6]) cube([10, 10, 10]);

// Estructura triangular central
module triangleMoche() {
    polygon(points = [[0, 0], [-10, 12], [10, 12]]);
}
module formeCentreMoche() {
    union() {
        triangleMoche();
        translate([0, 15, 0])
            scale([0.9, 0.8, 1])
                triangleMoche();
    }
}
module centreMoche() {
    translate([0, 0, 12])
        rotate([-90, 0, 0])
            linear_extrude(height = 21)
                formeCentreMoche();
}

// Columna de módulos
nbModules = 16;
largeurModule = 25;
for (i = [0 : nbModules - 1])
    translate([0, i * largeurModule, 0])
        centreMoche();
rotate([-90, 0, 0])
    cylinder(h = nbModules * largeurModule, r = 4, $fn = 8);
translate([0, 0, 3.9])
    rotate([-90, 22.5, 0])
        cylinder(h = nbModules * largeurModule, r = 6, $fn = 8);

// Módulo esfera
translate([0, -30, 0]) sphere(r = 35, $fn = 15);

// Antenas parabólicas
module trucPlat() {
    scale([0.2, 1, 1]) sphere(r = 30, $fn = 16);
}
module parabole() {
    union() {
        translate([-4, 0, 0]) cube([18, 0.8, 0.8], center = true);
        sphere(r = 1.4, $fn = 16);
        difference() {
            trucPlat();
            translate([-1, 0, 0]) scale([1, 0.95, 0.95]) trucPlat();
            translate([-60, 0, 0]) cube([120, 120, 120], center = true);
        }
    }
}
parabole();
translate([0, 38.2, -17]) scale(0.41) parabole();
translate([0, -38.2, -17]) scale(0.41) parabole();
translate([1.2, 0, -17]) scale(0.41) parabole();
translate([1.2, 0, -17])
    scale([0.4, 1, 1])
    difference() {
        rotate_extrude(convexity = 10, $fn = 7)
            translate([40, 0, 0]) circle(3);
        translate([-43, 0, 0]) cube([90, 90, 90], center = true);
    }
rotate([0, 95, 0]) cylinder(h = 12, r1 = 12, r2 = 4, $fn = 8);
translate([16, 0, -15]) cylinder(h = 10, r1 = 6, r2 = 4, $fn = 8);

// Nave principal detallada
module nave_principal() {
    color("steelblue") translate([0, 0, 20]) cylinder(h = 40, r = 10);
    for (z = [25, 30, 35])
        color("dimgray") translate([0, 0, z]) torus(10.5, 0.6);
    color("saddlebrown") translate([13, 0, 30]) cylinder(h = 10, r = 2.5, center = true);
    translate([-13, 0, 20]) cube([5, 3, 8], center = true);
    color("skyblue", 0.6) translate([0, 0, 60]) scale([1.2, 1.2, 0.6]) sphere(r = 10);
    color("gray") rotate([180, 0, 0]) cylinder(h = 10, r1 = 12, r2 = 3);
    for (a = [0 : 120 : 360])
        rotate([0, 0, a]) translate([15, 0, 20]) color("lightgray", 0.6) cube([0.5, 5, 6], center = true);
}
nave_principal();

// ---------- Estación espacial ISS-like ----------
color_yellow = [1, 1, 0];
color_black = [0, 0, 0];

module spine(len=120, rad=4) {
    color(color_black) cylinder(h=len, r=rad, center=true);
}

module module_cylinder(pos=[0,0,0], r=6, h=20) {
    translate(pos) color(color_yellow) cylinder(h=h, r=r, center=true);
}

module solar_panel(size=[60, 2, 0.5], offset=[0, 15, 0]) {
    translate(offset) color(color_black) cube(size, center=true);
}

module cross_frame(size=40) {
    color(color_black) union() {
        rotate([0,0,45]) cube([size, 1, 1], center=true);
        rotate([0,0,-45]) cube([size, 1, 1], center=true);
    }
}

module yellow_container(size=[20, 15, 10]) {
    color(color_yellow) cube(size, center=true);
    color("black") translate([size[0]/2 + 1, 0, 0]) rotate([0, 90, 0]) cylinder(h=6, r=1.5, $fn=30);
}

module hex_dome(radius=20, height=10) {
    color("lightgray")
        linear_extrude(height=height, scale=0.1)
            offset(r=0.5)
                polygon(points=[for (a = [0 : 60 : 300]) [cos(a), sin(a)] * radius]);
}

module ISS_style_station() {
    spine();
    for (z = [-40, 0, 40]) module_cylinder([0, 0, z]);
    solar_panel(offset=[0, 20, 40]);
    solar_panel(offset=[0, -20, -40]);
    mirror([0,1,0]) solar_panel(offset=[0, 20, 40]);
    mirror([0,1,0]) solar_panel(offset=[0, -20, -40]);
    cross_frame();
}

// ---------- Módulos Sci-Fi de defensa y estructura ----------

module turret_defense(pos=[0,0,0]) {
    translate(pos)
    union() {
        color("DimGray") cylinder(h=3, r=5, $fn=60);
        color("SlateGray") translate([0,0,3]) cylinder(h=4, r=3, $fn=40);
        for (x=[-1.5, 1.5])
            translate([x, 3.5, 6]) color("Black") cube([0.6, 6, 0.6], center=true);
    }
}

module reinforced_spine(length=80) {
    for (i=[0:length:5])
        translate([0, 0, i])
            rotate([90,0,0])
            color("DarkSlateGray")
            hull() {
                translate([-6,-1,0]) cube([1,2,1]);
                translate([6,-1,0])  cube([1,2,1]);
            }
}

module alien_antenna(pos=[0,0,0], scaleF=1) {
    translate(pos)
    scale([scaleF, scaleF, scaleF])
    color("MediumPurple")
    polyhedron(
        points=[
            [0,0,0],
            [10,0,0],
            [5,10,0],
            [5,5,15]
        ],
        faces=[
            [0,1,2],
            [0,1,3],
            [1,2,3],
            [2,0,3]
        ]
    );
}

// ---------- Inserción de módulos de defensa ----------

// Torretas de defensa antimetorito
turret_defense([30, -40, 0]);
turret_defense([-30, -40, 0]);
turret_defense([30, 40, 0]);
turret_defense([-30, 40, 0]);

// Columna estructural reforzada bajo la estación ISS
translate([0, 0, -120]) reinforced_spine(100);

// Antenas alienígenas
alien_antenna([60, 60, 30], 0.6);
alien_antenna([-60, -60, 30], 0.6);

module drone(pos=[0,0,0], size=4) {
    translate(pos)
    union() {
        color("LightSlateGray") sphere(r=size, $fn=40);
        color("SteelBlue") for (i=[-1,1]) rotate([0,0,45*i])
            translate([size+1,0,0])
            cylinder(h=0.6, r=1.2, $fn=30);
    }
}

// Posicionar drones cercanos a la estación
drone([15, 15, 25]);
drone([-20, 10, 28]);
drone([10, -25, 22]);

module escape_pod(pos=[0,0,0]) {
    translate(pos)
    union() {
        color("FireBrick") hull() {
            translate([-2,-2,0]) cube([4,4,4]);
            translate([0,0,6]) sphere(r=2, $fn=40);
        }
        translate([0,0,0]) color("Black") cylinder(h=1, r=1.5, $fn=30);
    }
}

// Añadir dos cápsulas de evacuación
escape_pod([40, -10, 10]);
escape_pod([-40, 10, 10]);

module rotating_radar(pos=[0,0,0]) {
    translate(pos)
    union() {
        color("DimGray") cylinder(h=1.5, r=3.5, $fn=40);
        color("Silver") translate([0,0,1.5]) cube([1, 8, 0.5], center=true);
        color("OrangeRed") translate([0,0,3.5]) sphere(r=1.3, $fn=30);
    }
}

// Coloca radar sobre una torreta
rotating_radar([30, 40, 7]);



// Ejecutar elementos ISS
ISS_style_station();
translate([60, 0, 0]) yellow_container();
translate([0, 0, -80]) hex_dome(radius=15, height=10);



