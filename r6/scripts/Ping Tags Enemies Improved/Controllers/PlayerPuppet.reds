module PingTagEnemiesImproved.Controllers

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Systems.*
import PingTagEnemiesImproved.Utils.Config.*
import PingTagEnemiesImproved.Utils.Logging.*


// Injection
@addField(PlayerPuppet)
public let pti: ref<PTagSS>;

@addField(PlayerPuppet)
public let markedForTagObjs: array<EntityID>;

@addField(PlayerPuppet)
public let lastTaggedObjs: array<EntityID>;

@addMethod(PlayerPuppet)
public final func GetConfigShouldLimitTagEnemies() -> Bool { 
  return this.pti.settings.shouldLimitNumOfTags;
}

@addMethod(PlayerPuppet)
public final func GetConfigMaxNumOfTags() -> Int32 { 
  return this.pti.settings.maxNumOfTags;
}

@addMethod(PlayerPuppet)
public func AddObjectsToBeTagged(obj: ref<GameObject>) {
	// FTLogDebug(s"PlayerPuppet::AddObjectsToBeTagged -> \(obj)");
	if IsDefined(obj){
    let psID = obj.GetEntityID();
    if !ArrayContains(this.markedForTagObjs, psID) {
      ArrayPush(this.markedForTagObjs, psID);
    }
	}
}
