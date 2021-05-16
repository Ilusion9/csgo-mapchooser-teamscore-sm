#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <mapchooser>

public Plugin myinfo =
{
	name = "Mapchooser Teamscore",
	author = "Ilusion9",
	description = "Start the vote based on teams score.",
	version = "1.0",
	url = "https://github.com/Ilusion9/"
};

ConVar g_Cvar_StartScore;

public void OnPluginStart()
{
	HookEvent("round_start", Event_RoundStart);
	
	g_Cvar_StartScore = CreateConVar("sm_mapvote_teamscore_start", "14", "Specifies when to start the vote based on teams score.", FCVAR_NONE, true, 0.0);
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
	if (!g_Cvar_StartScore.BoolValue)
	{
		return;
	}
	
	if (GetTeamScore(CS_TEAM_T) == g_Cvar_StartScore.IntValue
		|| GetTeamScore(CS_TEAM_CT) == g_Cvar_StartScore.IntValue)
	{
		if (CanMapChooserStartVote() && !HasEndOfMapVoteFinished())
		{
			InitiateMapChooserVote(MapChange_MapEnd);
		}
	}
}
