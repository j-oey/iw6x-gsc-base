#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include common_scripts\utility;

//entry point
init()
{
	level thread onplayerconnect();
	setdvar("sv_cheats",1);
}

onplayerconnect()
{
    for(;;)
    {
        level waittill("connected", player);
		player thread onplayerspawned();
		player thread initmenu();
    }
}

onplayerspawned()
{
    self endon("disconnect");
    for(;;)
    {
        self waittill("spawned_player");
		self freezecontrols(false);
		self iprintln("^3Use [{+speed_throw}] and [{+actionslot 2}] to Open");
		wait 0.1;
    }
}

//player setup stuff
initmenu()
{
	self.currentmenu = "IW6 GSC Base";
	self.CurrentOpt = 0;
	self.menuopen = false;
	self thread initoverflow();
	self thread openbutton();
	self thread backbutton();
	self thread selectbutton();
	self thread upbutton();
}

//player variables example
intivars()
{
	self.god = 0;
}

//menu dpad binds
openbutton()
{
	self endon("disconnect");
    for(;;)
    {
		self notifyonplayercommand("open", "+actionslot 2");
		self waittill("open");
		if(self AdsButtonPressed() && self.menuopen == false)
		{
			self thread menuopen();
			self freezecontrols(false);
		}
		if(self.menuopen == true)
		{
			self.CurrentOpt++;
			if(self.CurrentOpt > self.Assuming[self.currentmenu].size - 1)
			{
				self.CurrentOpt = 0;
			}
			self thread UpdateScroller();
		}
		wait 0.1;
	}
}

backbutton()
{
	self endon("disconnect");
    for(;;)
    {
		self notifyonplayercommand("close", "+melee_zoom");
		self waittill("close");
		if(self.currentmenu == "IW6 GSC Base")
		{
			self thread menuclose();
		}
		else if(self.currentmenu == "Closed")
		{
		
		}
		else
		{
			self thread NewMenu(self.BackMenu[self.currentmenu]);
		}
		wait 0.1;
	}
}

selectbutton()
{
	self endon("disconnect");
    for(;;)
	{
		self notifyonplayercommand("pick", "+usereload");
		self waittill("pick");
		if(self.menuopen == true)
		{
			if(isDefined(self.AssumingArg))
			{
				self thread [[self.AssumingFunc[self.currentmenu][self.CurrentOpt]]](self.AssumingArg[self.currentmenu][self.CurrentOpt]);
			}
			else
			{
				self thread [[self.AssumingFunc[self.currentmenu][self.CurrentOpt]]]();
			}
		}
		wait 0.1;
	}
}

upbutton()
{
	self endon("disconnect");
    for(;;)
	{
		self notifyonplayercommand("up", "+actionslot 1");
		self waittill("up");
		if(self.menuopen == true)
		{
			self.CurrentOpt --;
			if(self.CurrentOpt < 0)
			{
				self.CurrentOpt = self.Assuming[self.currentmenu].size - 1;
			}
			self thread UpdateScroller();
		}
		wait 0.1;
	}
}

