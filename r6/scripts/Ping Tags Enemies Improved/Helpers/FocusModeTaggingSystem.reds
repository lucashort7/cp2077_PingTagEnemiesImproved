module PingTagEnemiesImproved.Helpers

import PingTagEnemiesImproved.Handlers.ModSettings.*
import PingTagEnemiesImproved.Utils.Logging.*


public class _FocusModeTaggingSystem {
  public static func GetFocusTagSystem() -> ref<FocusModeTaggingSystem> {
    let sSysContainer: ref<ScriptableSystemsContainer> = GameInstance.GetScriptableSystemsContainer(GetGameInstance());
    let focusTagSystem: ref<FocusModeTaggingSystem> = sSysContainer.Get(n"FocusModeTaggingSystem") as FocusModeTaggingSystem;
    return focusTagSystem;
  }

  public static func UntagAll() -> Void {
    let focusTagSystem = _FocusModeTaggingSystem.GetFocusTagSystem();
    focusTagSystem.UntagAll();
    FTLogDebug("_FocusModeTaggingSystem::UntagAll()");
  }

  public static func GetTaggedObjectsList() -> array<wref<GameObject>>  {
    let focusTagSystem = _FocusModeTaggingSystem.GetFocusTagSystem();
    let taggedObjs: array<wref<GameObject>> = focusTagSystem.GetTaggedObjectsList();
    return taggedObjs;
  }
}