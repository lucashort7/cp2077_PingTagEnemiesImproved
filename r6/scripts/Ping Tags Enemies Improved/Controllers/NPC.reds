module PingTagEnemiesImproved.Controllers.NPC

// TODO: maybe more efficient store objectID from tagged objs
// TODO: clean after load, or force? dunno

@wrapMethod(NPCPuppet)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
  let state = wrappedMethod(evt);
  
  FTLog("\n=================================================");
  FTLog("'---------~ [PingTagEnemiesImproved] [DEBUG] >> NPCPuppet::OnRevealStateChanged() Triggered!");
  FTLog(s"'---------~ [PingTagEnemiesImproved] [DEBUG] >> evt.reason:  \(evt.reason.sourceEntityId).\(evt.reason.reason)");
  FTLog(s"'---------~ [PingTagEnemiesImproved] [DEBUG] >> evt.state:  \(evt.state)");
  FTLog("=================================================\n");
  
  if Equals(evt.state, ERevealState.STARTED) && !this.IsDead() {
    GameObject.TagObject(this.GetOwner());
  };

  return state;
}

@wrapMethod(NPCPuppet)
protected cb func OnDeath(evt: ref<gameDeathEvent>) -> Bool {
  wrappedMethod(evt);
  FTLog("'---------~ [PingTagEnemiesImproved] [DEBUG] >> NPCPuppet::OnDeath() Triggered!");
  
  if this.IsTaggedinFocusMode(){ 
    GameObject.UntagObject(this); 
    FTLog("'---------~ [PingTagEnemiesImproved] [DEBUG] >> NPCPuppet::OnDeath() UntagObject - Tag clear post death!!");
  }
  else {
    FTLog("'---------~ [PingTagEnemiesImproved] [DEBUG] >> NPCPuppet::OnDeath() Was Not tagged; :X");
  }; 
}

