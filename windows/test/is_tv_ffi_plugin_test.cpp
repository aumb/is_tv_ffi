#include <cstdlib>
#include <gtest/gtest.h>

// Include the header for the function we are testing.
// The .. means "go up one directory" from test/ to windows/.
#include "../is_tv_windows.h"

namespace is_tv_ffi {
namespace test {

// A helper function to clean up environment variables after tests.
void clear_test_variables() {
  _putenv_s("FLUTTER_IS_TV", "");
  _putenv_s("USERNAME", "");
}

// Test case for the default scenario where no TV-related variables are set.
TEST(IsTvWindows, IsTvReturnsFalseByDefault) {
  clear_test_variables();
  ASSERT_FALSE(is_tv());
}

// Test case for when the FLUTTER_IS_TV variable is set to "1".
TEST(IsTvWindows, IsTvReturnsTrueWhenFlutterIsTvSet) {
  // Set the environment variable to simulate a TV environment.
  _putenv_s("FLUTTER_IS_TV", "1");
  ASSERT_TRUE(is_tv());
  clear_test_variables(); // Clean up
}

// Test case for when the USERNAME suggests an Xbox environment.
TEST(IsTvWindows, IsTvReturnsTrueWhenUsernameIsSystem) {
  // Set the environment variable to simulate an Xbox user.
  _putenv_s("USERNAME", "SYSTEM");
  ASSERT_TRUE(is_tv());
  clear_test_variables(); // Clean up
}

// Test case for an invalid value for the FLUTTER_IS_TV variable.
TEST(IsTvWindows, IsTvReturnsFalseForInvalidValue) {
  _putenv_s("FLUTTER_IS_TV", "false");
  ASSERT_FALSE(is_tv());
  clear_test_variables(); // Clean up
}

} // namespace test
} // namespace is_tv_ffi