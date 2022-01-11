#include "ffi_async_utils.h"

// Initialize `dart_api_dl.h`
DART_EXPORT intptr_t InitDartApiDL(void *data) {
    LOG_D("InitDartApiDL");
    return Dart_InitializeApiDL(data);
}

// Notify Dart through a port that the C lib has pending async callbacks.
//
// Expects heap allocated `work` so delete can be called on it.
//
// The `send_port` should be from the isolate which registered the callback.
void NotifyDart(Dart_Port send_port, const Work *work) {
    const auto work_address = reinterpret_cast<intptr_t>(work);

    Dart_CObject dart_object;
    dart_object.type = Dart_CObject_kInt64;
    dart_object.value.as_int64 = work_address;

    const bool result = Dart_PostCObject_DL(send_port, &dart_object);
    if (!result) {
        LOG_D("FFI C  :  Posting message to port failed.");
    }
    LOG_E("NotifyDart");
}

DART_EXPORT void ExecuteCallback(Work *work_ptr) {
    const Work work = *work_ptr;
    work();
    delete work_ptr;
}