/*
** ██▓███   ██▓ ███▄    █   ▄████    ▄▄▄█████▓ ▄▄▄        ▄████    ▓█████  ███▄    █ ▓█████  ███▄ ▄███▓ ██▓▓█████   ██████ 
** ▓██░  ██▒▓██▒ ██ ▀█   █  ██▒ ▀█▒   ▓  ██▒ ▓▒▒████▄     ██▒ ▀█▒   ▓█   ▀  ██ ▀█   █ ▓█   ▀ ▓██▒▀█▀ ██▒▓██▒▓█   ▀ ▒██    ▒ 
** ▓██░ ██▓▒▒██▒▓██  ▀█ ██▒▒██░▄▄▄░   ▒ ▓██░ ▒░▒██  ▀█▄  ▒██░▄▄▄░   ▒███   ▓██  ▀█ ██▒▒███   ▓██    ▓██░▒██▒▒███   ░ ▓██▄   
** ▒██▄█▓▒ ▒░██░▓██▒  ▐▌██▒░▓█  ██▓   ░ ▓██▓ ░ ░██▄▄▄▄██ ░▓█  ██▓   ▒▓█  ▄ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██    ▒██ ░██░▒▓█  ▄   ▒   ██▒
** ▒██▒ ░  ░░██░▒██░   ▓██░░▒▓███▀▒     ▒██▒ ░  ▓█   ▓██▒░▒▓███▀▒   ░▒████▒▒██░   ▓██░░▒████▒▒██▒   ░██▒░██░░▒████▒▒██████▒▒
** ▒▓▒░ ░  ░░▓  ░ ▒░   ▒ ▒  ░▒   ▒      ▒ ░░    ▒▒   ▓▒█░ ░▒   ▒    ░░ ▒░ ░░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░   ░  ░░▓  ░░ ▒░ ░▒ ▒▓▒ ▒ ░
** ░▒ ░      ▒ ░░ ░░   ░ ▒░  ░   ░        ░      ▒   ▒▒ ░  ░   ░     ░ ░  ░░ ░░   ░ ▒░ ░ ░  ░░  ░      ░ ▒ ░ ░ ░  ░░ ░▒  ░ ░
** ░░        ▒ ░   ░   ░ ░ ░ ░   ░      ░        ░   ▒   ░ ░   ░       ░      ░   ░ ░    ░   ░      ░    ▒ ░   ░   ░  ░  ░  
**           ░           ░       ░                   ░  ░      ░       ░  ░         ░    ░  ░       ░    ░     ░  ░      ░  
**
** > Authors:
** --------------\         @hort: Improved Version 
** --------------\ @TheCactusPie: Original Version [https://www.nexusmods.com/cyberpunk2077/mods/9950]
*/                                                                                                                         

module PingTagEnemiesImproved

import PingTagEnemiesImproved.Handlers.ModSettings.*
import PingTagEnemiesImproved.Utils.Logging.*


public class PTagSS extends ScriptableSystem {
  public let settings: ref<PingTagSettings>;
  public let player: ref<PlayerPuppet>;

  public func OnAttach() { 
    FTLogDebug("PTagSS::OnAttach()");
    GameInstance.GetCallbackSystem().RegisterCallback(n"Input/Key", this, n"OnKeyInput")
      .AddTarget(InputTarget.Key(EInputKey.IK_PageUp, EInputAction.IACT_Press))
      .AddTarget(InputTarget.Key(EInputKey.IK_PageDown, EInputAction.IACT_Press))
      .SetLifetime(CallbackLifetime.Session);
  }

  public static func Initialize(player: ref<PlayerPuppet>) -> Void {
    // FTLogDebug("PTagSS::Initialize()");
    let pti: ref<PTagSS> = new PTagSS();
    pti.player = player;
    player.pti = pti;
    
    pti.RefreshSettings();
  }

  public final func Uninitialize() -> Void {
    // FTLogDebug("PTagSS::Uninitialize()");
    this.player.pti = null;
    this.player = null;
  }

  public final func RefreshSettings() -> Void {
		this.settings = new PingTagSettings();
    // FTLogDebug(s"PTagSS::RefreshSettings() -> \(this.settings)");
	}

  public static func GetSettings() -> ref<PingTagSettings> {
    let playerSystem: ref<PlayerSystem> = GameInstance.GetPlayerSystem(GetGameInstance());
    let player: ref<PlayerPuppet> = playerSystem.GetPlayer();
    return player.pti.settings;
  }

  private cb func OnKeyInput(evt: ref<KeyInputEvent>) {
    // FTLogDebug(s"PTagSS::OnKeyInput() -> Pressed \(evt.GetKey())");
    if Equals(evt.GetKey(), EInputKey.IK_PageUp) {
      PTagSS.UntagAll();
    }
    if Equals(evt.GetKey(), EInputKey.IK_PageDown) {
      PTagSS.GetTaggedObjectsList();
    }
  }

  public static func UntagAll() -> Void {
    let sSysContainer: ref<ScriptableSystemsContainer> = GameInstance.GetScriptableSystemsContainer(GetGameInstance());
    let focusTagSystem: ref<FocusModeTaggingSystem> = sSysContainer.Get(n"FocusModeTaggingSystem") as FocusModeTaggingSystem;
    focusTagSystem.UntagAll();
    FTLogDebug("PTagSS::UntagAll()");
  }

  public static func GetTaggedObjectsList() -> Void {
    let sSysContainer: ref<ScriptableSystemsContainer> = GameInstance.GetScriptableSystemsContainer(GetGameInstance());
    let focusTagSystem: ref<FocusModeTaggingSystem> = sSysContainer.Get(n"FocusModeTaggingSystem") as FocusModeTaggingSystem;
    let taggedObjs: array<wref<GameObject>> = focusTagSystem.GetTaggedObjectsList();
    FTLogDebug(s"PTagSS::GetTaggedObjectsList() -> \(taggedObjs)");
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
