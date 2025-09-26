// is_tv_ffi/linux/is_tv_linux.cc

#include "is_tv_linux.h"
#include <cstdlib>
#include <string.h>

bool is_tv() {
  const char *env_is_tv = std::getenv("FLUTTER_IS_TV");
  if (env_is_tv != nullptr &&
      (strcmp(env_is_tv, "1") == 0 || strcmp(env_is_tv, "true") == 0)) {
    return true;
  }

  const char *env_xdg_desktop = std::getenv("XDG_SESSION_DESKTOP");
  if (env_xdg_desktop != nullptr && strcmp(env_xdg_desktop, "steam") == 0) {
    return true;
  }

  return false;
}