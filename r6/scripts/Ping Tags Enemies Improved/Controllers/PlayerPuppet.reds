module PingTagEnemiesImproved.Controllers

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Handlers.ModSettings.*
import PingTagEnemiesImproved.Helpers.*
import PingTagEnemiesImproved.Utils.Logging.*


// Injection
@addField(PlayerPuppet)
public let pti: ref<PTagSS>;

@addField(PlayerPuppet)
public let IsNewObjsLocked: Bool;

@addField(PlayerPuppet)
public let taggableObjects: array<wref<GameObject>>;

@addMethod(PlayerPuppet)
protected final func GetConfigMaxTaggableObjects() -> Int32 { 
  let player = _PlayerSystem.GetPlayerPuppet();
  return player.pti.settings.maxTaggableObjects;
}

@addMethod(PlayerPuppet)
protected final func GetCurrentTaggableObjectsCount() -> Int32 {
  return ArraySize(this.taggableObjects) + 1;
}

@addMethod(PlayerPuppet)
protected final func HasAvailableTagSlots() -> Bool {
  if this.GetCurrentTaggableObjectsCount() <=  this.GetConfigMaxTaggableObjects() {
    return true;
  }
  return false;
}

@addMethod(PlayerPuppet)
public func AddObjectsToBeTagged(obj: ref<GameObject>) {
	if this.IsNewObjsLocked { 
		return; 
	};
	if !this.HasAvailableTagSlots() {
		this.IsNewObjsLocked = true;
		this.pti.DelayedTagObjects();
	}
	
	if !ArrayContains(this.taggableObjects, obj) {
		ArrayPush(this.taggableObjects, obj);
	}
}

@wrapMethod(PlayerPuppet)
private final func PlayerAttachedCallback(playerPuppet: ref<GameObject>) -> Void {
	wrappedMethod(playerPuppet);
	if playerPuppet == this {
		PTagSS.Initialize(this);
	}
	this.IsNewObjsLocked = false;
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
	let player: ref<PlayerPuppet> = _PlayerSystem.GetPlayerPuppet();
	if IsDefined(player.pti) {
		player.pti.RefreshSettings();
	}
	wrappedMethod();
}