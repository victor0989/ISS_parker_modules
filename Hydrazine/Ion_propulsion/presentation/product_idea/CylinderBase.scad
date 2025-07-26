$fn = 64;

MOUNT_ID = 26;
POLE_DIAMETER = 20;
HEIGHT = 86;
CUTOUT = 5;

difference() {
    cylinder(d=MOUNT_ID, h=HEIGHT, center=true);
    cylinder(d=POLE_DIAMETER, h=HEIGHT+1, center=true);
    translate([CUTOUT*CUTOUT, 0, 0])
       cube([CUTOUT*4, CUTOUT, HEIGHT+1], center=true);
}

// flag pole
%cylinder(d=19.37, h=HEIGHT*3, center=true);
