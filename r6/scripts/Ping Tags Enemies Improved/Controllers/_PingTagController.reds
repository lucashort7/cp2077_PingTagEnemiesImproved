
// module PingTagEnemiesImproved.Controllers._PingTagController

// import PingTagEnemiesImproved.*
// import PingTagEnemiesImproved.Handlers.ModSettings.*
// import PingTagEnemiesImproved.Helpers.*
// import PingTagEnemiesImproved.Utils.Logging.*


// public func _DebugOnRevealStateChanged(ctx: String, dvc: ref<GameObject>, evt: ref<RevealStateChangedEvent>) -> Void {
//   FTLog("\n=================================================");
//   FTLogDebug(ctx);
//   FTLogDebug(s"evt:  \(evt.state); \(evt.reason.sourceEntityId); \(evt.reason.reason)");
//   FTLogDebug(s"device:  \(dvc.GetPersistentID()); \(dvc.GetClassName());");
//   FTLog("=================================================\n");
// }



// // -----------------
// // [[ INTERACTIVE MASTER DEVICE ]]
// // -----------------
// // TODO: this.IsBreached -> UntagObject
// @addMethod(AccessPoint)
// protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
//   super.OnRevealStateChanged(evt);

//   // _DebugOnRevealStateChanged("AccessPoint::OnRevealStateChanged()", this, evt);
//   if !IsValidRevealStateChangedEvent(evt, this.IsTaggedinFocusMode()) { 
//     return; 
//   }
  
//   let settings: ref<PingTagSettings> = _PlayerSystem.GetConfigSettings();
//   if settings.enabled && settings.tagAccessPoints { 
//     GameObject.TagObject(this);
//   }
// }

// // TODO: this.IsDestroyed -> UntagObject
// @addMethod(SecurityAlarm)
// protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
//   super.OnRevealStateChanged(evt);
  
//   // _DebugOnRevealStateChanged("SecurityAlarm::OnRevealStateChanged()", this, evt);
//   if !IsValidRevealStateChangedEvent(evt, this.IsTaggedinFocusMode()) { 
//     return; 
//   }

//   let settings: ref<PingTagSettings> = _PlayerSystem.GetConfigSettings();
//   if settings.enabled && settings.tagAlarms { 
//     GameObject.TagObject(this);
//   }
// }


// // -----------------
// // [[ SENSOR DEVICE ]]
// // -----------------
// @addMethod(SurveillanceCamera)
// protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
//   super.OnRevealStateChanged(evt);
  
//   // _DebugOnRevealStateChanged("SurveillanceCamera::OnRevealStateChanged()", this, evt);
//   if this.GetDevicePS().IsControlledByPlayer() { return; };
//   if !IsValidRevealStateChangedEvent(evt, this.IsTaggedinFocusMode()) { 
//     return; 
//   }

//   let settings: ref<PingTagSettings> = _PlayerSystem.GetConfigSettings();
//   if settings.enabled && settings.tagCameras { 
//     GameObject.TagObject(this);
//   }
// }

// @addMethod(SecurityTurret)
// protected cb func OnRevealStateChanged(evt: ref<RevealStateChangedEvent>) {
//   super.OnRevealStateChanged(evt);

//   // _DebugOnRevealStateChanged("SecurityTurret::OnRevealStateChanged()", this, evt);
//   if this.GetDevicePS().IsControlledByPlayer() { return; };
//   if !IsValidRevealStateChangedEvent(evt, this.IsTaggedinFocusMode()) { 
//     return; 
//   }

//   let settings: ref<PingTagSettings> = _PlayerSystem.GetConfigSettings();
//   if settings.enabled && settings.tagTurrets { 
//     GameObject.TagObject(this);
//   }
// }

// @wrapMethod(SensorDevice)
// protected func TurnOffDevice() -> Void {
//   wrappedMethod();
//   GameObject.UntagObject(this);
// }

// @wrapMethod(SensorDevice)
// protected cb func OnDeath(evt: ref<gameDeathEvent>) -> Bool {
//   let state = wrappedMethod(evt);
//   GameObject.UntagObject(this);
//   return state;
// }

// @wrapMethod(SensorDevice)
// protected cb func OnAttitudeChanged(evt: ref<AttitudeChangedEvent>) -> Bool {
//   let state = wrappedMethod(evt);
//   GameObject.UntagObject(this);
//   return state;
// }


// -----------------------------------------------------------
// -----------------------------------------------------------
// -----------------------------------------------------------
// -----------------------------------------------------------
// -----------------------------------------------------------

// @wrapMethod(DeviceLinkComponentPS)
// public const final func PingDevicesNetwork() -> Void {
//   let networkSystem = _NetworkSystem.GetNetworkSystem();
//   let player: ref<PlayerPuppet> = _PlayerSystem.GetPlayerSystem().GetPlayer();
//   let m_lastPingSourceID = networkSystem.GetLastPingSourceID();
//   networkSystem.
//   FTLog("\n=================================================");
//   FTLogDebug(s"player.pti.lastKnownPingSourceID: \(player.pti.lastKnownPingSourceID)");
//   FTLogDebug(s"networkSystem.m_lastPingSourceID: \(m_lastPingSourceID)");

//   if !EntityID.IsDefined(player.pti.lastKnownPingSourceID) || !Equals(player.pti.lastKnownPingSourceID, m_lastPingSourceID) {
//     FTLogDebug("New lastPingSourceID!");
//     player.pti.lastKnownPingSourceID = m_lastPingSourceID;
//     player.pti.knownTaggedObjs = 0;
//     // _FocusModeTaggingSystem.UntagAll();
//   } else {
//     FTLogDebug("Already known lastPingSourceID!");
//   } 
  
//   wrappedMethod();
// }


// @wrapMethod(ScriptedPuppet)
// protected func StartPingingNetwork() -> Void {
//   let player: ref<PlayerPuppet> = _PlayerSystem.GetPlayerSystem().GetPlayer();
//   player.pti.lastKnownPingSourceID = this.GetNetworkSystem().GetLastPingSourceID();
//   player.pti.knownTaggedObjs = 0;
//   _FocusModeTaggingSystem.UntagAll();
//   FTLogDebug(s"\(this.GetPersistentID())");
//   FTLogDebug(s"\(this.GetClassName())");
//   FTLogDebug(s"\(this.GetPSClassName())");

//   wrappedMethod();
// }


// @wrapMethod(PuppetDeviceLinkPS)
// public final const func PingSquadNetwork() -> Void {
//   FTLogDebug("PuppetDeviceLinkPS::PingSquadNetwork()");
//   let player: ref<PlayerPuppet> = _PlayerSystem.GetPlayerSystem().GetPlayer();
//   player.pti.lastKnownPingSourceID = this.GetNetworkSystem().GetLastPingSourceID();
//   player.pti.knownTaggedObjs = 0;
//   _FocusModeTaggingSystem.UntagAll();
//   FTLogDebug(s"\(this.GetID())");
//   FTLogDebug(s"\(this.GetClassName())");
//   // FTLogDebug(s"\(this.GetPSClassName())");
  
// }