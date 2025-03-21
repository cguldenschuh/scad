// RPi 5 Base

/* [Hidden] */
// Board Component Sizes - DO NOT CHANGE
// MUST BE DEFINED BEFORE INCLUDING YAPP_Generator
// NOTE: These dimensions are labeled for use with YAPPgenerator.  They
//       would normally be _w, _h, and _l (width, height, length)
// RJ45 Dimensions
RJ45_x = 16.5;
RJ45_y = 13.5;
RJ45_d = 25.5;

// USB (double) Dimensions
USBA_x = 14.7;
USBA_y = 16.0;
USBA_d = 17.6;

// USB-C Dimensions
USBC_x = 9.1;
USBC_y = 3.2;
USBC_d = 7.4;

// Mini HDMI
mHDMI_x = 6.6;
mHDMI_y = 3.6;
mHDMI_d = 8.3;

// Micro SD
mSD_x = 12.1;
mSD_y = 1.1;
mSD_d = 11.7;

//
// NOTE: RJ45 and USB-A jacks overhang board by 3mm
// NOTE: USB-C and miniHDMI overhang board by 1mm
// Y centerline of RJ45
RJ45_c = 10.2;
// Y centerline of 1st USB
USBA1_c = 29.1;
// Y centerline of 2nd USB
USBA2_c = 47;
// Centerline for USB-C (power)
USBC_c = 11.2;
// Centerline for HDMI0
HDMI0_c = 25.8;
// Centerline for HDMI1
HDMI1_c = 39.2;
// Centerline for microSD
mSD_c = 28;


include <YAPPgenerator_v3.scad>

pcbLength = 85;
pcbWidth = 56;
pcbThickness = 1.6;

standoffHeight      = 4.0; 
standoffDiameter    = 6;
standoffPinDiameter = 2.7*.8;
standoffHoleSlack   = 0.4;

pcb = [
  // Default Main PCB - DO NOT REMOVE the "Main" line.
  ["Main", pcbLength, pcbWidth, 0, 0, pcbThickness, standoffHeight, standoffDiameter, standoffPinDiameter, standoffHoleSlack]
];

pcbStands = [
 [3.5, 3.5, undef, -1, undef, undef, undef, 0, pcbThickness, yappBoth, yappPin],
 [3.5, 52.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBoth, yappPin],
 [61.5, 3.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBoth, yappPin],
 [61.5, 52.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBoth, yappPin]
];

cutoutsBase = [
 [-4, 21.4, 8, 13.1, 0, yappRectangle]   // microSD slot
];

cutoutsLid  = [
 [pcbLength/2, pcbWidth/2, 0, 0, pcbWidth/2-4, yappCircle, 0, 0, 0, maskHoneycomb, yappCenter, yappCoordPCB]
];

cutoutsFront = [
 [RJ45_c-(RJ45_x/2), pcbThickness, RJ45_x, RJ45_y, 0, yappRectangle],   // Ethernet
 [USBA1_c-(USBA_x/2)-.25, pcbThickness, USBA_x+.5, USBA_y+1, 0, yappRectangle],  // USB-A
 [USBA2_c-(USBA_x/2)-.25, pcbThickness, USBA_x+.5, USBA_y+.5, 0, yappRectangle],  // USB-A
];

cutoutsBack = [
    [12.3, 1+pcbThickness, 0, 0, 1, yappCircle],           // LED
    [17.4, 1+pcbThickness, 0, 0, 1, yappCircle],           // Switch
    [21.4, -7, 13.1, 7, 0, yappRectangle, wallThickness+1] // microSD slot
];

cutoutsLeft =   
[
 [ USBC_c-((USBC_x+1)/2)-4, -1, 44.85, 8, 4, yappRoundedRect, wallThickness/2], // Inset
 [ USBC_c-((USBC_x+1)/2), pcbThickness, USBC_x+1, USBC_y, 2, yappRoundedRect],   // USB-C Power
 [ HDMI0_c-((mHDMI_x+1)/2), pcbThickness, mHDMI_x+1, mHDMI_y, 2, yappRoundedRect], 
 [ HDMI1_c-((mHDMI_x+1)/2), pcbThickness, mHDMI_x+1, mHDMI_y, 2, yappRoundedRect], 
];
