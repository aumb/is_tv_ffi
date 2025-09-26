#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

// This attribute ensures the function is exported from the shared library.
__attribute__((visibility("default"))) __attribute__((used))
bool is_tv();

#ifdef __cplusplus
}
#endif
