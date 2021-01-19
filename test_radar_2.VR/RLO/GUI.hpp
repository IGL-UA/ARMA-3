#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_HITZONES         17
#define CT_VEHICLETOGGLES   18
#define CT_CONTROLS_TABLE   19
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_MENU             46
#define CT_MENU_STRIP       47
#define CT_CHECKBOX         77
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define CT_ITEMSLOT         103
#define CT_LISTNBOX_CHECKABLE 104
#define CT_VEHICLE_DIRECTION 105

#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0
#define ST_UPPERCASE      0xC0
#define ST_LOWERCASE      0xD0
#define ST_ADDITIONAL_INFO    0x0F00
#define ST_SHADOW             0x0100
#define ST_NO_RECT            0x0200
#define ST_KEEP_ASPECT_RATIO  0x0800
#define ST_TITLE          ST_TITLE_BAR + ST_CENTER
#define SL_VERT           0
#define SL_HORZ           0x400
#define SL_TEXTURES       0x10
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

class RscButton
{
   access = 0;
	type = CT_BUTTON;
	text = "";
	colorText[] = {1,1,1,.9};
	colorDisabled[] = {0,0,0,0};
	colorBackground[] = {0.2,0.41,0.78,0}; // normal
	colorFocused[] = {0.14,0.25,0.49,0}; // pulse
	colorBackgroundActive[] = {0.25,0.51,0.96,0}; // hover
	colorBackgroundDisabled[] = {0.3,0.3,0.3,0};
	colorShadow[] = {0,0,0,0};
	colorBorder[] = {0,0,0,0};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.5, 1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.5, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1};

	style = 2;
	x = 0;
	y = 0;
	w = 0.055589;
	h = 0.039216;
	shadow = 0;
	font = "PuristaMedium";
	sizeEx = 0.04;
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
};

class RscText //Base definition used for inheritance
{
  type = 0;
  idc = -1;
  style = 0;
  colorBackground[] = {0, 0, 0, 1};
  colorText[] = {1, 1, 1, 1};
  font = FontM;
  sizeEx = 0.04;
  h = 0.04;
  text = "";
};

class RscPicture
{
 access = 0;
 type = CT_STATIC;
 idc = -1;
 style = 48;//ST_PICTURE
 colorBackground[] = {0,0,0,0};
 colorText[] = {1,1,1,1};
 font = "TahomaB";
 sizeEx = 0;
 lineSpacing = 0;
 text = "";
 fixedWidth = 0;
 shadow = 0;
};

class RLO_Mark: RscPicture
{
	idc = 6558;
	fixedWidth = 0;
	text = "RLO\img\RLO_mark.paa";
	
	x = 0.603;
	y = safezoneY + (0.449074*safezoneH)-(0.015/2);
	w = 0.015*3/4;
	h = 0.015;
};

class RLO_Main
{
	idd = 9901;
	onLoad = "_this execVM 'RLO\scripts\init.sqf'";
	class Controls
	{
		// Black background
		
		class RLO_Main: RscPicture
		{
			fixedWidth = 0;
			text = "RLO\img\RLO_main.paa";
			
			x = safezoneX + (safezoneW - safezoneH*3/4)/2;
			y = safezoneY;
			w = safezoneH*3/4;
			h = safezoneH;
		};
		
		class RLO_Beam: RscPicture {
			idc = 6559;
			text = "RLO\img\RLO_line.paa";
	
			x = safeZoneX + (0.492145*safeZoneW) - (safeZoneH*0.260185*3/4);
			y = safezoneY + (0.449074*safezoneH) - (safeZoneH*0.260185);
			w = safeZoneH*0.260185*3/4*2;
			h = safeZoneH*0.260185*2;
		};
		
		#define RLO_InitX (safezoneX + ((safezoneW - safezoneH*4/3)/2))
		#define RLO_InitY safezoneY
		#define RLO_width (safezoneH*4/3)
		#define RLO_height safezoneH
		
		class RLO_rangeSwitchPic: RscPicture {
			idc = 6560;
			text = "RLO\img\RLO_range_switch.paa";
			
			x = RLO_InitX + (0.5*RLO_width) - (safeZoneH*0.125*3/4)/2;
			y = RLO_InitY + (0.8842*RLO_height) - safeZoneH*0.125/2;
			w = safeZoneH*0.125*3/4;
			h = safeZoneH*0.125;
		};
		
		class RLO_rangeSwitchBut: RscButton {
			idc = -1;
			onMouseButtonDown = "[_this select 0, _this select 1, 0] call RLO_fnc_onButtonClick;";
			//onMouseButtonDown = "hint str time;";
			
			x = RLO_InitX + (0.5*RLO_width) - (safeZoneH*0.0625*3/4)/2;
			y = RLO_InitY + (0.8842*RLO_height) - safeZoneH*0.0625/2;
			w = safeZoneH*0.0625*3/4;
			h = safeZoneH*0.0625;
		};
	};
};