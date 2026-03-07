module PingTagEnemiesImproved.Controllers.NPCPuppetController

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Handlers.ModSettings.*

  // FTLog("\n=================================================");
  // FTLog("'---------~ [PingTagEnemiesImproved] [DEBUG] >> NPCPuppet::OnRevealStateChanged() Triggered!");
  // FTLog(s"'---------~ [PingTagEnemiesImproved] [DEBUG] >> evt.reason:  \(evt.reason.sourceEntityId) - \(evt.reason.reason)");
  // FTLog(s"'---------~ [PingTagEnemiesImproved] [DEBUG] >> evt.state:  \(evt.state)");
  // FTLog(s"'---------~ [PingTagEnemiesImproved] [DEBUG] >> NPCPuppet.PersistentID:  \(this.GetPersistentID())");
  // FTLog(s"'---------~ [PingTagEnemiesImproved] [DEBUG] >> NPCPuppet.Name:  \(this.GetDisplayName()) - \(this.GetDisplayDescription())");
  // FTLog(s"'---------~ [PingTagEnemiesImproved] [DEBUG] >> NPCPuppet.IsDead:  \(this.IsDead())");

@wrapMethod(NPCPuppet)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
  let state = wrappedMethod(evt);
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();

  if !settings.enabled { return state; }
  if !settings.tagNpcs { return state; }

  let isRevealStart = Equals(evt.state, ERevealState.STARTED);
  let isValidReason = Equals(evt.reason.reason, n"network") || Equals(evt.reason.reason, n"PingQuickhack");
  let isTagged = this.IsTaggedinFocusMode();      // untag if already tagged

  if isRevealStart && isValidReason && !isTagged { 
    GameObject.TagObject(this);
    // FTLog(s"'---------~ [PTagImpv] [DEBUG] >> \(this.GetPersistentID()) was tagged!");
  };
  
  return state;
}

// TODO: maybe more efficient store PersistentID from tagged objs
//       clean after load, or force on key? dunno
@wrapMethod(NPCPuppet)
protected cb func OnDeath(evt: ref<gameDeathEvent>) -> Bool {
  let state = wrappedMethod(evt);

  GameObject.UntagObject(this);
  // FTLog(s"'---------~ [PTagImpv] [DEBUG] >> NPCPuppet::OnDeath() (\(this.GetPersistentID())) Tag cleared post death!!");
  
  return state;
}
