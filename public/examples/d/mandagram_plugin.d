module mandagram_plugin;

import core.stdc.stdint;
import core.stdc.stdio;
import core.stdc.string;

extern(C):

alias jobject = void*;
alias jclass = jobject;
alias jstring = jobject;
alias jmethodID = void*;
alias jfieldID = void*;
alias jboolean = uint8_t;
alias jint = int32_t;
alias jlong = int64_t;
alias jfloat = float;

struct JNINativeInterface {
    void* reserved0;
    void* reserved1;
    void* reserved2;
    void* reserved3;
    jint function(void* env) GetVersion;
    void* DefineClass;
    jclass function(void* env, const(char)* name) FindClass;
    void* FromReflectedMethod;
    void* FromReflectedField;
    void* ToReflectedMethod;
    void* GetSuperclass;
    void* IsAssignableFrom;
    void* ToReflectedField;
    void* Throw;
    void* ThrowNew;
    void* ExceptionOccurred;
    void* ExceptionDescribe;
    void function(void* env) ExceptionClear;
    void* FatalError;
    jint function(void* env, jint capacity) PushLocalFrame;
    jobject function(void* env, jobject result) PopLocalFrame;
    jobject function(void* env, jobject obj) NewGlobalRef;
    void function(void* env, jobject obj) DeleteGlobalRef;
    void function(void* env, jobject obj) DeleteLocalRef;
    void* IsSameObject;
    void* NewLocalRef;
    void* EnsureLocalCapacity;
    void* AllocObject;
    void* NewObject;
    void* NewObjectA;
    void* NewObjectV;
    jclass function(void* env, jobject obj) GetObjectClass;
    jboolean function(void* env, jobject obj, jclass clazz) IsInstanceOf;
    jmethodID function(void* env, jclass clazz, const(char)* name, const(char)* sig) GetMethodID;
    jobject function(void* env, jobject obj, jmethodID methodID, ...) CallObjectMethod;
    void* CallObjectMethodV;
    void* CallObjectMethodA;
    jboolean function(void* env, jobject obj, jmethodID methodID, ...) CallBooleanMethod;
    void* CallBooleanMethodV;
    void* CallBooleanMethodA;
    void* CallByteMethod;
    void* CallByteMethodV;
    void* CallByteMethodA;
    void* CallCharMethod;
    void* CallCharMethodV;
    void* CallCharMethodA;
    void* CallShortMethod;
    void* CallShortMethodV;
    void* CallShortMethodA;
    jint function(void* env, jobject obj, jmethodID methodID, ...) CallIntMethod;
    void* CallIntMethodV;
    void* CallIntMethodA;
    jlong function(void* env, jobject obj, jmethodID methodID, ...) CallLongMethod;
    void* CallLongMethodV;
    void* CallLongMethodA;
    jfloat function(void* env, jobject obj, jmethodID methodID, ...) CallFloatMethod;
    void* CallFloatMethodV;
    void* CallFloatMethodA;
    void* CallDoubleMethod;
    void* CallDoubleMethodV;
    void* CallDoubleMethodA;
    void function(void* env, jobject obj, jmethodID methodID, ...) CallVoidMethod;
    void* CallVoidMethodV;
    void* CallVoidMethodA;
    void* CallNonvirtualObjectMethod;
    void* CallNonvirtualObjectMethodV;
    void* CallNonvirtualObjectMethodA;
    void* CallNonvirtualBooleanMethod;
    void* CallNonvirtualBooleanMethodV;
    void* CallNonvirtualBooleanMethodA;
    void* CallNonvirtualByteMethod;
    void* CallNonvirtualByteMethodV;
    void* CallNonvirtualByteMethodA;
    void* CallNonvirtualCharMethod;
    void* CallNonvirtualCharMethodV;
    void* CallNonvirtualCharMethodA;
    void* CallNonvirtualShortMethod;
    void* CallNonvirtualShortMethodV;
    void* CallNonvirtualShortMethodA;
    void* CallNonvirtualIntMethod;
    void* CallNonvirtualIntMethodV;
    void* CallNonvirtualIntMethodA;
    void* CallNonvirtualLongMethod;
    void* CallNonvirtualLongMethodV;
    void* CallNonvirtualLongMethodA;
    void* CallNonvirtualFloatMethod;
    void* CallNonvirtualFloatMethodV;
    void* CallNonvirtualFloatMethodA;
    void* CallNonvirtualDoubleMethod;
    void* CallNonvirtualDoubleMethodV;
    void* CallNonvirtualDoubleMethodA;
    void* CallNonvirtualVoidMethod;
    void* CallNonvirtualVoidMethodV;
    void* CallNonvirtualVoidMethodA;
    jfieldID function(void* env, jclass clazz, const(char)* name, const(char)* sig) GetFieldID;
    jobject function(void* env, jobject obj, jfieldID fieldID) GetObjectField;
    jboolean function(void* env, jobject obj, jfieldID fieldID) GetBooleanField;
    void* GetByteField;
    void* GetCharField;
    void* GetShortField;
    jint function(void* env, jobject obj, jfieldID fieldID) GetIntField;
    jlong function(void* env, jobject obj, jfieldID fieldID) GetLongField;
    jfloat function(void* env, jobject obj, jfieldID fieldID) GetFloatField;
    void* GetDoubleField;
    void function(void* env, jobject obj, jfieldID fieldID, jobject val) SetObjectField;
    void function(void* env, jobject obj, jfieldID fieldID, jboolean val) SetBooleanField;
    void* SetByteField;
    void* SetCharField;
    void* SetShortField;
    void function(void* env, jobject obj, jfieldID fieldID, jint val) SetIntField;
    void function(void* env, jobject obj, jfieldID fieldID, jlong val) SetLongField;
    void* SetFloatField;
    void* SetDoubleField;
    jmethodID function(void* env, jclass clazz, const(char)* name, const(char)* sig) GetStaticMethodID;
    jobject function(void* env, jclass clazz, jmethodID methodID, ...) CallStaticObjectMethod;
    void* CallStaticObjectMethodV;
    void* CallStaticObjectMethodA;
    jboolean function(void* env, jclass clazz, jmethodID methodID, ...) CallStaticBooleanMethod;
    void* CallStaticBooleanMethodV;
    void* CallStaticBooleanMethodA;
    void* CallStaticByteMethod;
    void* CallStaticByteMethodV;
    void* CallStaticByteMethodA;
    void* CallStaticCharMethod;
    void* CallStaticCharMethodV;
    void* CallStaticCharMethodA;
    void* CallStaticShortMethod;
    void* CallStaticShortMethodV;
    void* CallStaticShortMethodA;
    jint function(void* env, jclass clazz, jmethodID methodID, ...) CallStaticIntMethod;
    void* CallStaticIntMethodV;
    void* CallStaticIntMethodA;
    jlong function(void* env, jclass clazz, jmethodID methodID, ...) CallStaticLongMethod;
    void* CallStaticLongMethodV;
    void* CallStaticLongMethodA;
    void* CallStaticFloatMethod;
    void* CallStaticFloatMethodV;
    void* CallStaticFloatMethodA;
    void* CallStaticDoubleMethod;
    void* CallStaticDoubleMethodV;
    void* CallStaticDoubleMethodA;
    void function(void* env, jclass clazz, jmethodID methodID, ...) CallStaticVoidMethod;
    void* CallStaticVoidMethodV;
    void* CallStaticVoidMethodA;
    jfieldID function(void* env, jclass clazz, const(char)* name, const(char)* sig) GetStaticFieldID;
    jobject function(void* env, jclass clazz, jfieldID fieldID) GetStaticObjectField;
    void* GetStaticBooleanField;
    void* GetStaticByteField;
    void* GetStaticCharField;
    void* GetStaticShortField;
    void* GetStaticIntField;
    void* GetStaticLongField;
    void* GetStaticFloatField;
    void* GetStaticDoubleField;
    void* SetStaticObjectField;
    void* SetStaticBooleanField;
    void* SetStaticByteField;
    void* SetStaticCharField;
    void* SetStaticShortField;
    void* SetStaticIntField;
    void* SetStaticLongField;
    void* SetStaticFloatField;
    void* SetStaticDoubleField;

