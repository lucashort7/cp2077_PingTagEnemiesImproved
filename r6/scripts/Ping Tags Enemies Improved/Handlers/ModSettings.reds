module PingTagEnemiesImproved.Handlers.ModSettings

public class PingTagSettings {

  // Whether mod is enabled?
  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Enable")
  @runtimeProperty("ModSettings.description", "Whether this mod is enabled?")
  public let enabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Tag NPCs")
  public let tagNpcs: Bool = true;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Tag access points")
  public let tagAccessPoints: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Tag hackable computers")
  public let tagHackableComputers: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Tag turrets")
  public let tagTurrets: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Tag cameras")
  public let tagCameras: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Prevent tagging turned off cameras")
  public let preventTaggingInactiveCameras: Bool = true;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Remove tag when turning off a camera")
  public let ungtagTurnedOffCameras: Bool = true;

  public func Listen() {
    FTLog("'--- [PingTagEnemiesImproved] >> PingTagSettings.Listen");
    ModSettings.RegisterListenerToClass(this);
    ModSettings.RegisterListenerToModifications(this);
  }

  public func Unlisten() {
    FTLog("'--- [PingTagEnemiesImproved] >> PingTagSettings.Unlisten");
    ModSettings.UnregisterListenerToClass(this);
    ModSettings.UnregisterListenerToModifications(this);
  }

  public cb func OnModSettingsChange() {
    FTLog("'--- [PingTagEnemiesImproved] >> PingTagSettings.OnModSettingsChange");
    // FTLog(s"MySettings.enabled: \(this.enabled)");
  }
}

