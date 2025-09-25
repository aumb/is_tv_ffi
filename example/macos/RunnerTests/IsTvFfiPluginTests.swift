import XCTest
// Make sure to import the module where your is_tv function is defined.
// For example, if your project is named "MyMacPlugin", you would use:
@testable import is_tv_ffi

final class IsTvFfiPluginTests: XCTestCase {
    func testIsTvFunction_AlwaysReturnsFalseOnMac() throws {
        let result = is_tv()
        
        XCTAssertFalse(result, "The is_tv() function should always return false on macOS.")
    }

}
