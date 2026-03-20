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

import PingTagEnemiesImproved.Systems.*
import PingTagEnemiesImproved.Utils.Config.*
import PingTagEnemiesImproved.Utils.Logging.*


public class PTagSS extends ScriptableSystem {
  public let settings: ref<PingTagSettings>;
  public let player: ref<PlayerPuppet>;

  public func OnAttach() { 
    // FTLogDebug("PTagSS::OnAttach()");
    GameInstance.GetCallbackSystem().RegisterCallback(n"Input/Key", this, n"OnKeyInput")
      .AddTarget(InputTarget.Key(EInputKey.IK_PageUp, EInputAction.IACT_Press))
      .AddTarget(InputTarget.Key(EInputKey.IK_PageDown, EInputAction.IACT_Press))
      .SetLifetime(CallbackLifetime.Session);
  }

  private cb func OnKeyInput(evt: ref<KeyInputEvent>) {
    // FTLogDebug(s"PTagSS::OnKeyInput() -> Pressed \(evt.GetKey())");
    if Equals(evt.GetKey(), EInputKey.IK_PageUp) {
      PTagSS.UntagAll();
    }
    // if Equals(evt.GetKey(), EInputKey.IK_PageDown) {
    //   let taggedObjs = _FocusModeTaggingSystem.GetTaggedObjectsList();
    //   FTLogDebug(s"\(taggedObjs)");
    // }
  }

  public static func Initialize(player: ref<PlayerPuppet>) -> Void {
    FTLogDebug("PTagSS::Initialize()");
    let pti: ref<PTagSS> = new PTagSS();
    pti.player = player;

    player.pti = pti;
    player.pti.RefreshSettings();
  }

  public final func Uninitialize() -> Void {
    // FTLogDebug("PTagSS::Uninitialize()");
    this.player.pti = null;
    this.player = null;
  }

  public final func RefreshSettings() -> Void {
		this.settings = new PingTagSettings();
    FTLogDebug(s"PTagSS::RefreshSettings()");
	}

  public static func UntagAll() {
    FTLogDebug(s"PTagSS::UntagAll()");
    let player = _PlayerSystem.GetPlayerPuppet();
    let taggingSystem = player.GetTaggingSystem();
    let taggedObjs = taggingSystem.GetTaggedObjectsList();
    if ArraySize(taggedObjs) > 0 {
      taggingSystem.RequestUntagAll();
    }
    player.markedForTagObjs = [];
    player.lastTaggedObjs = [];
  }
}

// OnPlayerAttach
@wrapMethod(PlayerPuppet)
private final func PlayerAttachedCallback(playerPuppet: ref<GameObject>) -> Void {
	wrappedMethod(playerPuppet);
	if playerPuppet == this {
		PTagSS.Initialize(this);
	}
}

// OnPlayerDetattach
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
	let player: ref<PlayerPuppet> = _PlayerSystem.GetPlayerPuppet();
	if IsDefined(player.pti) {
		player.pti.RefreshSettings();
	}
	wrappedMethod();
}