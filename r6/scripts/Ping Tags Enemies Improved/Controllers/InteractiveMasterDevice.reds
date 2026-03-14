// -----------------
// [[ INTERACTIVE MASTER DEVICE ]]
// -----------------
module PingTagEnemiesImproved.Controllers

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Systems.*
import PingTagEnemiesImproved.Utils.Config.*
import PingTagEnemiesImproved.Utils.Logging.*


// TODO: this.IsBreached -> UntagObject
@addMethod(AccessPoint)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);

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
  if settings.enabled && settings.tagAccessPoints { 
    GameObject.TagObject(this);
  }
}

// TODO: this.IsDestroyed -> UntagObject
@addMethod(SecurityAlarm)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);
  
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
  if settings.enabled && settings.tagAlarms { 
    GameObject.TagObject(this);
  }
}