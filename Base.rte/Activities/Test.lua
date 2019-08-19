package.loaded.Constants = nil; require("Constants");

function Test:StartActivity()
	print("Test:StartActivity()");
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