//menu base
BuildMenus()
{
	self AddOption("IW6 GSC Base", 0, "Submenu 1", ::NewMenu, "Submenu 1");
	self AddOption("IW6 GSC Base", 1, "Submenu 2", ::NewMenu, "Submenu 2");
	self AddOption("IW6 GSC Base", 2, "Submenu 3", ::NewMenu, "Submenu 3");
	self AddOption("IW6 GSC Base", 3, "Submenu 4", ::NewMenu, "Submenu 4");
	self AddOption("IW6 GSC Base", 4, "Submenu 5", ::NewMenu, "Submenu 5");
	self AddOption("IW6 GSC Base", 5, "Submenu 6", ::NewMenu, "Submenu 6");
	self AddOption("IW6 GSC Base", 6, "Clients", ::NewMenu, "Clients");
	
	self.BackMenu["Submenu 1"] = "IW6 GSC Base";
	self AddOption("Submenu 1", 0, "Take Weapon", ::takemygun);
	self AddOption("Submenu 1", 1, "Drop Weapon", ::dropmygun);
	self AddOption("Submenu 1", 2, "Debug Info", ::debuginfo);
	self AddOption("Submenu 1", 3, "Option 4", ::testopt);
	self AddOption("Submenu 1", 4, "Option 5", ::testopt);
	self AddOption("Submenu 1", 5, "Option 6", ::testopt);
	self AddOption("Submenu 1", 6, "Option 7", ::testopt);
	self AddOption("Submenu 1", 7, "Option 8", ::testopt);
	self AddOption("Submenu 1", 8, "Option 9", ::testopt);
	self AddOption("Submenu 1", 9, "Option 10", ::testopt);

	self.BackMenu["Submenu 2"] = "IW6 GSC Base";
	self AddOption("Submenu 2", 0, "Option 1", ::testopt);
	self AddOption("Submenu 2", 1, "Option 2", ::testopt);
	self AddOption("Submenu 2", 2, "Option 3", ::testopt);
	self AddOption("Submenu 2", 3, "Option 4", ::testopt);
	self AddOption("Submenu 2", 4, "Option 5", ::testopt);
	self AddOption("Submenu 2", 5, "Option 6", ::testopt);
	self AddOption("Submenu 2", 6, "Option 7", ::testopt);
	self AddOption("Submenu 2", 7, "Option 8", ::testopt);
	self AddOption("Submenu 2", 8, "Option 9", ::testopt);
	self AddOption("Submenu 2", 9, "Option 10", ::testopt);

	self.BackMenu["Submenu 3"] = "IW6 GSC Base";
    self AddOption("Submenu 3", 0, "Option 1", ::testopt);
    self AddOption("Submenu 3", 1, "Option 2", ::testopt);
    self AddOption("Submenu 3", 2, "Option 3", ::testopt);
    self AddOption("Submenu 3", 3, "Option 4", ::testopt);
    self AddOption("Submenu 3", 4, "Option 5", ::testopt);
    self AddOption("Submenu 3", 5, "Option 6", ::testopt);
    self AddOption("Submenu 3", 6, "Option 7", ::testopt);
    self AddOption("Submenu 3", 7, "Option 8", ::testopt);
    self AddOption("Submenu 3", 8, "Option 9", ::testopt);
    self AddOption("Submenu 3", 9, "Option 10", ::testopt);

	self.BackMenu["Submenu 4"] = "IW6 GSC Base";
    self AddOption("Submenu 4", 0, "Option 1", ::testopt);
    self AddOption("Submenu 4", 1, "Option 2", ::testopt);
    self AddOption("Submenu 4", 2, "Option 3", ::testopt);
    self AddOption("Submenu 4", 3, "Option 4", ::testopt);
    self AddOption("Submenu 4", 4, "Option 5", ::testopt);
    self AddOption("Submenu 4", 5, "Option 6", ::testopt);
    self AddOption("Submenu 4", 6, "Option 7", ::testopt);
    self AddOption("Submenu 4", 7, "Option 8", ::testopt);
    self AddOption("Submenu 4", 8, "Option 9", ::testopt);
    self AddOption("Submenu 4", 9, "Option 10", ::testopt);

	self.BackMenu["Submenu 5"] = "IW6 GSC Base";
    self AddOption("Submenu 5", 0, "Option 1", ::testopt);
    self AddOption("Submenu 5", 1, "Option 2", ::testopt);
    self AddOption("Submenu 5", 2, "Option 3", ::testopt);
    self AddOption("Submenu 5", 3, "Option 4", ::testopt);
    self AddOption("Submenu 5", 4, "Option 5", ::testopt);
    self AddOption("Submenu 5", 5, "Option 6", ::testopt);
    self AddOption("Submenu 5", 6, "Option 7", ::testopt);
    self AddOption("Submenu 5", 7, "Option 8", ::testopt);
    self AddOption("Submenu 5", 8, "Option 9", ::testopt);
    self AddOption("Submenu 5", 9, "Option 10", ::testopt);

	self.BackMenu["Submenu 6"] = "IW6 GSC Base";
    self AddOption("Submenu 6", 0, "Option 1", ::testopt);
    self AddOption("Submenu 6", 1, "Option 2", ::testopt);
    self AddOption("Submenu 6", 2, "Option 3", ::testopt);
    self AddOption("Submenu 6", 3, "Option 4", ::testopt);
    self AddOption("Submenu 6", 4, "Option 5", ::testopt);
    self AddOption("Submenu 6", 5, "Option 6", ::testopt);
    self AddOption("Submenu 6", 6, "Option 7", ::testopt);
    self AddOption("Submenu 6", 7, "Option 8", ::testopt);
    self AddOption("Submenu 6", 8, "Option 9", ::testopt);
    self AddOption("Submenu 6", 9, "Option 10", ::testopt);
	
	self.BackMenu["Clients"] = "IW6 GSC Base";
	self endon("death");
	self endon("Closed");
	self endon("disconnect");
	for(;;)
	{
		self AddOption("Clients", 0, level.players[0].name, ::NewMenu, level.players[0].name);
		self AddOption("Clients", 1, level.players[1].name, ::NewMenu, level.players[1].name);
		self AddOption("Clients", 2, level.players[2].name, ::NewMenu, level.players[2].name);
		self AddOption("Clients", 3, level.players[3].name, ::NewMenu, level.players[3].name);
		self AddOption("Clients", 4, level.players[4].name, ::NewMenu, level.players[4].name);
		self AddOption("Clients", 5, level.players[5].name, ::NewMenu, level.players[5].name);
		self AddOption("Clients", 6, level.players[6].name, ::NewMenu, level.players[6].name);
		self AddOption("Clients", 7, level.players[7].name, ::NewMenu, level.players[7].name);
		self AddOption("Clients", 8, level.players[8].name, ::NewMenu, level.players[8].name);
		self AddOption("Clients", 9, level.players[9].name, ::NewMenu, level.players[9].name);
		self AddOption("Clients", 10, level.players[10].name, ::NewMenu, level.players[10].name);
		self AddOption("Clients", 11, level.players[11].name, ::NewMenu, level.players[11].name);
		self AddOption("Clients", 12, level.players[12].name, ::NewMenu, level.players[12].name);
		self AddOption("Clients", 13, level.players[13].name, ::NewMenu, level.players[13].name);
		self AddOption("Clients", 14, level.players[14].name, ::NewMenu, level.players[14].name);
		self AddOption("Clients", 15, level.players[15].name, ::NewMenu, level.players[15].name);
		self AddOption("Clients", 16, level.players[16].name, ::NewMenu, level.players[16].name);
		self AddOption("Clients", 17, level.players[17].name, ::NewMenu, level.players[17].name);
		
		for(i = 0;i < level.players.size;i++)
		{
			self.BackMenu[level.players[i].name] = "Clients";
			self AddOption(level.players[i].name, 0, "Teleport", ::moveplayer, level.players[i]);
			self AddOption(level.players[i].name, 1, "Kick", ::kickplayer, level.players[i]);
			self AddOption(level.players[i].name, 2, "Kill", ::killplayer, level.players[i]);
		}
		wait 0.7;
	}
}

