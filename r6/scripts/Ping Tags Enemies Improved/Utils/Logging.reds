module PingTagEnemiesImproved.Utils.Logging


public func FTLogDebug(msg: script_ref<String>){
    let ts = DateTime.Now().Format("%Y-%m-%d %H:%M:%S");
    FTLog(s"'----~ [\(ts) | DEBUG | PingTagEnemiesImproved] >> \(msg)");
}

// public func FTLogDebug(msg: script_ref<String>){
//     FTLog(s"'----~ [DEBUG | PingTagEnemiesImproved] >> \(msg)");
// }