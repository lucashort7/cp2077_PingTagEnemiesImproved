module PingTagEnemiesImproved.Handlers.ModSettings


public class PingTagSettings {

  // Whether mod is enabled?
  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Enable")
  @runtimeProperty("ModSettings.description", "Whether this mod is enabled?")
  public let enabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Tag NPCs")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagNpcs: Bool = true;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Tag cameras")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagCameras: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Tag access points")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagAccessPoints: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Tag hackable computers")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagHackableComputers: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Tag turrets")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagTurrets: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Tag hackable sensors")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagSensors: Bool = false;

  // @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  // @runtimeProperty("ModSettings.displayName", "Prevent tagging turned off cameras")
  // @runtimeProperty("ModSettings.dependency", "enabled")
  // public let preventTaggingInactiveCameras: Bool = true;

  // @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  // @runtimeProperty("ModSettings.displayName", "Remove tag when turning off a camera")
  // @runtimeProperty("ModSettings.dependency", "enabled")
  // public let ungtagTurnedOffCameras: Bool = true;

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

