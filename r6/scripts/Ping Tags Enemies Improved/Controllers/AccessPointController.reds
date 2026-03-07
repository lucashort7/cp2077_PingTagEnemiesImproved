module PingTagEnemiesImproved.Controllers.AccessPointController

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Handlers.ModSettings.*

// @addMethod(AccessPoint)
// protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
//   let settings = GetSettings();

//   if !settings.enabled {
//     return false;
//   }
//   let isRevealStart = Equals(evt.state, ERevealState.STARTED);
//   let isValidReason = Equals(evt.reason.reason, n"network") || Equals(evt.reason.reason, n"PingQuickhack");
//   let isTagged = this.IsTaggedinFocusMode(); // untag if already tagged
//   let isValid2Tag = this.IsAccessPoint() && settings.tagAccessPoints;
  
//   if isRevealStart && isValidReason && !isTagged && isValid2Tag {
//     GameObject.TagObject(this);
//   }
//   // FTLog(s"'---------~ [PTagImpv] [DEBUG] >> \(this.GetPersistentID()) was tagged!");

//   return state;
// }


// TODO: override children methods to isolate AccessPoint
//				a lot of things are Device base :(
@wrapMethod(Device)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
  let state = wrappedMethod(evt);
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();

  if !settings.enabled {
    return state;
  }
  let isRevealStart = Equals(evt.state, ERevealState.STARTED);
  let isValidReason = Equals(evt.reason.reason, n"network") || Equals(evt.reason.reason, n"PingQuickhack");
  let isTagged = this.IsTaggedinFocusMode(); // untag if already tagged
  let isValid2Tag = this.IsAccessPoint() && settings.tagCameras;
  
  if isRevealStart && isValidReason && !isTagged && isValid2Tag {
    GameObject.TagObject(this);
  }
  // FTLog(s"'---------~ [PTagImpv] [DEBUG] >> \(this.GetPersistentID()) was tagged!");

  return state;
}