testopt()
{
	self iprintlnbold("^:Test Option");
}

dropmygun()
{
	self dropitem(self getcurrentweapon());
}

takemygun()
{
	self takeweapon(self getcurrentweapon());
}

debuginfo()
{
	self iprintln("Weapon ^:" + self getcurrentweapon());
	self iprintln("Origin ^:" + self.origin);
	self iprintln("Angles ^:" + self getplayerangles());
	self iprintln("Level ^:" + getdvar("mapname"));
}

moveplayer(player)
{
	forward = self getTagOrigin("j_head");
	end = vector_scal(anglestoforward(self getPlayerAngles()), 1000000);
	Location = BulletTrace( forward, end, false, self )["position"];
	player setOrigin(Location);
}

vector_scal(vec, scale)
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}

killplayer(player)
{
	player suicide();
}

kickplayer(player)
{
	if(player ishost())
	{
		self iprintlnbold("^:Cannot Kick The Host");
	}
	else if(player != self)
	{
		//need to add this
		//kick(player getentitynumber());
	}
	else
	{
		self iprintlnbold("^:Cannot Kick Yourself");
	}
}

AddOption(Menu, Option, Text, Func, Arg)
{
	self.Assuming[Menu][Option] = Text;
	self.AssumingFunc[Menu][Option] = Func;
	self.AssumingArg[Menu][Option] = Arg;
}

