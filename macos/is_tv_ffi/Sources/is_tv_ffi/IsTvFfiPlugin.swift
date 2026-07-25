import Foundation

public class DeviceChecker {
    public init() {}
    
    public func isTV() -> Bool {
        return false
    }
}

@_cdecl("is_tv")
public func is_tv() -> Bool {
    return DeviceChecker().isTV()
}
