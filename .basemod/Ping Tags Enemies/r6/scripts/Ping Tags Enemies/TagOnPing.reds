public class TagOnPingSettings {
	@runtimeProperty("ModSettings.mod", "Ping Tags Enemies")
	@runtimeProperty("ModSettings.displayName", "Tag NPCs")
	public let tagNpcs: Bool = true;
	
	@runtimeProperty("ModSettings.mod", "Ping Tags Enemies")
	@runtimeProperty("ModSettings.displayName", "Tag access points")
	public let tagAccessPoints: Bool = true;


	@runtimeProperty("ModSettings.mod", "Ping Tags Enemies")
	@runtimeProperty("ModSettings.displayName", "Tag hackable computers")
	public let tagHackableComputers: Bool = true;

	@runtimeProperty("ModSettings.mod", "Ping Tags Enemies")
	@runtimeProperty("ModSettings.displayName", "Tag turrets")
	public let tagTurrets: Bool = true;

	@runtimeProperty("ModSettings.mod", "Ping Tags Enemies")
	@runtimeProperty("ModSettings.displayName", "Tag cameras")
	public let tagCameras: Bool = true;

	@runtimeProperty("ModSettings.mod", "Ping Tags Enemies")
	@runtimeProperty("ModSettings.displayName", "Prevent tagging turned off cameras")
	public let preventTaggingInactiveCameras: Bool = true;

	@runtimeProperty("ModSettings.mod", "Ping Tags Enemies")
	@runtimeProperty("ModSettings.displayName", "Remove tag when turning off a camera")
	public let ungtagTurnedOffCameras: Bool = true;
}

@wrapMethod(ScanningComponent)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
	let result: Bool = wrappedMethod(evt);
	let owner: ref<GameObject> = this.GetOwner();

	// We only want to tag at the start of the ping
	if !Equals(evt.state, ERevealState.STARTED) {
		return result;
	}

	// If the target is already tagged then there's nothing to do
	if owner.IsTaggedinFocusMode() {
		return result;
	}

	// Wthout this check we will end up tagging people highlighted by optics cyberware
	if !(Equals(evt.reason.reason, n"network") || Equals(evt.reason.reason, n"PingQuickhack")) {
		return result;
	}

	let settings = new TagOnPingSettings();

	// Skip if target is a camera that is turned off
	if settings.preventTaggingInactiveCameras {
		let sensorDevice: ref<SensorDevice> = owner as SensorDevice;
		let devicePS = sensorDevice.GetDevicePS();
		if IsDefined(sensorDevice) && !devicePS.IsON() {
			return result;
		}
	}

	if owner.IsNPC() {
		if !settings.tagNpcs {
			return result;
		}
	}
	else if owner.IsAccessPoint() {
		if !settings.tagAccessPoints {
			return result;
		}
	}
	else if owner.IsSensor() {
        if !settings.tagCameras {
			return result;
		}
	}
	else if owner.IsTurret() {
		if !settings.tagTurrets {
			return result;
		}
	}
	else {
		// Some computers function as hackable access points - we have to handle them
		// separately from regular access points
		if !settings.tagHackableComputers {
			return result;
		}

		let deviceBase: ref<DeviceBase> = owner as DeviceBase;
		if !IsDefined(deviceBase) || !deviceBase.IsActiveBackdoor() {
			return result;
		}
	}

	GameObject.TagObject(owner);

	return result;
}

@wrapMethod(SensorDevice)
protected func TurnOffDevice() -> Void {
	wrappedMethod();

	let settings = new TagOnPingSettings();

	if settings.ungtagTurnedOffCameras {
		GameObject.UntagObject(this);
	}
}

@wrapMethod(SensorDevice)
protected cb func OnDeath(evt: ref<gameDeathEvent>) -> Bool {
	wrappedMethod(evt);

	let settings = new TagOnPingSettings();

	if settings.ungtagTurnedOffCameras {
		GameObject.UntagObject(this);
	}
}