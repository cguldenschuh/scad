// RPi Zero 2 W Base

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

// micro USB Dimensions
uUSB_x = 8.0;
uUSB_y = 3.0;
uUSB_d = 6.0;

// mini HDMI
mHDMI_x = 11.3;
mHDMI_y = 3.8;
mHDMI_d = 7.6;

// micro HDMI
uHDMI_x = 6.6;
uHDMI_y = 3.6;
uHDMI_d = 8.3;

// Micro SD
mSD_x = 12.1;
mSD_y = 1.1;
mSD_d = 11.7;

// Speaker
SPK_x = 7.0;
SPK_y = 6.0;
SPK_z = 11.5;

CSI_x = 2.0;
CSI_y = 16.0;
CSI_d = 4.6;

GPIO_x = 56;
GPIO_y = 8.5;
GPIO_c = 32.5;

// RPI Zero Connector centerpoints
mHDMI_c = 12.4;
uUSB1_c = 41.4;
uUSB2_c = 54.0;     // Power
CSI_c = 15.0;
uSD_c = uSD_x/2 + 7;



// RPI 4 MODEL B SPECIFIC
// NOTE: RJ45 and USB-A jacks overhang board by 3mm
// NOTE: USB-C and miniHDMI overhang board by 1mm
// Y centerline of RJ45
RJ45_c = 45.75;
// Y centerline of 1st USB
USBA1_c = 9.0;
// Y centerline of 2nd USB
USBA2_c = 27.0;
// Centerline for USB-C (power)
USBC_c = 11.2;
// Centerline for HDMI0
HDMI0_c = 26.0;;
// Centerline for HDMI1
HDMI1_c = 39.5;
// Centerline for speaker jack
SPK_c = 55.0;
// Centerline for microSD
mSD_c = 27.5;
// Camera
CSI_c = SPK_c - 7.5;

// Specials for conditional assignments below
TOP_CUTS = (cVentTop * 4) + (cGPIOSlot * 2) + cCameraMount;

include <YAPPgenerator_v3.scad>

pcbLength = 65;
pcbWidth = 30;
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
 [3.5, 27.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBoth, yappPin],
 [61.5, 3.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBoth, yappPin],
 [61.5, 27.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBoth, yappPin]
]
:
[
 [3.5, 3.5, undef, -1, undef, undef, undef, 0, pcbThickness, yappBoth, yappPin],
 [3.5, 27.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBaseOnly, yappPin],
 [61.5, 3.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBoth, yappPin],
 [61.5, 27.5, undef, -1, undef, undef, undef, 0, pcbThickness,  yappBaseOnly, yappPin]
]
;

cutoutsBase = (cVentBase==1) ?
[
 [standoffDiameter+paddingLeft, standoffDiameter+paddingBack, 
  pcbLength-(2*(standoffDiameter+paddingLeft)), pcbWidth-(2*(standoffDiameter+paddingBack)),
  0, yappRectangle, 0, 0, 0, maskHexCircles],
 [-4, mSD_c-(mSD_x/2), 6, mSD_x+1, 0, yappRectangle]   // microSD slot
]
:
[
 [-4, mSD_c-(mSD_x/2), 6, mSD_x+1, 0, yappRectangle]   // microSD slot
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
    [mSD_c-(mSD_x/2), -7, mSD_x+1, 7, 0, yappRectangle, wallThickness+1] // microSD slot
];

cutoutsLeft =   
[
 [ USBC_c-((USBC_x+1)/2), 0, USBC_x+1, USBC_y, 2, yappRoundedRect],   // USB-C Power
 [ HDMI0_c-((mHDMI_x+1)/2), 0, mHDMI_x+1, mHDMI_y, 2, yappRoundedRect], 
 [ HDMI1_c-((mHDMI_x+1)/2), 0, mHDMI_x+1, mHDMI_y, 2, yappRoundedRect], 
];

echo(str("TOP_CUTS == ", TOP_CUTS));
