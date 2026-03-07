
module PingTagEnemiesImproved.Controllers._PingTagController

import PingTagEnemiesImproved.Utils.Logging.*


public func _DebugOnRevealStateChanged(ctx: String, dvc: ref<GameObject>, evt: ref<RevealStateChangedEvent>) -> Void {
  FTLog("\n=================================================");
  FTLogDebug(ctx);
  FTLogDebug(s"evt:  \(evt.state); \(evt.reason.sourceEntityId); \(evt.reason.reason)");
  FTLogDebug(s"device:  \(dvc.GetPersistentID()); \(dvc.GetClassName());");
  FTLog("=================================================\n");
}

public func IsValidRevealStateChangedEvent(evt: ref<RevealStateChangedEvent>) -> Bool{
  if !Equals(evt.state, ERevealState.STARTED) { 
    return false; 
  }
  if !(Equals(evt.reason.reason, n"network") || Equals(evt.reason.reason, n"PingQuickhack")) {
    return false;
  }
  return true;
}
