Class TerrainFaustMut extends Mutator;

var TerrainInfo TInfo;
var vector Loc;
var int rad, str;

replication 
{
	reliable if(Role == ROLE_Authority)
		Loc,rad,str,TInfo,Poke;
}

function PreBeginplay()
{
	Super.PreBeginPlay();
	foreach AllActors(class'TerrainInfo', TInfo)
	{
		log("FOUND TINFO");
	}
}

function Mutate(string MutateString, PlayerController PC)
{
	local array<string> Args;

	Split(MutateString, " ", Args);

	if(Args[0] ~= "Poke")
	{
		Loc = PC.Pawn.Location;
		rad = int(Args[1]);
		str = int(Args[2]);
		Poke();
	}
	else if(Args[0] ~= "TerrainFaust")
	{
		PC.Pawn.GiveWeapon("TerrainFaust.TerrainFaustWeapon");
		log("Gave TerrainFaustWeapon");
	}
	Super.Mutate(MutateString, PC);
}

simulated function Poke()
{
	foreach AllActors(class'TerrainInfo', TInfo)
	{
		TInfo.PokeTerrain( Loc, rad, str );
	}

}



defaultproperties
{
     bAddToServerPackages=True
     GroupName="TerrainFaust"
     FriendlyName="TerrainFaustMut"
     Description="Test Mutator for Terrain Faust"
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}