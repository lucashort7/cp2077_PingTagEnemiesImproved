module PingTagEnemiesImproved

import PingTagEnemiesImproved.Handlers.ModSettings.{PingTagSettings}


public class PTagSS extends ScriptableSystem {
  public let settings: ref<PingTagSettings>;
  public let player: ref<PlayerPuppet>;

  public final func RefreshSettings() -> Void {
		this.settings = new PingTagSettings();
    FTLog("'--- [PingTagEnemiesImproved] >> [DEBUG] PTagSS::RefreshSettings()");
	}

  public static func Initialize(player: ref<PlayerPuppet>) -> Void {
    FTLog("'--- [PingTagEnemiesImproved] >> [DEBUG] PTagSS::Initialize()");
    let pti: ref<PTagSS> = new PTagSS();
    pti.player = player;
    player.pti = pti;
    
    pti.RefreshSettings();
  }

  public final func Uninitialize() -> Void {
    FTLog("'--- [PingTagEnemiesImproved] >> [DEBUG] PTagSS::Uninitialize()");
    this.player.pti = null;
    this.player = null;
  }

  public static func GetSettings() -> ref<PingTagSettings> {
    let playerSystem = GameInstance.GetPlayerSystem(GetGameInstance());
    let player = playerSystem.GetPlayer();
    // FTLog(s"'---------~ [PTagImpv] [DEBUG] >> pti.settings: \(player.pti.settings)");
    return player.pti.settings;
  }
}


// Injection
@addField(PlayerPuppet)
public let pti: ref<PTagSS>;

@wrapMethod(PlayerPuppet)
private final func PlayerAttachedCallback(playerPuppet: ref<GameObject>) -> Void {
	wrappedMethod(playerPuppet);
	if playerPuppet == this {
		PTagSS.Initialize(this);
	}
}

@wrapMethod(PlayerPuppet)
private final func PlayerDetachedCallback(playerPuppet: ref<GameObject>) -> Void {
	if playerPuppet == this && IsDefined(this.pti) {
		this.pti.Uninitialize();
	}
	wrappedMethod(playerPuppet);
}

// Refresh settings hook
@wrapMethod(PauseMenuBackgroundGameController)
protected cb func OnUninitialize() -> Bool {
	let player: ref<PlayerPuppet> = GetGameInstance().GetPlayerSystem().GetLocalPlayerControlledGameObject() as PlayerPuppet;
	if IsDefined(player.pti) {
		player.pti.RefreshSettings();
	}
	wrappedMethod();
}