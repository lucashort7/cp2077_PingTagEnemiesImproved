// -----------------
// [[ SENSOR DEVICE ]]
// -----------------
module PingTagEnemiesImproved.Controllers

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Systems.*
import PingTagEnemiesImproved.Utils.Config.*
import PingTagEnemiesImproved.Utils.Logging.*


@addMethod(SurveillanceCamera)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);
  
  if this.IsPlayerControlled() { 
    return; 
  };
  if this.IsTaggedinFocusMode() {
    return;
  }
  if !Equals(evt.state, ERevealState.STARTED) { 
    return;
  }
  if !(Equals(evt.reason.reason, n"network") || Equals(evt.reason.reason, n"PingQuickhack")) {
    return;
  }

  let settings: ref<PingTagSettings> = _PlayerSystem.GetConfigSettings();
  if settings.enabled && settings.tagCameras { 
    GameObject.TagObject(this);
  }
}

@addMethod(SecurityTurret)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);

  if this.IsPlayerControlled() { 
    return; 
  };
  if this.IsTaggedinFocusMode() {
    return;
  }
  if !Equals(evt.state, ERevealState.STARTED) { 
    return;
  }
  if !(Equals(evt.reason.reason, n"network") || Equals(evt.reason.reason, n"PingQuickhack")) {
    return;
  }

  let settings: ref<PingTagSettings> = _PlayerSystem.GetConfigSettings();
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

@wrapMethod(SensorDevice)
protected cb func OnAttitudeChanged(evt: ref<AttitudeChangedEvent>) -> Bool {
  let state = wrappedMethod(evt);
  GameObject.UntagObject(this);
  return state;
}