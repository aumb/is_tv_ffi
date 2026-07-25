#include "is_tv_windows.h"

#include <cstdlib>
#include <cstring>

namespace {

// Environment variables are typed by hand, so accept the spellings people
// actually use rather than only the two the docs happen to mention.
bool IsTruthy(const char* value) {
  return value != nullptr &&
         (_stricmp(value, "1") == 0 || _stricmp(value, "true") == 0 ||
          _stricmp(value, "yes") == 0 || _stricmp(value, "on") == 0);
}

}  // namespace

bool is_tv() {
  char* env_value = nullptr;
  size_t len = 0;

  if (_dupenv_s(&env_value, &len, "FLUTTER_IS_TV") != 0) {
    return false;
  }

  const bool result = IsTruthy(env_value);
  free(env_value);

  return result;
}
