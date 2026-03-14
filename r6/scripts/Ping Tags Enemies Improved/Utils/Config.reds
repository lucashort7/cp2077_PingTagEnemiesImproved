module PingTagEnemiesImproved.Utils.Config


public class PingTagSettings {

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.displayName", "Enable")
  @runtimeProperty("ModSettings.description", "Whether this mod is enabled?")
  public let enabled: Bool = true;

  // NPCPuppet
  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.category", "NPCPuppet Base")
  @runtimeProperty("ModSettings.category.order", "1")
  @runtimeProperty("ModSettings.displayName", "Tag Enemies")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagNpcs: Bool = true;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.category", "NPCPuppet Base")
  @runtimeProperty("ModSettings.displayName", "Limit Number of Tag Enemies")
  @runtimeProperty("ModSettings.description", "*mb too OP for u, han??! ;P* go on...")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let shouldLimitNumOfTags: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.category", "NPCPuppet Base")
  @runtimeProperty("ModSettings.displayName", "Max Number of Tagged Enemies")
  @runtimeProperty("ModSettings.step", "1")
  @runtimeProperty("ModSettings.min", "1")
  @runtimeProperty("ModSettings.max", "30")
  @runtimeProperty("ModSettings.dependency", "shouldLimitNumOfTags")
  public let maxNumOfTags: Int32 = 10;

  // SensorsDevice Base
  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.category", "SensorsDevice Base")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "Tag Surveillance Cameras")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagCameras: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.category", "SensorsDevice Base")
  @runtimeProperty("ModSettings.displayName", "Tag Security Turrets")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagTurrets: Bool = false;

  // InteractiveMasterDevice Base
  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.category", "InteractiveMasterDevice Base")
  @runtimeProperty("ModSettings.category.order", "3")
  @runtimeProperty("ModSettings.displayName", "Tag Security Alarms")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagAlarms: Bool = false;

  @runtimeProperty("ModSettings.mod", "Ping Tags Enemies Improved")
  @runtimeProperty("ModSettings.category", "InteractiveMasterDevice Base")
  @runtimeProperty("ModSettings.displayName", "Tag Access Points")
  @runtimeProperty("ModSettings.dependency", "enabled")
  public let tagAccessPoints: Bool = false;

}

