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
        cylinder(h=flange_thickness + 1, d=hole_d); // +1 para asegurarse perforación
    }
}

translate([0, 0, -5])
difference() {
    mounting_flange();
    // Agujeros incluidos dentro del módulo
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
    translate([body_d / 2 + 5 + 10, 0, body_h - 12])
        rotate([0, 90, 0])
        cylinder(h=15, d=6);
}

module base_plate() {
    translate([-40, -40, -10])
        cube([80, 80, 10]);
}

module deLaval_nozzle() {
    difference() {
        rotate_extrude(angle = 360)
            polygon(points = [
                [0, 0], [2, 5], [1.2, 10], [1.5, 15], [0.8, 25], [0.5, 35], [1, 40], [1.5, 50], [3, 60]
            ]);
        translate([0, 0, -1])
            cylinder(r = 0.2, h = 70, center = true);
    }
}

module fuel_injectors(count = 8, radius = 4) {
    for (i = [0:count - 1]) {
        rotate([0, 0, 360 * i / count])
            translate([radius, 0, 0])
                cylinder(h = 1, r = 0.2);
    }
}

module combustion_chamber() {
    cylinder(h = 10, r1 = 1.5, r2 = 2.5);
}

module cooling_channels(turns = 8, height = 20) {
    for (i = [0:turns - 1]) {
        rotate([0, 0, i * 360 / turns])
            translate([1.5, 0, i * height / turns])
                cylinder(h = 1, r = 0.05);
    }
}

module turbopump() {
    translate([0, 0, 10])
        cylinder(h = 5, r = 1.2);
}

module fuel_tank() {
    union() {
        translate([0, 0, 60])
            sphere(r = 4);
        translate([0, 0, 56])
            cylinder(h = 8, r = 4);
    }
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

    // Componentes mecánicos adicionales
    visual_bolts();
    valve_box();
    input_pipe();
    base_plate();
}

