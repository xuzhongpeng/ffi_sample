

   
#include <cstdint>
#include <android/log.h>
#include <functional>
#include "internal/dart_api_dl.h"

#define  LOG_D(...)  __android_log_print(ANDROID_LOG_DEBUG, "FFI",__VA_ARGS__)
#define  LOG_E(...)  __android_log_print(ANDROID_LOG_DEBUG, "FFI",__VA_ARGS__)

typedef std::function<void()> Work;


DART_EXPORT intptr_t InitDartApiDL(void *data);

void NotifyDart(Dart_Port send_port, const Work *work);

DART_EXPORT void ExecuteCallback(Work *work_ptr);
