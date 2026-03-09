
module PingTagEnemiesImproved.Controllers._PingTagController

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Handlers.ModSettings.*
import PingTagEnemiesImproved.Utils.Logging.*


public func _DebugOnRevealStateChanged(ctx: String, dvc: ref<GameObject>, evt: ref<RevealStateChangedEvent>) -> Void {
  FTLog("\n=================================================");
  FTLogDebug(ctx);
  FTLogDebug(s"evt:  \(evt.state); \(evt.reason.sourceEntityId); \(evt.reason.reason)");
  FTLogDebug(s"device:  \(dvc.GetPersistentID()); \(dvc.GetClassName());");
  FTLog("=================================================\n");
}

public func IsValidRevealStateChangedEvent(evt: ref<RevealStateChangedEvent>) -> Bool {
  if !Equals(evt.state, ERevealState.STARTED) { 
    return false; 
  }
  if !(Equals(evt.reason.reason, n"network") || Equals(evt.reason.reason, n"PingQuickhack")) {
    return false;
  }
  return true;
}

// TODO: explosive is considered NPCPuppet
@wrapMethod(NPCPuppet)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
  let state = wrappedMethod(evt);
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if !settings.enabled && !settings.tagNpcs { 
    FTLogDebug(s"Settings disabled for [NPCPuppet]");
    return state; 
  }

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

@addMethod(AccessPoint)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);
  
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if !settings.enabled && !settings.tagAccessPoints { 
    FTLogDebug(s"Settings disabled for [AccessPoint]");
    return; 
  }

  _DebugOnRevealStateChanged("AccessPoint::OnRevealStateChanged()", this, evt);
  
  if IsValidRevealStateChangedEvent(evt) && !this.IsTaggedinFocusMode() {
    GameObject.TagObject(this);
  }
}

@addMethod(SecurityAlarm)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);
  
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if !settings.enabled && !settings.tagAlarms { 
    FTLogDebug(s"Settings disabled for [SecurityAlarm]");
    return; 
  }

  _DebugOnRevealStateChanged("SecurityAlarm::OnRevealStateChanged()", this, evt);
  
  if IsValidRevealStateChangedEvent(evt) && !this.IsTaggedinFocusMode() {
    GameObject.TagObject(this);
  }
}

@addMethod(SurveillanceCamera)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);
  
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if !settings.enabled && !settings.tagCameras { 
    FTLogDebug(s"Settings disabled for [SensorDevice::SurveillanceCamera]");
    return; 
  }

  _DebugOnRevealStateChanged("SurveillanceCamera::OnRevealStateChanged()", this, evt);

  if IsValidRevealStateChangedEvent(evt) && !this.IsTaggedinFocusMode() {
    GameObject.TagObject(this);
  }
}

@addMethod(SecurityTurret)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);

  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if !settings.enabled && !settings.tagTurrets { 
    FTLogDebug(s"Settings disabled for [SensorDevice::SecurityTurret]");
    return; 
  }

  _DebugOnRevealStateChanged("SecurityTurret::OnRevealStateChanged()", this, evt);

  if IsValidRevealStateChangedEvent(evt) && !this.IsTaggedinFocusMode() {
    GameObject.TagObject(this);
  }
}

// @wrapMethod(SensorDevice)
// protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
//   let state = wrappedMethod(evt);

//   _DebugOnRevealStateChanged("SensorDevice::OnRevealStateChanged()", this, evt);

//   if this.IsSurveillanceCamera() || this.IsTurret() { 
//     FTLogDebug(s"NOT ROOT SensorDevice! :: \(this.GetClassName())");
//     return state; 
//   }
  
//   let settings: ref<PingTagSettings> = PTagSS.GetSettings();
//   if !settings.enabled && !settings.tagSensors { 
//     FTLogDebug(s"Settings disabled for [SensorDevice::SecurityTurret]");
//     return state; 
//   }
  
//   if IsValidRevealStateChangedEvent(evt) && !this.IsTaggedinFocusMode() {
//     GameObject.TagObject(this);
//   }

//   return state;
// }

// TODO: on friendly, disabled, destroy -> UNTAG
