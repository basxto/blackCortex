function Create(self)
end

function Update(self)
end

function Destroy(self)
	ActivityMan:GetActivity():ReportDeath(self.Team, -1)
end
