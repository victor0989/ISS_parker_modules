// --- Cohete alienígena y estilizado ---

$fn = 100;

// PUNTA ESTILIZADA (ALARGADA Y FINA)
translate([0,0,75])
color("Purple")
cylinder(h = 8, r1 = 2, r2 = 0.2);

// CUERPO CENTRAL ADELGAZADO Y ALARGADO
color("DarkSlateGray"){
    translate([0,0,67])
    cylinder(h = 10, r1 = 3.5, r2 = 2.5);
    
    translate([0,0,57])
    cylinder(h = 10, r1 = 4, r2 = 3.5);
    
    translate([0,0,45])
    cylinder(h = 12, r1 = 5, r2 = 4.2);

    translate([0,0,30])
    cylinder(h = 15, r1 = 5.5, r2 = 5);

    translate([0,0,15])
    cylinder(h = 15, r1 = 6, r2 = 6);
}

// ZONA MEDIA EXTRATERRESTRE (FORMA ORGÁNICA)
color("Turquoise")
translate([0,0,12])
scale([1.2,1.2,1])
sphere(r=6);

// MÓDULOS NEGROS CIRCULARES (anillos alienígenas)
color("black"){
    for (z = [13, 15, 17])
        translate([0,0,z])
        cylinder(h=0.7, r1=6.5, r2=5.5);
}

// PARTE INFERIOR BRILLANTE
translate([0,0,0])
color("Gold")
cylinder(h = 12, r1 = 6.5, r2 = 4);

// ALETAS LATERALES ESTILIZADAS
color("SlateGray"){
    for(angle = [0:120:360]){
        rotate([0,0,angle])
        translate([6, -0.5, 6])
        cube([1.5, 1, 20]);
    }
}

// DETALLES EXTRATERRESTRES ORGÁNICOS
module alien_core(times, offset){
    translate([offset, offset, offset])
    scale([times, times, 1/times])
    intersection(){
        sphere(d = 14);
        cube(size = 10, center = true);
    }
}

alien_core(0.6, 10);

// BASE GEOMÉTRICA SIMÉTRICA (ENERGÍA/PROPULSIÓN)
module ortho(v){
    cube([v[0], v[1], v[2]], center=true);
    cube([v[1], v[2], v[0]], center=true);
    cube([v[2], v[0], v[1]], center=true);
}

translate([0,0,-5]){
    color("DarkRed")
    for(i = [-3:3])
        ortho([20, 0.6, 0.6]);
}

// COLA DEL COHETE (emisor de plasma)
translate([0,0,-12])
color("Blue")
cylinder(h = 6, r1 = 4, r2 = 2, center = false);
