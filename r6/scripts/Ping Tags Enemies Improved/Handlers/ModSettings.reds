module PingTagEnemiesImproved.Handlers.ModSettings


public class PingTagSettings {

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Enable")
  @runtimeProperty("ModSettings.description", "Whether this mod is enabled?")
  public let enabled: Bool = true;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.category", "NPCs")
  @runtimeProperty("ModSettings.displayName", "Tag Enemies")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagNpcs: Bool = true;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.category", "SensorsDevice Type")
  @runtimeProperty("ModSettings.displayName", "Tag Surveillance Cameras")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagCameras: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.category", "SensorsDevice Type")
  @runtimeProperty("ModSettings.displayName", "Tag Security Turrets")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagTurrets: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.category", "SensorsDevice Type")
  @runtimeProperty("ModSettings.displayName", "Tag Security Alarms")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagAlarms: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.category", "Root Type")
  @runtimeProperty("ModSettings.displayName", "Tag Access Points")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagAccessPoints: Bool = false;

}

