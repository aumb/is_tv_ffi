// The C ABI shared by every native implementation of this plugin.
//
// iOS and macOS define `is_tv` in Swift via `@_cdecl`, Linux and Windows define
// it in C++. All four expose the same signature, so this header is the single
// ffigen entry point for `lib/src/platforms/native/bindings.dart`.
//
// It is not part of any native build; the platform headers next to each
// implementation carry the export attributes those builds need.

#ifndef IS_TV_H_
#define IS_TV_H_

#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

bool is_tv(void);

#ifdef __cplusplus
}
#endif

#endif  // IS_TV_H_
