// === Sci-Fi Nave Espacial con Técnicas Avanzadas ===

$fn=64; // Alta resolución

// --- Función de redondeo 3D (fillet) ---
module offset_3d(r=1, size=1000) {
    n = $fn==undef ? 12: $fn;
    if(r==0) children();
    else if (r>0)
        minkowski(convexity=5) {
            children();
            sphere(r, $fn=n);
        }
    else {
        size2 = size*[1,1,1];
        size1 = size2*2;
        difference() {
            cube(size2, center=true);
            minkowski(convexity=5){
                difference(){
                    cube(size1, center=true);
                    children();
                }
                sphere(-r, $fn=n);
            }
        }
    }
}

// --- Línea estilo cable o haz de conexión ---
module line(p0, p1, diameter=0.1) {
    v = p1 - p0;
    translate(p0)
        multmatrix(rotate_from_to([0,0,1], v))
            cylinder(d=diameter, h=norm(v), $fn=20);
}

// --- Módulos mejorados ---

module fuselaje() {
    offset_3d(0.2)
        cylinder(h=6, r=1, center=true);
}

module escudo() {
    intersection() {
        translate([0, 0, 3.2])
            sphere(r=1.1);
        translate([-2.2, -2.2, 2.9])
            cube([4.4, 4.4, 2], center=false);
    }
}

module panel_izq() {
    translate([-2.5, 0, 0])
        scale([1, 2.5, 0.08])
            offset_3d(0.05)
                cube([2, 2, 0.1], center=true);
}

module panel_der() {
    translate([2.5, 0, 0])
        scale([1, 2.5, 0.08])
            offset_3d(0.05)
                cube([2, 2, 0.1], center=true);
}

module motor(x_offset) {
    translate([x_offset, 0, -3.5])
        rotate([180, 0, 0])
            offset_3d(0.1)
                cylinder(h=0.7, r1=0.35, r2=0);
}

module antena() {
    difference() {
        translate([0, 0, 4.1])
            sphere(r=0.55);
        translate([-1, -1, 4.1])
            cube([2, 2, 2], center=false);
    }
    line([0, 0, 4.1], [0, 0, 1.1], 0.05);  // cable hacia fuselaje
}

module soporte_panel(x_offset) {
    translate([x_offset, 0, 0])
        rotate([90, 0, 0])
            cylinder(h=1.7, r=0.06);
}

module cupula() {
    intersection() {
        translate([0, 0, -3.1])
            sphere(r=1.05);
        translate([-2.2, -2.2, -5])
            cube([4.4, 4.4, 2], center=false);
    }
}

// --- Detalle inferior con patrón (estilo propulsión) ---
module base_detallada() {
    for (i = [0 : 45 : 315]) {
        rotate([0, 0, i])
            translate([0.7, 0, -3.4])
                cylinder(h=0.2, r=0.1, center=false);
    }
}

// --- Nave ensamblada tipo sci-fi ---
module nave_sci_fi() {
    union() {
        color("gray") fuselaje();
        color("white") escudo();
        color("black") cupula();
        color("silver") panel_izq();
        color("silver") panel_der();
        color("gray") soporte_panel(-1.6);
        color("gray") soporte_panel(1.6);
        color("firebrick") motor(-0.6);
        color("firebrick") motor(0.6);
        color("orange") base_detallada();
        color("lightblue") antena();
    }
}

// === Render Final ===
nave_sci_fi();
