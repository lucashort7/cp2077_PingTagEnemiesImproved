module PingTagEnemiesImproved

import PingTagEnemiesImproved.Handlers.ModSettings.{PingTagSettings}


public class PingTagService extends ScriptableService {
  public let pti: ref<PingTagSettings>;

  private cb func OnLoad() {
    this.pti = new PingTagSettings();
    FTLog("'--- [PingTagEnemiesImproved] >> modSettings loaded!!");
  }

  private cb func OnInitialize() {
    FTLog("'--- [PingTagEnemiesImproved] >> Game instance initialized, can access game systems");
  }

  private cb func OnUninitialize() {
    FTLog("'--- [PingTagEnemiesImproved] >> Game is shutting down");
  }
}




