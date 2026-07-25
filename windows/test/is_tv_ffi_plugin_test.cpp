#include <gtest/gtest.h>

#include <cstdlib>

#include "../is_tv_windows.h"

namespace is_tv_ffi {
namespace test {
namespace {

// Setting a variable to the empty string removes it on Windows.
void ClearTestVariables() { _putenv_s("FLUTTER_IS_TV", ""); }

class IsTvWindows : public ::testing::Test {
 protected:
  void SetUp() override { ClearTestVariables(); }
  void TearDown() override { ClearTestVariables(); }
};

}  // namespace

// Test case for the default scenario where no TV-related variables are set.
TEST_F(IsTvWindows, ReturnsFalseByDefault) { ASSERT_FALSE(is_tv()); }

// Test case for when the FLUTTER_IS_TV variable is set to "1".
TEST_F(IsTvWindows, ReturnsTrueWhenFlutterIsTvSet) {
  _putenv_s("FLUTTER_IS_TV", "1");

  ASSERT_TRUE(is_tv());
}

// Test case for an invalid value for the FLUTTER_IS_TV variable.
TEST_F(IsTvWindows, ReturnsFalseForInvalidValue) {
  _putenv_s("FLUTTER_IS_TV", "false");

  ASSERT_FALSE(is_tv());
}

// FLUTTER_IS_TV is typed by hand, so its value must not be case-sensitive.
TEST_F(IsTvWindows, AcceptsTruthyValuesRegardlessOfCase) {
  for (const char* value : {"true", "True", "TRUE", "yes", "YES", "On"}) {
    _putenv_s("FLUTTER_IS_TV", value);

    ASSERT_TRUE(is_tv()) << "FLUTTER_IS_TV=" << value;
  }
}

}  // namespace test
}  // namespace is_tv_ffi
