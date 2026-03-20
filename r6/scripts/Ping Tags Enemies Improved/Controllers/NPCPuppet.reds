// -----------------
// [[ NPC PUPPET ]] <--- ScriptedPuppet <--- gamePuppet
// -----------------
module PingTagEnemiesImproved.Controllers

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Systems.*
import PingTagEnemiesImproved.Utils.Config.*
import PingTagEnemiesImproved.Utils.Logging.*


@wrapMethod(NPCPuppet)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
  let state = wrappedMethod(evt);

  if Equals(evt.state, ERevealState.STOPPED) { 
    return state;
  }
  if !(Equals(evt.reason.reason, n"network") || Equals(evt.reason.reason, n"PingQuickhack")) {
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