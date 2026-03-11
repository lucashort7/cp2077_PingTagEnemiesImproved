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
import PingTagEnemiesImproved.Helpers.*
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

  private cb func OnKeyInput(evt: ref<KeyInputEvent>) {
    // FTLogDebug(s"PTagSS::OnKeyInput() -> Pressed \(evt.GetKey())");
    if Equals(evt.GetKey(), EInputKey.IK_PageUp) {
      _FocusModeTaggingSystem.UntagAll();
    }
    if Equals(evt.GetKey(), EInputKey.IK_PageDown) {
      let taggedObjs = _FocusModeTaggingSystem.GetTaggedObjectsList();
      FTLogDebug(s"\(taggedObjs)");
    }
  }

  public static func Initialize(player: ref<PlayerPuppet>) -> Void {
    // FTLogDebug("PTagSS::Initialize()");
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
    // FTLogDebug(s"PTagSS::RefreshSettings() -> \(this.settings)");
	}

  public final func DelayedTagObjects() {
    let delaySystem = GameInstance.GetDelaySystem(GetGameInstance());
    let taggableObjects = this.player.taggableObjects;
    let maxTaggableObjects = this.settings.maxTaggableObjects;
    let delay: Float = 1.5;
    let isAffectedByTimeDilation: Bool = false;

    delaySystem.DelayCallback(
      TagObjectsCallback.Create(taggableObjects, maxTaggableObjects), 
      delay,
      isAffectedByTimeDilation
    );
  }

  public static func ResetTaggableObjs() {
    FTLogDebug(s"PTagSS::ResetTaggableObjs()");
    let player = _PlayerSystem.GetPlayerPuppet();
    ArrayClear(player.taggableObjects);
    player.IsNewObjsLocked = false;
  }
}


public class TagObjectsCallback extends DelayCallback {
  private let taggableObjects: array<wref<GameObject>>;
  private let maxTaggableObjects: Int32;

  public func Call() {
    FTLogDebug(s"TagObjectsCallback::Call()");
    let i: Int32 = ArraySize(this.taggableObjects) - 1;
    let t: Int32 = 1;
    while (i >= 0 && t <= this.maxTaggableObjects) {
      let obj = this.taggableObjects[i];
      if IsDefined(obj) {
        GameObject.TagObject(obj);
      }
      i -= 1;
    }
    FTLogDebug(s"ALL OBJS WERE TAGGED!");
    PTagSS.ResetTaggableObjs();
  }

  public static func Create(taggableObjects: array<wref<GameObject>>, maxTaggableObjects: Int32) -> ref<TagObjectsCallback> {
    // use this way to create your Callback class in one line
    let self = new TagObjectsCallback();
    self.taggableObjects = taggableObjects;
    self.maxTaggableObjects = maxTaggableObjects;
    return self;
  }
}