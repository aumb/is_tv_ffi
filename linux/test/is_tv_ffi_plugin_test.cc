#include <cstdlib> // Required for setenv and unsetenv
#include <gtest/gtest.h>

// Include the header for the function we want to test
#include "../is_tv_linux.h"

namespace is_tv_ffi {
namespace test {

// Test case for when no specific environment variables are set.
TEST(IsTvLinux, IsTvReturnsFalseByDefault) {
  // Ensure any test variables are cleared before running.
  unsetenv("FLUTTER_IS_TV");

  // Expect the function to return false when no TV indicators are present.
  ASSERT_FALSE(is_tv());
}

// Test case for when the FLUTTER_IS_TV variable is set to "1".
TEST(IsTvLinux, IsTvReturnsTrueWhenFlutterIsTvSet) {
  // Set the environment variable to simulate a TV environment.
  setenv("FLUTTER_IS_TV", "1", 1);

  // Expect the function to return true.
  ASSERT_TRUE(is_tv());

  // Clean up the environment variable after the test.
  unsetenv("FLUTTER_IS_TV");
}

// Test case for an invalid value for FLUTTER_IS_TV.
TEST(IsTvLinux, IsTvReturnsFalseForInvalidValue) {
  // Set an invalid value.
  setenv("FLUTTER_IS_TV", "0", 1);

  // Expect it to return false.
  ASSERT_FALSE(is_tv());

  // Clean up.
  unsetenv("FLUTTER_IS_TV");
}

} // namespace test
} // namespace is_tv_ffi