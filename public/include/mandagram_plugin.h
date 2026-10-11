#ifndef MANDAGRAM_PLUGIN_H
#define MANDAGRAM_PLUGIN_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef void* jobject;
typedef jobject jclass;
typedef jobject jstring;
typedef jobject jarray;
typedef jobject jobjectArray;
typedef void* jfieldID;
typedef void* jmethodID;
typedef int32_t jint;
typedef int64_t jlong;
typedef uint8_t jboolean;
typedef float jfloat;
typedef double jdouble;

typedef struct HookParam {
    void*    env;
    void*    this_ptr;
    void**   args;
    uint32_t args_count;
    uint32_t padding;
    void*    result;
    uint8_t  return_early;
    uint8_t  has_result;
    uint16_t reserved;
} HookParam;

typedef void (*HookBeforeFn)(HookParam* param);
typedef void (*HookAfterFn)(HookParam* param);

typedef struct JniScope {
    void* env;
    uint8_t active;
} JniScope;

typedef struct PluginMetadata {
    const char* name;
    const char* version;
    const char* author;
    const char* description;
} PluginMetadata;

typedef const PluginMetadata* (*PluginMetadataFn)(void);

typedef void (*ComposableFn)(void* env, jobject composer, uintptr_t user_data);
typedef void (*ScopedComposableFn)(void* env, jobject scope, jobject composer, uintptr_t user_data);

typedef bool (*UpdateHookFn)(const char* update_json, uintptr_t user_data);
typedef const char* (*MessageBeforeSendFn)(int64_t chat_id, const char* text, uintptr_t user_data);
typedef void (*MessageAfterSendFn)(int64_t chat_id, int64_t message_id, uintptr_t user_data);
typedef void (*MessageReceiveFn)(int64_t chat_id, int64_t message_id, const char* text, uintptr_t user_data);
typedef void (*ChatActionClickFn)(int64_t chat_id, uintptr_t user_data);

typedef struct PluginApi {
    int32_t (*register_hook)(
        const char* class_name,
        const char* method_name,
        const char* method_descriptor,
        HookBeforeFn before_cb,
        HookAfterFn after_cb
    );
    void (*log_info)(const char* tag, const char* msg);
    void (*log_error)(const char* tag, const char* msg);
    int32_t (*get_storage_dir)(const char* plugin_name, char* out_buf, uint32_t max_len);
    int32_t (*get_cache_dir)(const char* plugin_name, char* out_buf, uint32_t max_len);
    int32_t (*resolve_asset)(const char* plugin_name, const char* asset_name, char* out_buf, uint32_t max_len);
    int64_t (*get_current_user_id)(void);
    int64_t (*get_active_chat_id)(void);
    int32_t (*execute_tdlib_query)(const char* json_query, char* out_buf, uint32_t max_len);
    jobject (*create_composable_lambda)(ComposableFn cb, uintptr_t user_data);
    jobject (*create_scoped_lambda)(ScopedComposableFn cb, uintptr_t user_data);
    void (*replace_composable)(HookParam* param, ComposableFn cb, uintptr_t user_data);
    void (*composer_start_group)(jobject composer, int32_t key);
    void (*composer_end_group)(jobject composer);
    jobject (*composer_get_remembered)(jobject composer);
    void (*composer_set_remembered)(jobject composer, jobject val);
    bool (*composer_is_skipping)(jobject composer);

    /* Высокоуровневые хуки реестра MandaGram (HookRegistry) */
    int32_t (*register_update_hook)(UpdateHookFn cb, uintptr_t user_data);
    int32_t (*register_message_send_hook)(MessageBeforeSendFn before_cb, MessageAfterSendFn after_cb, uintptr_t user_data);
    int32_t (*register_message_receive_hook)(MessageReceiveFn cb, uintptr_t user_data);
    int32_t (*register_chat_action)(const char* id, const char* label, ChatActionClickFn click_cb, uintptr_t user_data);
} PluginApi;

#ifdef _WIN32
#define PLUGIN_EXPORT __declspec(dllexport)
#else
#define PLUGIN_EXPORT __attribute__((visibility("default")))
#endif

typedef bool (*PluginInitFn)(const PluginApi* api);

#ifdef __cplusplus
}
#endif

#endif