    void* NewString;
    void* GetStringLength;
    void* GetStringChars;
    void* ReleaseStringChars;

    jstring function(void* env, const(char)* utf) NewStringUTF;
    jint function(void* env, jstring str) GetStringUTFLength;
    const(char)* function(void* env, jstring str, jboolean* isCopy) GetStringUTFChars;
    void function(void* env, jstring str, const(char)* utf) ReleaseStringUTFChars;

    jint function(void* env, jobject array) GetArrayLength;
    jobject function(void* env, jint len, jclass clazz, jobject init) NewObjectArray;
    jobject function(void* env, jobject array, jint index) GetObjectArrayElement;
    void function(void* env, jobject array, jint index, jobject val) SetObjectArrayElement;
}

alias JNIEnv = const(JNINativeInterface)**;

struct HookParam {
    void* env;
    void* this_ptr;
    void** args;
    uint32_t args_count;
    uint32_t padding;
    void* result;
    uint8_t return_early;
    uint8_t has_result;
    uint16_t reserved;

    JNIEnv getEnv() {
        return cast(JNIEnv) env;
    }
}

alias HookBeforeFn = void function(HookParam* param);
alias HookAfterFn = void function(HookParam* param);

alias ComposableFn = void function(void* env, jobject composer, size_t user_data);
alias ScopedComposableFn = void function(void* env, jobject scope_obj, jobject composer, size_t user_data);

struct PluginMetadata {
    const(char)* name;
    const(char)* version_;
    const(char)* author;
    const(char)* description;
}

struct PluginApi {
    int32_t function(
        const(char)* class_name,
        const(char)* method_name,
        const(char)* method_descriptor,
        HookBeforeFn before_cb,
        HookAfterFn after_cb
    ) register_hook;
    void function(const(char)* tag, const(char)* msg) log_info;
    void function(const(char)* tag, const(char)* msg) log_error;
    int32_t function(const(char)* plugin_name, char* out_buf, uint32_t max_len) get_storage_dir;
    int32_t function(const(char)* plugin_name, char* out_buf, uint32_t max_len) get_cache_dir;
    int32_t function(const(char)* plugin_name, const(char)* asset_name, char* out_buf, uint32_t max_len) resolve_asset;
    int64_t function() get_current_user_id;
    int64_t function() get_active_chat_id;
    int32_t function(const(char)* json_query, char* out_buf, uint32_t max_len) execute_tdlib_query;
    jobject function(ComposableFn cb, size_t user_data) create_composable_lambda;
    jobject function(ScopedComposableFn cb, size_t user_data) create_scoped_lambda;
    void function(HookParam* param, ComposableFn cb, size_t user_data) replace_composable;
    void function(jobject composer, int32_t key) composer_start_group;
    void function(jobject composer) composer_end_group;
    jobject function(jobject composer) composer_get_remembered;
    void function(jobject composer, jobject val) composer_set_remembered;
    bool function(jobject composer) composer_is_skipping;
}
