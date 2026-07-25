#include "is_tv_linux.h"

#include <strings.h>

#include <cstdlib>

namespace {

// Environment variables are typed by hand, so accept the spellings people
// actually use rather than only the two the docs happen to mention.
bool IsTruthy(const char* value) {
  return value != nullptr &&
         (strcasecmp(value, "1") == 0 || strcasecmp(value, "true") == 0 ||
          strcasecmp(value, "yes") == 0 || strcasecmp(value, "on") == 0);
}

bool EqualsIgnoreCase(const char* value, const char* expected) {
  return value != nullptr && strcasecmp(value, expected) == 0;
}

// Steam Big Picture and SteamOS gaming sessions. Which variable is set depends
// on the distribution and on the compositor in use.
bool IsSteamBigPictureSession() {
  const char* session_desktop = std::getenv("XDG_SESSION_DESKTOP");
  const char* current_desktop = std::getenv("XDG_CURRENT_DESKTOP");

  return EqualsIgnoreCase(session_desktop, "steam") ||
         EqualsIgnoreCase(session_desktop, "steamos") ||
         EqualsIgnoreCase(current_desktop, "gamescope") ||
         IsTruthy(std::getenv("SteamDeck"));
}

}  // namespace

bool is_tv() {
  return IsTruthy(std::getenv("FLUTTER_IS_TV")) || IsSteamBigPictureSession();
}
