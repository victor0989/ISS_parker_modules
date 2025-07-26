// Conversión de pulgadas a mm
inch = 25.4;
clearance = 0.5;

// Parámetros principales del cuerpo
body_h = 100;
body_d = 50;
body_c = 25;
chamfer = 6;
chamfer_d = body_d - 2 * chamfer;
grip_h = (body_h - 4 * chamfer - body_c) / 2;
axle_d = 13;

// Parámetros del cono
throat_d = 10;
area_ratio = 30;
exit_d = throat_d * sqrt(area_ratio);
nozzle_length = 50;

// Inyectores
num_injectors = 8;
injector_d = 3;
injector_h = 5;
injector_radius = body_d / 2 + 2;

// --------------------- Módulos ---------------------

module body() {
    // Parte inferior
    cylinder(h=chamfer, d1=body_d - 2 * chamfer, d2=body_d);
    translate([0, 0, chamfer])
        cylinder(h=grip_h, d=body_d);
    translate([0, 0, chamfer + grip_h])
        cylinder(h=chamfer, d1=body_d, d2=chamfer_d);

    // Parte central
    translate([0, 0, chamfer * 2 + grip_h])
        cylinder(h=body_c, d=chamfer_d);

    // Parte superior
    translate([0, 0, chamfer * 2 + grip_h + body_c])
        cylinder(h=chamfer, d1=chamfer_d, d2=body_d);
    translate([0, 0, chamfer * 3 + grip_h + body_c])
        cylinder(h=grip_h, d=body_d);
    translate([0, 0, chamfer * 3 + grip_h * 2 + body_c])
        cylinder(h=chamfer, d1=body_d, d2=chamfer_d);
}

module nozzle_cone() {
    translate([0, 0, -nozzle_length])
        cylinder(h=nozzle_length, d1=throat_d, d2=exit_d);
}

module injectors(n = num_injectors) {
    for (i = [0:n-1]) {
        angle = 360 / n * i;
        rotate([0, 0, angle])
            translate([injector_radius, 0, body_h - injector_h])
                cylinder(h=injector_h, d=injector_d);
    }
}

module mounting_flange() {
    flange_thickness = 5;
    flange_diameter = body_d + 20;
    hole_d = 4;
    num_holes = 6;
    hole_radius = (flange_diameter - 10) / 2;

    // Disco base
    cylinder(h=flange_thickness, d=flange_diameter);

    // Agujeros
    for (i = [0:num_holes - 1]) {
        angle = 360 / num_holes * i;
        rotate([0, 0, angle])
            translate([hole_radius, 0, 0])
                cylinder(h=flange_thickness + 1, d=hole_d);
    }
}

module visual_bolts(n = 6) {
    bolt_d = 3;
    bolt_h = 4;
    radius = (body_d + 10) / 2;

    for (i = [0:n-1]) {
        angle = 360 / n * i;
        rotate([0, 0, angle])
            translate([radius, 0, -bolt_h])
                cylinder(h=bolt_h, d=bolt_d);
    }
}

module valve_box() {
    box_w = 20;
    box_h = 15;
    box_d = 10;
    translate([body_d / 2 + 5, -box_w / 2, body_h - 20])
        cube([box_d, box_w, box_h]);
}

module input_pipe() {
    translate([body_d / 2 + 15, 0, body_h - 12])
        rotate([0, 90, 0])
        cylinder(h=15, d=6);
}

// Tubo extra visual
module external_tube(length = 30) {
    rotate([0, 90, 0])
        translate([-length / 2, 0, body_h - 30])
            cylinder(h=length, d=4);
}

// Canales visuales laterales
module ribbed_sides() {
    for (z = [10:15:body_h - 10]) {
        translate([0, 0, z])
            cylinder(h=1, d=body_d + 4);
    }
}

// Soporte exterior
module strut() {
    rotate([0, 0, 45])
        translate([body_d / 2 + 5, 0, 10])
            cube([3, 3, 40]);
}

// Placa base
module base_plate() {
    translate([-40, -40, -10])
        cube([80, 80, 10]);
}

// --------------------- Ensamblaje ---------------------

union() {
    // Cuerpo y cono + perforaciones
    difference() {
        union() {
            body();
            nozzle_cone();
        }
        // Eje central
        cylinder(h=body_h + nozzle_length, d=axle_d);
        // Inyectores
        injectors();
    }

    // Detalles visuales extra
    visual_bolts();
    valve_box();
    input_pipe();
    external_tube();
    ribbed_sides();
    strut();
    base_plate();
}
