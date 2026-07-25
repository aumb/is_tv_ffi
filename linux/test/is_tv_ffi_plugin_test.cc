#include <gtest/gtest.h>

#include <cstdlib>  // Required for setenv and unsetenv

// Include the header for the function we want to test
#include "../is_tv_linux.h"

namespace is_tv_ffi {
namespace test {
namespace {

// The build machine may itself be running one of the sessions we detect, so
// every test starts from a known-clean environment.
void ClearTestVariables() {
  unsetenv("FLUTTER_IS_TV");
  unsetenv("XDG_SESSION_DESKTOP");
  unsetenv("XDG_CURRENT_DESKTOP");
  unsetenv("SteamDeck");
}

class IsTvLinux : public ::testing::Test {
 protected:
  void SetUp() override { ClearTestVariables(); }
  void TearDown() override { ClearTestVariables(); }
};

}  // namespace

// Test case for when no specific environment variables are set.
TEST_F(IsTvLinux, ReturnsFalseByDefault) { ASSERT_FALSE(is_tv()); }

// Test case for when the FLUTTER_IS_TV variable is set to "1".
TEST_F(IsTvLinux, ReturnsTrueWhenFlutterIsTvSet) {
  setenv("FLUTTER_IS_TV", "1", 1);

  ASSERT_TRUE(is_tv());
}

// Test case for an invalid value for FLUTTER_IS_TV.
TEST_F(IsTvLinux, ReturnsFalseForInvalidValue) {
  setenv("FLUTTER_IS_TV", "0", 1);

  ASSERT_FALSE(is_tv());
}

// FLUTTER_IS_TV is typed by hand, so its value must not be case-sensitive.
TEST_F(IsTvLinux, AcceptsTruthyValuesRegardlessOfCase) {
  for (const char* value : {"true", "True", "TRUE", "yes", "YES", "On"}) {
    setenv("FLUTTER_IS_TV", value, 1);

    ASSERT_TRUE(is_tv()) << "FLUTTER_IS_TV=" << value;
  }
}

TEST_F(IsTvLinux, ReturnsTrueForSteamBigPictureSession) {
  setenv("XDG_SESSION_DESKTOP", "steam", 1);

  ASSERT_TRUE(is_tv());
}

TEST_F(IsTvLinux, ReturnsTrueForSteamOsSession) {
  setenv("XDG_SESSION_DESKTOP", "steamos", 1);

  ASSERT_TRUE(is_tv());
}

TEST_F(IsTvLinux, ReturnsTrueForGamescopeSession) {
  setenv("XDG_CURRENT_DESKTOP", "gamescope", 1);

  ASSERT_TRUE(is_tv());
}

TEST_F(IsTvLinux, ReturnsTrueOnSteamDeck) {
  setenv("SteamDeck", "1", 1);

  ASSERT_TRUE(is_tv());
}

TEST_F(IsTvLinux, ReturnsFalseForAnOrdinaryDesktopSession) {
  setenv("XDG_SESSION_DESKTOP", "gnome", 1);
  setenv("XDG_CURRENT_DESKTOP", "GNOME", 1);

  ASSERT_FALSE(is_tv());
}

}  // namespace test
}  // namespace is_tv_ffi
