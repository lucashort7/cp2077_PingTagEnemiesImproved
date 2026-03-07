module PingTagEnemiesImproved.Controllers.NPCPuppetController

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Controllers._PingTagController.*
import PingTagEnemiesImproved.Handlers.ModSettings.*
import PingTagEnemiesImproved.Utils.Logging.*


// TODO: explosive is considered NPCPuppet
@wrapMethod(NPCPuppet)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
  let state = wrappedMethod(evt);
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if !settings.enabled { return state; }
  if !settings.tagNpcs { return state; }

  if IsValidRevealStateChangedEvent(evt) && !this.IsTaggedinFocusMode() { 
    GameObject.TagObject(this);
    // FTLog(s"'---------~ [PTagImpv] [DEBUG] >> \(this.GetPersistentID()) was tagged!");
  };
  
  return state;
}

@wrapMethod(NPCPuppet)
protected cb func OnDeath(evt: ref<gameDeathEvent>) -> Bool {
  let state = wrappedMethod(evt);

  GameObject.UntagObject(this);
  // FTLog(s"'---------~ [PTagImpv] [DEBUG] >> NPCPuppet::OnDeath() (\(this.GetPersistentID())) Tag cleared post death!!");
  
  return state;
}
