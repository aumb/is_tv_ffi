#include "is_tv_windows.h"
#include <cstdlib>

bool is_tv() {
  char *env_value;
  size_t len;

  if (_dupenv_s(&env_value, &len, "FLUTTER_IS_TV") == 0 &&
      env_value != nullptr) {
    bool is_tv_flag =
        (strcmp(env_value, "1") == 0 || strcmp(env_value, "true") == 0);
    free(env_value);
    if (is_tv_flag) {
      return true;
    }
  }

  // 2. Heuristic Check: Apps running on Xbox often run under the "System"
  //    user account in certain configurations. This is a good hint.
  if (_dupenv_s(&env_value, &len, "USERNAME") == 0 && env_value != nullptr) {
    bool is_system_user = (strcmp(env_value, "SYSTEM") == 0);
    free(env_value);
    if (is_system_user) {
      return true;
    }
  }

  return false;
}