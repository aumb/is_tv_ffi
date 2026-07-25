import Foundation
import UIKit

public protocol DeviceIdiomProvider {
    var userInterfaceIdiom: UIUserInterfaceIdiom { get }
}

extension UIDevice: DeviceIdiomProvider {}

public class DeviceChecker {
    private let device: DeviceIdiomProvider

    public init(device: DeviceIdiomProvider = UIDevice.current) {
        self.device = device
    }

    public func isTV() -> Bool {
        return device.userInterfaceIdiom == .tv
    }
}

@_cdecl("is_tv")
public func is_tv() -> Bool {
    return DeviceChecker().isTV()
}
