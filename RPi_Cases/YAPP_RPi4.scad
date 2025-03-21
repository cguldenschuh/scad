// RPi345_case.scad
//
// Copyright (C) 2025 Charles P Guldenschuh
// All rights reserved.
//
//
// This file along with RPi4_base.scad and RPi5_base.scad, provide
// for a customizable RPi3, RPi4, or RPi5 case using yappGenerator V3.
//
// Features currently included are:
// 1. Optional base ventilation
// 2. Optional top ventilation
// 3. Optional top mounted press fit fan mount (30mm or 40mm)
// 4. Optional GPIO pin cutout
// 5. Optional camera mount hole and slot
// 6. Optional snap joins to hold the lid on
// 7. Rounded, chamfered, or squared edges/corners
//
// Usage:
// 1. Uncomment ONE of the "include <YAPP_RPi...>" lines below to
//    select the board you are using.
// 2. Use OpenSCAD to customize your box.
// 3. The size value defaults should be taken as minimums.  You
//    may be able to use smaller values, but they HAVE NOT BEEN TESTED!
//
// Todo:
// o Suppport HATs
// o Support Pimoroni NVMe base board
// o Screw mounts for fans
//
// Explicitly not supported:
// 1. External fan mounts; Requires supports
//
/* [Case Features] */
cGPIOSlot = 0;      // [0:No GPIO pin slot, 1:GPIO pin slot]
cCameraSlot = 0;    // [0:No slot, 1:Camera slot]
cCameraMount = 0;   // [0:No camera mount, 1:Camera mount]
cVentTop = 1;       // [0:No ventalation top, 1:Ventalation top]
cVentBase = 1;      // [0:No ventalation base, 1:Ventalation base]
cSnapJoin = 1;       // [0:No snap join, 1:Snap join]
cFanMount = 0;      // [0:No fan mount, 4:Internal snap]
// 0b1xx = internal, 0bx1x = external, 0bxx0 = snap/press, 0bxx1 = screw

cFanSize = 30;      // [30:30mm, 40:40mm]

//include <YAPP_RPi3_base.scad>
include <YAPP_RPi4_base.scad>
//include <YAPP_RPi5_base.scad>

/* [Print Selection] */
//-- which part(s) do you want to print?
printBaseShell        = true;
printLidShell         = true;
printSwitchExtenders  = true;
printDisplayClips     = true;

/* [Case Settings] */

boxType = 3;        // [0:All edged rounded, 1:All edges square, 2:All edges chamfered, 3:Square t/b rounded corners, 4:Square t/b chamfered corners, 5:Chamfered t/b rounded corners]

//-- padding between pcb and inside wall
paddingFront        = 2.1;
paddingBack         = 1.5;
paddingRight        = 1.5;
paddingLeft         = 1.5;

//-- Edit these parameters for your own box dimensions
wallThickness       = 2.0;
basePlaneThickness  = 2.0;
lidPlaneThickness   = 2.0;

//-- Total height of box = lidPlaneThickness 
//                       + lidWallHeight 
//--                     + baseWallHeight 
//                       + basePlaneThickness
//-- space between pcb and lidPlane :=
//--      (bottonWallHeight+lidWallHeight) - (standoffHeight+pcbThickness)
baseWallHeight      = 18;
lidWallHeight       = 12;

//-- ridge where base and lid of box can overlap
//-- Make sure this isn't less than lidWallHeight
ridgeHeight         = 5.0;
ridgeSlack          = 0.2;
roundRadius         = 3.0;

// Set the layer height of your printer
printerLayerHeight  = 0.2;

snapJoins = (cSnapJoin==1) ?
[ [20, 5, yappLeft, yappRight, yappSymmetric] ]
:
[];

mountx = 2;
mounty = 12;
mountz = 9;
cFan_z = 7.5;

module hookLidInside() {
    if ((cFanMount == 4) || (cFanMount == 5)) {
        translate([standoffDiameter+paddingBack, (pcbWidth-cFanSize)/2+2,
                  -(lidPlaneThickness+mountz-1)]) {
            translate([0, (cFanSize-mounty)/2, 0]) {
                cube([mountx, mounty, mountz+3]);
                translate([mountx, 1, 1]) 
                    sphere(d=2);
            }
            translate([cFanSize+(mountx*1), (cFanSize-mounty)/2, mountz-2]) {
                cube([mountx, mounty, mountz+3]);
                //translate([mountx*0, (mounty-1), 1]) sphere(d=2);
            }
/*
            translate([cFanSize+(mountx*1), (cFanSize-mounty)/2, 0]) {
                #cube([mountx, mounty, mountz+3]);
                translate([mountx*0, (mounty-1), 1]) 
                    sphere(d=2);
            }
*/
            translate([cFanSize/2+mounty/2+mountx, -mountx, 0]) {
                rotate([0, 0, 90]) 
                    cube([mountx, mounty, mountz+3]);
                translate([-1, mountx, 1]) sphere(d=2);
            }
            translate([cFanSize/2+mounty/2+mountx, cFanSize, 0]) {
                rotate([0, 0, 90]) 
                    cube([mountx, mounty, mountz+3]);
                translate([-mounty+1, 0, 1]) sphere(d=2);
            }
        }
    }
}


YAPPgenerate();
