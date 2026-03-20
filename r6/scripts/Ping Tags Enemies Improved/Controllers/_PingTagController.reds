
module PingTagEnemiesImproved.Controllers

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Systems.*
import PingTagEnemiesImproved.Utils.Logging.*


public class TagObjectsCallback extends DelayCallback {
  private let player: ref<PlayerPuppet>;

  public func Call() {
    FTLogDebug(s"TagObjectsCallback::Call()");    

    let markedForTagObjs = this.player.markedForTagObjs;
    let maxNumOfTags = this.player.GetConfigShouldLimitTagEnemies() ? this.player.GetConfigMaxNumOfTags() : 999;

    FTLogDebug(s"TagObjectsCallback::maxNumOfTags -> \(maxNumOfTags)");
    FTLogDebug(s"TagObjectsCallback::markedForTagObjs.size -> \(ArraySize(markedForTagObjs))");
    FTLogDebug(s"TagObjectsCallback::markedForTagObjs -> \(markedForTagObjs)");
    
    let i: Int32 = 0;
    while (i < ArraySize(markedForTagObjs) && i < maxNumOfTags) {
      let target = GameInstance.FindEntityByID(GetGameInstance(), markedForTagObjs[i]) as GameObject;
      if IsDefined(target) {
        FTLogDebug(s"target -> psID: \(target.GetPersistentID()); isTagged: \(target.IsTaggedinFocusMode())");
        if !target.IsTaggedinFocusMode(){
          GameObject.TagObject(target);
          ArrayPush(this.player.lastTaggedObjs, markedForTagObjs[i]);
        }
      }
      i += 1;
    }
    FTLogDebug(s"ALL OBJS WERE TAGGED!");
    // PTagSS.ResetTaggableObjs();
  }

  public static func Create() -> ref<TagObjectsCallback> {
    let self = new TagObjectsCallback();
    self.player = _PlayerSystem.GetPlayerPuppet();
    return self;
  }
}


@wrapMethod(DeviceLinkComponentPS)
public const final func PingDevicesNetwork() -> Void {
  FTLogDebug("DeviceLinkComponentPS::PingDevicesNetwork()!");

  let player = _PlayerSystem.GetPlayerPuppet();

  FTLogDebug(s"TagObjectsCallback::lastTaggedObjs -> \(player.lastTaggedObjs)");
  let i = 0;
  while (i < ArraySize(player.lastTaggedObjs)) {
    let target = GameInstance.FindEntityByID(GetGameInstance(), player.lastTaggedObjs[i]) as GameObject;
    GameObject.UntagObject(target);
    i += 1;
  }
  FTLogDebug(s"TagObjectsCallback -> All objects UnTagged!");

  player.markedForTagObjs = [];
  player.lastTaggedObjs = [];

  wrappedMethod();

  let delaySystem = GameInstance.GetDelaySystem(GetGameInstance());
  let delay: Float = 1.5;
  let isAffectedByTimeDilation: Bool = false;

  delaySystem.DelayCallback(
    TagObjectsCallback.Create(), 
    delay,
    isAffectedByTimeDilation
  );
}
