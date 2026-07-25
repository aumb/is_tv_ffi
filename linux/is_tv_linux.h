#ifndef IS_TV_LINUX_H_
#define IS_TV_LINUX_H_

#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

// This attribute ensures the function is exported from the shared library.
__attribute__((visibility("default"))) __attribute__((used)) bool is_tv(void);

#ifdef __cplusplus
}
#endif

#endif  // IS_TV_LINUX_H_