NewMenu(Menu)
{
	self.currentmenu = Menu;
	self.CurrentOpt = 0;
	for(i = 0;i < 32;i++)
	{
		self.menutext[i] Destroy();
	}
	self.menutitle Destroy();
	self.menutitle = createText("objective", 1.8, "RIGHT", "CENTER", 320, -165, "^3" + self.currentmenu);
	for(i = 0;i < self.Assuming[self.currentmenu].size;i++)
	{
		self.menutext[i] = createText("objective", 1.4, "RIGHT", "CENTER", 320, -145 + i * 15, self.Assuming[self.currentmenu][i]);
	}
	self thread UpdateScroller();
	self thread UpdateScroller();
	self thread UpdateScroller();
}

menuopen()
{
	self.currentmenu = "IW6 GSC Base";
	self.CurrentOpt = 0;
	self.menuopen = true;
	self thread BuildMenus();
	self.bg = self createRectangle( "LEFT", "TOP", 160, 150, "white", 170, 200, (0, 0, 0), 0.8);
	self.scroller = self createRectangle( "LEFT", "CENTER", 160, 0, "white", 170, 15, (1, 0.4, 0), 1);
	self.menutitle = createText("objective", 1.8, "RIGHT", "CENTER", 320, -165, "^3IW6 GSC Base");
	self.bg.sort = -2;
	self.scroller.sort = -1;

	for(i = 0;i < self.Assuming[self.currentmenu].size;i++)
	{
		self.menutext[i] = createText("objective", 1.4, "RIGHT", "CENTER", 320, -145 + i * 15, self.Assuming[self.currentmenu][i]);
	}
	self thread UpdateScroller();
	self thread UpdateScroller();
	self thread UpdateScroller();
}

menuclose()
{
	self.currentmenu = "Closed";
	self notify("Closed");
	self thread BuildMenus();
	self.menuopen = false;
	self.bg Destroy();
	self.scroller Destroy();
	self.menutitle Destroy();
	for(i = 0;i < 40;i++)
	{
		self.menutext[i] Destroy();
	}
}

UpdateScroller()
{
	self thread BuildMenus();
	for(i = 0;i < self.Assuming[self.currentmenu].size;i++)
	{
		if(i == self.CurrentOpt)
		{
			self.scroller.y = self.menutext[i].y;

		}
		else
		{
			self.menutext[i].Color = (1, 1, 1);
			self.menutext[i].glowAlpha = 0;
		}
	}
}

//hud elems
createRectangle( align, relative, x, y, shader, width, height, color, alpha)
{
	barElemBG = newClientHudElem( self );
	barElemBG.elemType = "bar";
	if ( !level.splitScreen )
	{
		barElemBG.x = -2;
		barElemBG.y = -2;
	}
	barElemBG.width = width;
	barElemBG.height = height;
	barElemBG.align = align;
	barElemBG.relative = relative;
	barElemBG.xOffset = 0;
	barElemBG.yOffset = 0;
	barElemBG.children = [];
	barElemBG.color = color;
	barElemBG.alpha = alpha;
	barElemBG.archived = self.NotStealth;
	barElemBG setParent( level.uiParent );
	barElemBG setShader( shader, width , height );
	barElemBG.hidden = false;
	barElemBG setPoint(align,relative,x,y);
	return barElemBG;
}

