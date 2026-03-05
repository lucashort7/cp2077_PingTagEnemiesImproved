
import PingTagEnemiesImproved.*


@wrapMethod(ScanningComponent)
protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) -> Bool {
  FTLog(
    "\'------------------- [PingTagEnemiesImproved] [DEBUG] >> ScanningComponent::OnRevealStateChanged() Triggered!"
  );
  return wrappedMethod(evt);

  // let state = wrappedMethod(evt);
  // let owner: ref<GameObject> = this.GetOwner();

  // // We only want to tag at the start of the ping
  // if !Equals(evt.state, ERevealState.STARTED) {
  //   return state;
  // }
  // // If the target is already tagged then there's nothing to do
  // if owner.IsTaggedinFocusMode() {
  //   return state;
  // }
  // // Wthout this check we will end up tagging people highlighted by optics cyberware
  // if !(Equals(evt.reason.reason, n"network") || Equals(evt.reason.reason, n"PingQuickhack")) {
  //   return state;
  // }

  // // let settings = new PingTagSettings();
  // let svc = GameInstance
  //   .GetScriptableServiceContainer()
  //   .GetService(n"PingTagEnemiesImproved.PingTagService") as PingTagService;    // TODO: check this approach: let pti = PingTagSettings.GetInstance();                                      

  // // Skip if target is a camera that is turned off
  // if svc.pti.preventTaggingInactiveCameras {
  //   let sensorDevice: ref<SensorDevice> = owner as SensorDevice;
  //   let devicePS = sensorDevice.GetDevicePS();
  //   if IsDefined(sensorDevice) && !devicePS.IsON() {
  //     return state;
  //   }
  // }

  // if owner.IsNPC() {
  //   if !svc.pti.tagNpcs {
  //     return state;
  //   }
  // } else if owner.IsAccessPoint() {
  //   if !svc.pti.tagAccessPoints {
  //     return state;
  //   }
  // } else if owner.IsSensor() {
  //   if !svc.pti.tagCameras {
  //     return state;
  //   }
  // } else if owner.IsTurret() {
  //   if !svc.pti.tagTurrets {
  //     return state;
  //   }
  // } else {
  //   // Some computers function as hackable access points - we have to handle them
  //   // separately from regular access points
  //   if !svc.pti.tagHackableComputers {
  //     return state;
  //   }

  //   let deviceBase: ref<DeviceBase> = owner as DeviceBase;
  //   if !IsDefined(deviceBase) || !deviceBase.IsActiveBackdoor() {
  //     return state;
  //   }
  // }

  // GameObject.TagObject(owner);

  // return state;
}

@wrapMethod(SensorDevice)
protected func TurnOffDevice() -> Void {
  FTLog(
    "\'------------------- [PingTagEnemiesImproved] [DEBUG] >> TurnOffDevice() Triggered!"
  );

  wrappedMethod();

  // let svc = GameInstance
  //   .GetScriptableServiceContainer()
  //   .GetService(n"PingTagEnemiesImproved.PingTagService") as PingTagService;

  // if svc.pti.ungtagTurnedOffCameras {
  //   GameObject.UntagObject(this);
  // }
}

@wrapMethod(SensorDevice)
protected cb func OnDeath(evt: ref<gameDeathEvent>) -> Bool {
  FTLog(
    "\'------------------- [PingTagEnemiesImproved] [DEBUG] >> OnDeath() Triggered!"
  );
  wrappedMethod(evt);

  // let svc = GameInstance
  //   .GetScriptableServiceContainer()
  //   .GetService(n"PingTagEnemiesImproved.PingTagService") as PingTagService;

  // if svc.pti.ungtagTurnedOffCameras {
  //   GameObject.UntagObject(this);
  // }
}

