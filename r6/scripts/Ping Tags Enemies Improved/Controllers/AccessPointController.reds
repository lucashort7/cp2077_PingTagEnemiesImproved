module PingTagEnemiesImproved.Controllers.AccessPointController

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Controllers._PingTagController.*
import PingTagEnemiesImproved.Handlers.ModSettings.*
import PingTagEnemiesImproved.Utils.Logging.*


@addMethod(AccessPoint)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
  super.OnRevealStateChanged(evt);
  let settings: ref<PingTagSettings> = PTagSS.GetSettings();
  if !settings.enabled {
    return;
  }
  let isRevealStart = Equals(evt.state, ERevealState.STARTED);
  let isValidReason = Equals(evt.reason.reason, n"network") || Equals(evt.reason.reason, n"PingQuickhack");
  let isTagged = this.IsTaggedinFocusMode(); // untag if already tagged
  let isValid2Tag = this.IsAccessPoint() && settings.tagAccessPoints;

  _DebugOnRevealStateChanged("AccessPoint::OnRevealStateChanged()", this, evt);
  
  if isRevealStart && isValidReason && !isTagged && isValid2Tag {
    GameObject.TagObject(this);
  }
}
