// RPi 3 Base   YAPP_RPi3_base.scad
//
// Copyright (C) 2025 Charles P Guldenschuh
// All rights reserved.
//
/* [Hidden] */
// Board Component Sizes - DO NOT CHANGE
// MUST BE DEFINED BEFORE INCLUDING YAPP_Generator
// NOTE: These dimensions are labeled for use with YAPPgenerator.  They
//       would normally be _w, _h, and _l (width, height, length)

include <components.scad>

// RPI 3 MODEL B SPECIFIC
// NOTE: RJ45 and USB-A jacks overhang board by 3mm
// NOTE: USB-C and miniHDMI overhang board by 1mm
// Y centerline of RJ45
RJ45_c = 10.25;
// Y centerline of 1st USB
USBA1_c = 29.0;
// Y centerline of 2nd USB
USBA2_c = 47.0;
// Centerline for USB-C (power)
uUSB_c = 10.6;
// Centerline for HDMI0
HDMI0_c = 32.0;;
// Centerline for speaker jack
SPK_c = 53.5;
// Centerline for microSD
uSD_c = 27.5;
// Camera
CSI_c = 45;

// Specials for conditional assignments below
TOP_CUTS = (cVentTop * 4) + (cGPIOSlot * 2) + cCameraMount;

include <YAPPgenerator_v3.scad>

pcbLength = 85;
pcbWidth = 56;
pcbThickness = 1.6;

standoffHeight      = 4.0; 
standoffDiameter    = 5;
standoffPinDiameter = 2.7*.8;
standoffHoleSlack   = 0.4;

pcb = [
  // Default Main PCB - DO NOT REMOVE the "Main" line.
  ["Main", pcbLength, pcbWidth, 0, 0, pcbThickness, standoffHeight, standoffDiameter, standoffPinDiameter, standoffHoleSlack]
];

pcbStands = ( cGPIOSlot == 0 ) ?
[
 [3.5, 3.5, undef, -1, undef, undef, undef, 0, pcbThickness, yappBoth, yappPin],
 [3.5, 52.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBoth, yappPin],
 [61.5, 3.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBoth, yappPin],
 [61.5, 52.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBoth, yappPin]
]
:
[
 [3.5, 3.5, undef, -1, undef, undef, undef, 0, pcbThickness, yappBoth, yappPin],
 [3.5, 52.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBaseOnly, yappPin],
 [61.5, 3.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBoth, yappPin],
 [61.5, 52.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBaseOnly, yappPin]
]
;

cutoutsBase = (cVentBase==1) ?
[
 [standoffDiameter+paddingLeft, standoffDiameter+paddingBack, 
  pcbLength-(2*(standoffDiameter+paddingLeft)), pcbWidth-(2*(standoffDiameter+paddingBack)),
  0, yappRectangle, 0, 0, 0, maskHexCircles],
 [-4, uSD_c-(uSD_x/2), 6, uSD_x+1, 0, yappRectangle]   // microSD slot
]
:
[
 [-4, uSD_c-(uSD_x/2), 6, uSD_x+1, 0, yappRectangle]   // microSD slot
]
;

cutoutsLid = (TOP_CUTS == 7) ?
[
 [ standoffDiameter+paddingLeft, pcbWidth/2 - 30/2, 
  30, 30, 0, yappRectangle, 0, 0, 0, maskHexCircles ],
  [4.5, pcbWidth-GPIO_y+1, GPIO_x, GPIO_y, 0, yappRectangle],
  [CSI_c-(CSI_x/2), 0, CSI_x, CSI_y, 0, yappRectangle],
  [cMNT_x, cMNT_y, 0, 0, cMNT_d, yappCircle]
]
: (TOP_CUTS == 6) ?
[
 [ standoffDiameter+paddingLeft, pcbWidth/2 - 30/2, 
  30, 30, 0, yappRectangle, 0, 0, 0, maskHexCircles ],
  [4.5, pcbWidth-GPIO_y+1, GPIO_x, GPIO_y, 0, yappRectangle],
]
: (TOP_CUTS == 5) ?
[
 [ standoffDiameter+paddingLeft, pcbWidth/2 - 30/2, 
  30, 30, 0, yappRectangle, 0, 0, 0, maskHexCircles ],
  [CSI_c-(CSI_x/2), 0, CSI_x, CSI_y, 0, yappRectangle],
  [cMNT_x, cMNT_y, 0, 0, cMNT_d, yappCircle]
]
: (TOP_CUTS == 4) ?
[
 [ standoffDiameter+paddingLeft, pcbWidth/2 - 30/2, 
  30, 30, 0, yappRectangle, 0, 0, 0, maskHexCircles ],
]
: (TOP_CUTS == 3) ?
[
  [4.5, pcbWidth-GPIO_y+1, GPIO_x, GPIO_y, 0, yappRectangle],
  [CSI_c-(CSI_x/2), 0, CSI_x, CSI_y, 0, yappRectangle],
  [cMNT_x, cMNT_y, 0, 0, cMNT_d, yappCircle]
]
: (TOP_CUTS == 2) ?
[
  [4.5, pcbWidth-GPIO_y+1, GPIO_x, GPIO_y, 0, yappRectangle],
]
: (TOP_CUTS == 1) ?
[
  [CSI_c-(CSI_x/2), 0, CSI_x, CSI_y, 0, yappRectangle],
  [cMNT_x, cMNT_y, 0, 0, cMNT_d, yappCircle]
]
:
[];

cutoutsFront = [
 [RJ45_c-(RJ45_x/2), 0, RJ45_x, RJ45_y, 0, yappRectangle],   // Ethernet
 [USBA1_c-(USBA_x/2)-.25, 0, USBA_x+.5, USBA_y+1, 0, yappRectangle],  // USB-A
 [USBA2_c-(USBA_x/2)-.25, 0, USBA_x+.5, USBA_y+.5, 0, yappRectangle],  // USB-A
];

cutoutsBack = [
    [uSD_c-(uSD_x/2), -7, uSD_x+1, 7, 0, yappRectangle, wallThickness+1] // microSD slot
];

cutoutsLeft =   
[
 [ uUSB_c-((uUSB_x+1)/2)-4, -2, SPK_c+(SPK_x/2), 11, 4, yappRoundedRect, wallThickness/2], // Inset
 [ uUSB_c-((uUSB_x+1)/2), 0, uUSB_x+1, uUSB_y, 2, yappRoundedRect],   // uUSB Power
 [ HDMI0_c-((HDMI_x+1)/2), 0, HDMI_x+1, HDMI_y, 2, yappRoundedRect], 
 [ SPK_c-((SPK_x+1)/2), 0, SPK_x+1, SPK_y, 3.5, yappCircle]
];
