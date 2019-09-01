package.loaded.Constants = nil; require("Constants");

function Test:StartActivity()
	print("Test:StartActivity()");

	for p = Activity.PLAYER_1, Activity.MAXPLAYERCOUNT - 1 do
		if not self:GetPlayerBrain(p) then
			self.ActivityState = Activity.EDITING
			-- For reachability checks
			MovableMan:OpenAllDoors(true, Activity.NOTEAM)
			AudioMan:ClearMusicQueue()
			-- Play editor music
			AudioMan:PlayMusic("Base.rte/Music/dBSoundworks/ccambient4.ogg", -1, -1)
		end
	end
end

function Test:PauseActivity(pause)
	print("Test:PauseActivity()");
end

function Test:EndActivity()
	print("Test:EndActivity()");
end

function Test:UpdateActivity()
	print("Test:UpdateActivity()");
end