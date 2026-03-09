
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


// -----------------
// [[ NPC PUPPET ]]
// -----------------
// TODO: explosive is considered NPCPuppet
@wrapMethod(NPCPuppet)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
  let state = wrappedMethod(evt);

  if this.IsTaggedinFocusMode() { return state; }
  if !IsValidRevealStateChangedEvent(evt) { return state; }

  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if settings.enabled && settings.tagNpcs { 
    GameObject.TagObject(this);
    // FTLog(s"'---------~ [PTagImpv] [DEBUG] >> \(this.GetPersistentID()) was tagged!");
  }

  return state;
}

@wrapMethod(NPCPuppet)
protected cb func OnDeath(evt: ref<gameDeathEvent>) -> Bool {
  let state = wrappedMethod(evt);

  GameObject.UntagObject(this);
  // FTLog(s"'---------~ [PTagImpv] [DEBUG] >> NPCPuppet::OnDeath() (\(this.GetPersistentID())) Tag cleared post death!!");
  
  return state;
}


// -----------------
// [[ INTERACTIVE MASTER DEVICE ]]
// -----------------
// TODO: this.IsBreached -> UntagObject
@addMethod(AccessPoint)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);

  // _DebugOnRevealStateChanged("AccessPoint::OnRevealStateChanged()", this, evt);
  if this.IsTaggedinFocusMode() { return; };
  if !IsValidRevealStateChangedEvent(evt) { return; };
  
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if settings.enabled && settings.tagAccessPoints { 
    GameObject.TagObject(this);
  }
}

// TODO: this.IsDestroyed -> UntagObject
@addMethod(SecurityAlarm)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);
  
  // _DebugOnRevealStateChanged("SecurityAlarm::OnRevealStateChanged()", this, evt);
  if this.IsTaggedinFocusMode() { return; };
  if !IsValidRevealStateChangedEvent(evt) { return; };

  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if settings.enabled && settings.tagAlarms { 
    GameObject.TagObject(this);
  }
}


// -----------------
// [[ SENSOR DEVICE ]]
// -----------------
@addMethod(SurveillanceCamera)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);
  
  // _DebugOnRevealStateChanged("SurveillanceCamera::OnRevealStateChanged()", this, evt);
  if this.GetDevicePS().IsControlledByPlayer() { return; };
  if this.IsTaggedinFocusMode() { return; };
  if !IsValidRevealStateChangedEvent(evt) { return; };

  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if settings.enabled && settings.tagCameras { 
    GameObject.TagObject(this);
  }
}

@addMethod(SecurityTurret)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);

  // _DebugOnRevealStateChanged("SecurityTurret::OnRevealStateChanged()", this, evt);
  if this.GetDevicePS().IsControlledByPlayer() { return; };
  if this.IsTaggedinFocusMode() { return; };
  if !IsValidRevealStateChangedEvent(evt) { return; };

  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if settings.enabled && settings.tagTurrets { 
    GameObject.TagObject(this);
  }
}

@wrapMethod(SensorDevice)
protected func TurnOffDevice() -> Void {
  wrappedMethod();
  GameObject.UntagObject(this);
}

@wrapMethod(SensorDevice)
protected cb func OnDeath(evt: ref<gameDeathEvent>) -> Bool {
  let state = wrappedMethod(evt);
  GameObject.UntagObject(this);
  return state;
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
