// -----------------
// [[ RevealStateChangedEvent ]] <--- Event <--- gamePuppet
// -----------------
// public class RevealStateChangedEvent extends Event {
  // public let state: ERevealState;
          // enum ERevealState {
          //   STARTED = 0,
          //   CONTINUE = 1,
          //   STOPPED = 2,
          // }
  // public let reason: gameVisionModeSystemRevealIdentifier;
          // public importonly struct gameVisionModeSystemRevealIdentifier {
          //   public native let sourceEntityId: EntityID;
          //   public native let reason: CName;
          // }
  // public let transitionTime: Float;

module PingTagEnemiesImproved.Controllers

import PingTagEnemiesImproved.Utils.Logging.*


@addMethod(RevealStateChangedEvent)
public final func IsValidEventForTagging() -> Bool {
  if Equals(this.state, ERevealState.STOPPED) { 
    return false;
  }
  if !(Equals(this.reason.reason, n"network") || Equals(this.reason.reason, n"PingQuickhack")) {
    return false;
  }
  return true;
}

@addMethod(RevealStateChangedEvent)
public final func _ptag_debug() {
  FTLog("\n-----------------------------");
  FTLogDebug(s"RevealStateChangedEvent:");
  FTLogDebug(s"````--- state: \(this.state)");
  FTLogDebug(s"````--- reason -> sourceEntityId: \(this.reason.sourceEntityId); reason: \(this.reason.reason)");
}