module PingTagEnemiesImproved.Systems

import PingTagEnemiesImproved.*
import PingTagEnemiesImproved.Utils.Config.*
import PingTagEnemiesImproved.Utils.Logging.*

public class _PlayerSystem {

  public static func GetPlayerSystem() -> ref<PlayerSystem> {
    let playerSystem: ref<PlayerSystem> = GameInstance.GetPlayerSystem(GetGameInstance());
    return playerSystem;
  }

  public static func GetPlayerPuppet() -> ref<PlayerPuppet> {
    let player: ref<PlayerPuppet> = GetGameInstance().GetPlayerSystem().GetLocalPlayerControlledGameObject() as PlayerPuppet;
    return player;
  }

  public static func GetConfigSettings() -> ref<PingTagSettings> {
    let player: ref<PlayerPuppet> = _PlayerSystem.GetPlayerSystem().GetPlayer();
    return player.pti.settings;
  }
}