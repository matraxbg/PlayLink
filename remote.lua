dragging = false;

local keyboard = libs.keyboard;
local mouse = libs.mouse;
local open = io.open;
local _text = "";

-- Read File
function read_file(path)
	local file, err = io.open(path,"r")
	if file==nil then
		print("Couldn't open file: "..err)
	else
		return file:read()
	end
end

-- Update
function update(r)
	--server.update({id = "touch", text = r });
end

-- Change Text
actions.change = function(text)
	_text = string.gsub(text,"\n"," ");
end

-- Play Link
actions.play = function ()
	local script = 'python "C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\play.py " '..'"'.._text..'"'
	print(script)
	--os.open("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\play.py",_text);
	local pipe = io.popen("powershell.exe -Command -", "w")
	pipe:write(script)
	pipe:close()
end

-- Open Link
actions.open = function ()
	os.open("C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe",_text);
end

-- Lower System Volume
actions.volume_down = function()
	keyboard.press("volumedown");
end

-- Raise System Volume
actions.volume_up = function()
	keyboard.press("volumeup");
end

-- Mouse Actions
actions.down = function()
	update("down");
end

actions.up = function()
	update("up");
end

actions.tap = function()
	update("tap");
	if (dragging) then
		dragging = false;
		mouse.dragend();
		mouse.up();
	else
		mouse.click("left");
	end
end

actions.double = function()
	update("double");
	mouse.double("left");
end

actions.hold = function()
	update("hold");
	mouse.down();
	mouse.dragbegin();
	dragging = true;
end

actions.delta = function (id, x, y)
	update("delta: " .. x .. " " .. y);
	mouse.moveraw(x, y);
end

actions.left = function()
	mouse.click("left");
end

actions.right = function()
	mouse.click("right");
end

-- Rewind
actions.rewind = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.stroke("alt","left");
	elseif string.find(link, "youtube.com") or string.find(link, "youtu.be") then
		keyboard.press("j");
	elseif string.find(link, "twitch.tv") then
		keyboard.press("left");
	elseif string.find(link, "netflix.com") then
		keyboard.press("left");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("left");
	else
		keyboard.press("left");
	end
end

-- Play/Pause
actions.playpause = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.press("Space");
	elseif string.find(link, "youtube.com") or string.find(link, "youtu.be") then
		keyboard.press("k");
	elseif string.find(link, "twitch.tv") then
		keyboard.press("Space");
	elseif string.find(link, "netflix.com") then
		keyboard.press("Space");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("Space");
	end
end

-- Fast Forward
actions.fastforward = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.stroke("alt","right");
	elseif string.find(link, "youtube.com") or string.find(link, "youtu.be") then
		keyboard.press("l");
	elseif string.find(link, "twitch.tv") then
		keyboard.press("right");
	elseif string.find(link, "netflix.com") then
		keyboard.press("right");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("right");
	end
end

-- Volume Down
actions.vdown = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.press("Down");
	elseif string.find(link, "youtube.com") or string.find(link, "youtu.be") then
		keyboard.press("Down");
	elseif string.find(link, "twitch.tv") then
		keyboard.press("Down");
	elseif string.find(link, "netflix.com") then
		keyboard.press("Down");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("Down");
	end
end

-- Volume Mute
actions.vmute = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.press("Down");
	elseif string.find(link, "youtube.com") or string.find(link, "youtu.be") then
		keyboard.press("m");
	elseif string.find(link, "twitch.tv") then
		keyboard.press("pgup");
	elseif string.find(link, "netflix.com") then
		keyboard.press("m");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("m");
	end
end

-- Volume Up
actions.vup = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.press("up");
	elseif string.find(link, "youtube.com") or string.find(link, "youtu.be") then
		keyboard.press("up");
	elseif string.find(link, "twitch.tv") then
		keyboard.press("up");
	elseif string.find(link, "netflix.com") then
		keyboard.press("up");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("up");
	end
end

-- Previous Track
actions.prev = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.press("p");
	elseif string.find(link, "youtube.com") or string.find(link, "youtu.be") then
		keyboard.stroke("shift","p");
	elseif string.find(link, "twitch.tv") then
		keyboard.press("");
	elseif string.find(link, "netflix.com") then
		keyboard.stroke("shift","p");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("");
	end
end

-- Toggle Fullscreen
actions.fscreen = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.press("f");
	elseif string.find(link, "youtube.com") or string.find(link, "youtu.be") then
		keyboard.press("f");
	elseif string.find(link, "twitch.tv") then
		keyboard.press("f");
	elseif string.find(link, "netflix.com") then
		keyboard.press("f");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("f");
	end
end

-- Next Track
actions.nxt = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.press("p");
	elseif string.find(link, "youtube.com") or string.find(link, "youtu.be") then
		keyboard.stroke("shift","n");
	elseif string.find(link, "twitch.tv") then
		keyboard.press("");
	elseif string.find(link, "netflix.com") then
		keyboard.stroke("shift","n");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("");
	end
end

-- Toggle Captions
actions.captions = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.stroke("shift","v");
	elseif string.find(link, "youtube.com") or string.find(link, "youtu.be") then
		keyboard.press("c");
	elseif string.find(link, "twitch.tv") then
		keyboard.press("");
	elseif string.find(link, "netflix.com") then
		keyboard.press("c");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("c");
	end
end

-- Toggle Subtitles Track
actions.sub = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.press("v");
	elseif string.find(link, "youtube.com") or string.find(link, "youtu.be") then
		keyboard.press("");
	elseif string.find(link, "twitch.tv") then
		keyboard.press("");
	elseif string.find(link, "netflix.com") then
		keyboard.press("v");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("c");
	end
end

-- Toggle Audio Track
actions.dio = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.press("b");
	elseif string.find(link, "youtube.com") or string.find(link, "youtu.be") then
		keyboard.press("");
	elseif string.find(link, "twitch.tv") then
		keyboard.press("");
	elseif string.find(link, "netflix.com") then
		keyboard.press("a");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("a");
	end
end

-- Twitch Theatre Mode
actions.theatre = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.press("");
	elseif string.find(link, "twitch.tv") then
		keyboard.stroke("alt","t");
	end
end

-- Skip Intro
actions.skipintro = function()
	link = read_file("C:\\ProgramData\\Unified Remote\\Remotes\\Bundled\\Unified\\Examples\\PlayLink\\data.txt")
	if link == nil then
		keyboard.press("");
	elseif string.find(link, "netflix.com") then
		keyboard.press("s");
	elseif string.find(link, "primevideo.com") then
		keyboard.press("s");
	end
end

-- Escape
actions.esc = function()
	keyboard.press("esc");
end

-- Page Up
actions.pgup = function()
	keyboard.press("pgup");
end

-- Enter
actions.enter = function()
	keyboard.press("enter");
end

-- Shift + Tab
actions.shifttab = function()
	keyboard.stroke("shift","tab");
end

-- Page Down
actions.pgdown = function()
	keyboard.press("pgdown");
end

-- Tab
actions.tab = function()
	keyboard.press("tab");
end