createText(font, fontscale, align, relative, x, y, text)
{
	textElem = CreateFontString( font, fontscale );
	textElem setPoint( align, relative, x, y );
	textElem.hideWhenInMenu = true;
	textElem.type = "text";
	textElem.alpha = 1;
	addTextTableEntry(textElem, getStringId(text));
	textElem setSafeText(self, text);
	return textElem;
}

//overflow fix
initoverflow()
{
	self.stringTable = [];
	self.stringTableEntryCount = 0;
	self.textTable = [];
	self.textTableEntryCount = 0;
	if(isDefined(level.anchorText) == false)
	{
		level.anchorText = createServerFontString("default",1.5);
		level.anchorText setText("anchor");
		level.anchorText.alpha = 0;
		level.stringCount = 0;
	}
}

clearStrings()
{
	level.anchorText clearAllTextAfterHudElem();
	level.stringCount = 0;
	self purgeTextTable();
	self purgeStringTable();
	self recreateText();
}

setSafeText(player, text)
{
	stringId = player getStringId(text);
	if(stringId == -1)
	{
		player addStringTableEntry(text);
		stringId = player getStringId(text);
	}
	player editTextTableEntry(self.textTableIndex, stringId);
	if(level.stringCount > 50)
	clearStrings();
	self setText(text);
}

recreateText()
{
	foreach(entry in self.textTable)
	entry.element setSafeText(self, lookUpStringById(entry.stringId));
}

addStringTableEntry(string)
{
	entry = spawnStruct();
	entry.id = self.stringTableEntryCount;
	entry.string = string;
	self.stringTable[self.stringTable.size] = entry;
	self.stringTableEntryCount++;
	level.stringCount++;
}

lookUpStringById(id)
{
	string = "";
	foreach(entry in self.stringTable)
	{
		if(entry.id == id)
		{
			string = entry.string;
			break;
		}
	}
	return string;
}

getStringId(string)
{
	id = -1;
	foreach(entry in self.stringTable)
	{
		if(entry.string == string)
		{
			id = entry.id;
		}
		break;
	}
return id;
}

getStringTableEntry(id)
{
	stringTableEntry = -1;
	foreach(entry in self.stringTable)
	{
		if(entry.id == id)
		{
			stringTableEntry = entry;
			break;
		}
	}
return stringTableEntry;
}

purgeStringTable()
{
	stringTable = [];
	foreach(entry in self.textTable)
	stringTable[stringTable.size] = getStringTableEntry(entry.stringId);
	self.stringTable = stringTable;
}

purgeTextTable()
{
	textTable = [];
	foreach(entry in self.textTable)
	{
		if(entry.id != -1)
		textTable[textTable.size] = entry;
	}
	self.textTable = textTable;
}

addTextTableEntry(element, stringId)
{
	entry = spawnStruct();
	entry.id = self.textTableEntryCount;
	entry.element = element;
	entry.stringId = stringId;
	element.textTableIndex = entry.id;
	self.textTable[self.textTable.size] = entry;
	self.textTableEntryCount++;
}

editTextTableEntry(id, stringId)
{
	foreach(entry in self.textTable)
	{
		if(entry.id == id)
		{
			entry.stringId = stringId;
			break;
		}
	}
}

deleteTextTableEntry(id)
{
	foreach(entry in self.textTable)
	{
		if(entry.id == id)
		{
			entry.id = -1;
			entry.stringId = -1;
		}
	}
}

clear(player)
{
	if(self.type == "text")
	player deleteTextTableEntry(self.textTableIndex);
	self destroy();
}