import XCTest
@testable import is_tv_ffi

class MockDevice: DeviceIdiomProvider {
    var mockUserInterfaceIdiom: UIUserInterfaceIdiom

    init(idiom: UIUserInterfaceIdiom) {
        self.mockUserInterfaceIdiom = idiom
    }

    var userInterfaceIdiom: UIUserInterfaceIdiom {
        return mockUserInterfaceIdiom
    }
}

class IsTvFfiPluginTests: XCTestCase {

    func testIsTV_WhenIdiomIsTV_ReturnsTrue() {
        let mockDevice = MockDevice(idiom: .tv)
        let deviceChecker = DeviceChecker(device: mockDevice)

        let result = deviceChecker.isTV()

        XCTAssertTrue(result, "isTV() should return true when the user interface idiom is .tv")
    }

    func testIsTV_WhenIdiomIsPhone_ReturnsFalse() {
        let mockDevice = MockDevice(idiom: .phone)
        let deviceChecker = DeviceChecker(device: mockDevice)

        let result = deviceChecker.isTV()

        XCTAssertFalse(result, "isTV() should return false when the user interface idiom is .phone")
    }

    func testIsTV_WhenIdiomIsPad_ReturnsFalse() {
        let mockDevice = MockDevice(idiom: .pad)
        let deviceChecker = DeviceChecker(device: mockDevice)

        let result = deviceChecker.isTV()

        XCTAssertFalse(result, "isTV() should return false when the user interface idiom is .pad")
    }
}
