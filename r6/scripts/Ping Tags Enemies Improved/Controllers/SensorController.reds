module PingTagEnemiesImproved.Controllers.SensorController

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Controllers._PingTagController.*
import PingTagEnemiesImproved.Handlers.ModSettings.*
import PingTagEnemiesImproved.Utils.Logging.*


@addMethod(SurveillanceCamera)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);
  _DebugOnRevealStateChanged("SurveillanceCamera::OnRevealStateChanged()", this, evt);
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if !settings.enabled { return; }
  if !settings.tagCameras { return; }

  if IsValidRevealStateChangedEvent(evt) && !this.IsTaggedinFocusMode(){
    GameObject.TagObject(this);
  }
}

@addMethod(SecurityTurret)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);
  _DebugOnRevealStateChanged("SecurityTurret::OnRevealStateChanged()", this, evt);
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if !settings.enabled { return; }
  if !settings.tagTurrets { return; }

  if IsValidRevealStateChangedEvent(evt) && !this.IsTaggedinFocusMode(){
    GameObject.TagObject(this);
  }
}

@wrapMethod(SensorDevice)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
  let state = wrappedMethod(evt);
  _DebugOnRevealStateChanged("SensorDevice::OnRevealStateChanged()", this, evt);
  if this.IsTaggedinFocusMode() || this.IsSurveillanceCamera() || this.IsTurret() { 
    FTLogDebug("NOT ROOT SENSORDEVICE!");
    return state; 
  }
  
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if !settings.enabled { return state; }
  if !settings.tagSensors { return state;  }
  
  if IsValidRevealStateChangedEvent(evt){
    GameObject.TagObject(this);
  }

  return state;
}

// TODO: on friendly, disabled, destroy -> UNTAG