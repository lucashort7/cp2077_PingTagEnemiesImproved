module PingTagEnemiesImproved.Controllers.SensorController

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Handlers.ModSettings.*

@wrapMethod(SensorDevice)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
  let state = wrappedMethod(evt);
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();

  if !settings.enabled {
    return state;
  }
  let isRevealStart = Equals(evt.state, ERevealState.STARTED);
  let isValidReason = Equals(evt.reason.reason, n"network") || Equals(evt.reason.reason, n"PingQuickhack");
  let isTagged = this.IsTaggedinFocusMode(); // untag if already tagged
  let isValid2Tag = (this.IsSurveillanceCamera() && settings.tagCameras) || (this.IsSensor() && settings.tagSensors) || (this.IsTurret() && settings.tagTurrets);
  
  if isRevealStart && isValidReason && !isTagged && isValid2Tag {
    GameObject.TagObject(this);
  }
  // FTLog(s"'---------~ [PTagImpv] [DEBUG] >> \(this.GetPersistentID()) was tagged!");

  return state;
}

