#include <stdbool.h>

#ifdef _WIN32
// If we are compiling on Windows, we want to export the function from the DLL.
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
// On other platforms (like when ffigen is parsing on macOS), we just declare a
// standard external function. The attribute is not needed.
#define FFI_PLUGIN_EXPORT
#endif

#ifdef __cplusplus
extern "C" {
#endif

// Now our function is declared with the macro.
FFI_PLUGIN_EXPORT bool is_tv();

#ifdef __cplusplus
}
#endif