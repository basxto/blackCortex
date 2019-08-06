

rte = {};

-- enables to detect that this is running with blackCortex
-- and not Cortex Command
rte.blackCortex = 0.01;

-- this should be compatible to constants of Cortex Command
rte.TechList = {};
rte.OffensiveLoadouts = {};
rte.DefensiveLoadouts = {};
rte.EngineerLoadouts = {};
if SettingsMan then
    rte.MOIDCountMax = SettingsMan.RecommendedMOIDCount;
end
rte.NoMOID = 255;
rte.SpawnIntervalScale = 1.0;
rte.StartingFundsScale = 1.0;