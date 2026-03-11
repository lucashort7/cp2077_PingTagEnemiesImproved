// -----------------
// [[ NPC PUPPET ]] <--- ScriptedPuppet <--- gamePuppet
// -----------------
module PingTagEnemiesImproved.Controllers

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Handlers.ModSettings.*
import PingTagEnemiesImproved.Helpers.*
import PingTagEnemiesImproved.Utils.Logging.*


@wrapMethod(NPCPuppet)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
  // this._ptag_debug();
  // evt._ptag_debug();

  let state = wrappedMethod(evt);

  if this.IsTaggedinFocusMode(){
    return state;
  }
  if !evt.IsValidEventForTagging() { 
    return state; 
  }

  let player: ref<PlayerPuppet> = _PlayerSystem.GetPlayerPuppet();
  let settings: ref<PingTagSettings> = player.pti.settings;
  if settings.enabled && settings.tagNpcs { 
    player.AddObjectsToBeTagged(this);
  }
  return state;
}

@wrapMethod(NPCPuppet)
protected cb func OnDeath(evt: ref<gameDeathEvent>) -> Bool {
  let state = wrappedMethod(evt);
  GameObject.UntagObject(this);
  return state;
}

@addMethod(NPCPuppet)
protected final func _ptag_debug() {
  FTLog("\n-----------------------------");
  FTLogDebug(s"NPCPuppet:");
  FTLogDebug(s"````--- isTagged:                        \(this.IsTaggedinFocusMode())");
  FTLogDebug(s"````--- psID:                            \(this.GetPersistentID())");
  FTLogDebug(s"````--- GetDeviceLinkPSID:               \(this.GetDeviceLink().GetID())");
}