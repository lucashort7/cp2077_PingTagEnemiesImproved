module PingTagEnemiesImproved.Helpers

import PingTagEnemiesImproved.Handlers.ModSettings.*
import PingTagEnemiesImproved.Utils.Logging.*

public class _NetworkSystem {
  
  public static func GetNetworkSystem() -> ref<NetworkSystem> {
    let sSysContainer: ref<ScriptableSystemsContainer> = GameInstance.GetScriptableSystemsContainer(GetGameInstance());
    let networkSystem: ref<NetworkSystem> = sSysContainer.Get(n"NetworkSystem") as NetworkSystem;
    return networkSystem;
  }
}