#ifndef JNI_ACCESSOR_H
#define JNI_ACCESSOR_H

#include "mandagram_plugin.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct JNINativeInterface_ JNINativeInterface;
typedef const JNINativeInterface* JNIEnv;

struct JNINativeInterface_ {
    void* reserved0;
    void* reserved1;
    void* reserved2;
    void* reserved3;

    jint (*GetVersion)(JNIEnv*);
    void* DefineClass;
    jclass (*FindClass)(JNIEnv*, const char*);
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
    void (*ExceptionClear)(JNIEnv*);
    void* FatalError;

    void* PushLocalFrame;
    void* PopLocalFrame;
    jobject (*NewGlobalRef)(JNIEnv*, jobject);
    void (*DeleteGlobalRef)(JNIEnv*, jobject);
    void (*DeleteLocalRef)(JNIEnv*, jobject);
    void* IsSameObject;
    void* NewLocalRef;
    void* EnsureLocalCapacity;

    void* AllocObject;
    void* NewObject;
    void* NewObjectA;
    void* NewObjectV;

    jclass (*GetObjectClass)(JNIEnv*, jobject);
    void* IsInstanceOf;
    jmethodID (*GetMethodID)(JNIEnv*, jclass, const char*, const char*);

    jobject (*CallObjectMethod)(JNIEnv*, jobject, jmethodID, ...);
    void* CallObjectMethodA;
    void* CallObjectMethodV;
    jboolean (*CallBooleanMethod)(JNIEnv*, jobject, jmethodID, ...);
    void* CallBooleanMethodA;
    void* CallBooleanMethodV;
    void* CallByteMethod;
    void* CallByteMethodA;
    void* CallByteMethodV;
    void* CallCharMethod;
    void* CallCharMethodA;
    void* CallCharMethodV;
    void* CallShortMethod;
    void* CallShortMethodA;
    void* CallShortMethodV;
    jint (*CallIntMethod)(JNIEnv*, jobject, jmethodID, ...);
    void* CallIntMethodA;
    void* CallIntMethodV;
    jlong (*CallLongMethod)(JNIEnv*, jobject, jmethodID, ...);
    void* CallLongMethodA;
    void* CallLongMethodV;
    void* CallFloatMethod;
    void* CallFloatMethodA;
    void* CallFloatMethodV;
    void* CallDoubleMethod;
    void* CallDoubleMethodA;
    void* CallDoubleMethodV;
    void (*CallVoidMethod)(JNIEnv*, jobject, jmethodID, ...);
    void* CallVoidMethodA;
    void* CallVoidMethodV;

    void* CallNonvirtualObjectMethod;
    void* CallNonvirtualObjectMethodA;
    void* CallNonvirtualObjectMethodV;
    void* CallNonvirtualBooleanMethod;
    void* CallNonvirtualBooleanMethodA;
    void* CallNonvirtualBooleanMethodV;
    void* CallNonvirtualByteMethod;
    void* CallNonvirtualByteMethodA;
    void* CallNonvirtualByteMethodV;
    void* CallNonvirtualCharMethod;
    void* CallNonvirtualCharMethodA;
    void* CallNonvirtualCharMethodV;
    void* CallNonvirtualShortMethod;
    void* CallNonvirtualShortMethodA;
    void* CallNonvirtualShortMethodV;
    void* CallNonvirtualIntMethod;
    void* CallNonvirtualIntMethodA;
    void* CallNonvirtualIntMethodV;
    void* CallNonvirtualLongMethod;
    void* CallNonvirtualLongMethodA;
    void* CallNonvirtualLongMethodV;
    void* CallNonvirtualFloatMethod;
    void* CallNonvirtualFloatMethodA;
    void* CallNonvirtualFloatMethodV;
    void* CallNonvirtualDoubleMethod;
    void* CallNonvirtualDoubleMethodA;
    void* CallNonvirtualDoubleMethodV;
    void* CallNonvirtualVoidMethod;
    void* CallNonvirtualVoidMethodA;
    void* CallNonvirtualVoidMethodV;

    jfieldID (*GetFieldID)(JNIEnv*, jclass, const char*, const char*);
    jobject (*GetObjectField)(JNIEnv*, jobject, jfieldID);
    jboolean (*GetBooleanField)(JNIEnv*, jobject, jfieldID);
    void* GetByteField;
    void* GetCharField;
    void* GetShortField;
    jint (*GetIntField)(JNIEnv*, jobject, jfieldID);
    jlong (*GetLongField)(JNIEnv*, jobject, jfieldID);
    jfloat (*GetFloatField)(JNIEnv*, jobject, jfieldID);
    jdouble (*GetDoubleField)(JNIEnv*, jobject, jfieldID);

    void (*SetObjectField)(JNIEnv*, jobject, jfieldID, jobject);
    void (*SetBooleanField)(JNIEnv*, jobject, jfieldID, jboolean);
    void* SetByteField;
    void* SetCharField;
    void* SetShortField;
    void (*SetIntField)(JNIEnv*, jobject, jfieldID, jint);
    void (*SetLongField)(JNIEnv*, jobject, jfieldID, jlong);
    void (*SetFloatField)(JNIEnv*, jobject, jfieldID, jfloat);
    void (*SetDoubleField)(JNIEnv*, jobject, jfieldID, jdouble);

    jmethodID (*GetStaticMethodID)(JNIEnv*, jclass, const char*, const char*);
    jobject (*CallStaticObjectMethod)(JNIEnv*, jclass, jmethodID, ...);
    void* CallStaticObjectMethodA;
    void* CallStaticObjectMethodV;
    void* CallStaticBooleanMethod;
    void* CallStaticBooleanMethodA;
    void* CallStaticBooleanMethodV;
    void* CallStaticByteMethod;
    void* CallStaticByteMethodA;
    void* CallStaticByteMethodV;
    void* CallStaticCharMethod;
    void* CallStaticCharMethodA;
    void* CallStaticCharMethodV;
    void* CallStaticShortMethod;
    void* CallStaticShortMethodA;
    void* CallStaticShortMethodV;
    jint (*CallStaticIntMethod)(JNIEnv*, jclass, jmethodID, ...);
    void* CallStaticIntMethodA;
    void* CallStaticIntMethodV;
    jlong (*CallStaticLongMethod)(JNIEnv*, jclass, jmethodID, ...);
    void* CallStaticLongMethodA;
    void* CallStaticLongMethodV;
    void* CallStaticFloatMethod;
    void* CallStaticFloatMethodA;
    void* CallStaticFloatMethodV;
    void* CallStaticDoubleMethod;
    void* CallStaticDoubleMethodA;
    void* CallStaticDoubleMethodV;
    void (*CallStaticVoidMethod)(JNIEnv*, jclass, jmethodID, ...);
    void* CallStaticVoidMethodA;
    void* CallStaticVoidMethodV;

    jfieldID (*GetStaticFieldID)(JNIEnv*, jclass, const char*, const char*);
    jobject (*GetStaticObjectField)(JNIEnv*, jclass, jfieldID);
    void* GetStaticBooleanField;
    void* GetStaticByteField;
    void* GetStaticCharField;
    void* GetStaticShortField;
    jint (*GetStaticIntField)(JNIEnv*, jclass, jfieldID);
    jlong (*GetStaticLongField)(JNIEnv*, jclass, jfieldID);
    jfloat (*GetStaticFloatField)(JNIEnv*, jclass, jfieldID);
    jdouble (*GetStaticDoubleField)(JNIEnv*, jclass, jfieldID);

    void (*SetStaticObjectField)(JNIEnv*, jclass, jfieldID, jobject);
    void* SetStaticBooleanField;
    void* SetStaticByteField;
    void* SetStaticCharField;
    void* SetStaticShortField;
    void (*SetStaticIntField)(JNIEnv*, jclass, jfieldID, jint);
    void (*SetStaticLongField)(JNIEnv*, jclass, jfieldID, jlong);
    void (*SetStaticFloatField)(JNIEnv*, jclass, jfieldID, jfloat);
    void (*SetStaticDoubleField)(JNIEnv*, jclass, jfieldID, jdouble);

    void* NewString;
    void* GetStringLength;
    void* GetStringChars;
    void* ReleaseStringChars;
    jstring (*NewStringUTF)(JNIEnv*, const char*);
    jint (*GetStringUTFLength)(JNIEnv*, jstring);
    const char* (*GetStringUTFChars)(JNIEnv*, jstring, jboolean*);
    void (*ReleaseStringUTFChars)(JNIEnv*, jstring, const char*);

    jint (*GetArrayLength)(JNIEnv*, jobject);
    void* NewObjectArray;
    jobject (*GetObjectArrayElement)(JNIEnv*, jobjectArray, jint);
    void (*SetObjectArrayElement)(JNIEnv*, jobjectArray, jint, jobject);
};

static inline jobject jni_get_object_field(JNIEnv* env, jobject obj, const char* name, const char* sig) {
    if (!env || !obj || !name || !sig) return 0;
    jclass cls = (*env)->GetObjectClass(env, obj);
    if (!cls) return 0;
    jfieldID fid = (*env)->GetFieldID(env, cls, name, sig);
    (*env)->DeleteLocalRef(env, cls);
    if (!fid) {
        (*env)->ExceptionClear(env);
        return 0;
    }
    return (*env)->GetObjectField(env, obj, fid);
}

static inline void jni_set_object_field(JNIEnv* env, jobject obj, const char* name, const char* sig, jobject val) {
    if (!env || !obj || !name || !sig) return;
    jclass cls = (*env)->GetObjectClass(env, obj);
    if (!cls) return;
    jfieldID fid = (*env)->GetFieldID(env, cls, name, sig);
    (*env)->DeleteLocalRef(env, cls);
    if (!fid) {
        (*env)->ExceptionClear(env);
        return;
    }
    (*env)->SetObjectField(env, obj, fid, val);
}

static inline jobject jni_get_snapshot_state_value(JNIEnv* env, jobject state_obj) {
    if (!env || !state_obj) return 0;
    jclass cls = (*env)->GetObjectClass(env, state_obj);
    if (!cls) return 0;

    jfieldID next_fid = (*env)->GetFieldID(env, cls, "next", "Landroidx/compose/runtime/snapshots/StateRecord;");
    if (next_fid) {
        jobject record = (*env)->GetObjectField(env, state_obj, next_fid);
        if (record) {
            jclass rec_cls = (*env)->GetObjectClass(env, record);
            if (rec_cls) {
                jfieldID val_fid = (*env)->GetFieldID(env, rec_cls, "value", "Ljava/lang/Object;");
                (*env)->DeleteLocalRef(env, rec_cls);
                if (val_fid) {
                    jobject val = (*env)->GetObjectField(env, record, val_fid);
                    (*env)->DeleteLocalRef(env, record);
                    (*env)->DeleteLocalRef(env, cls);
                    return val;
                }
            }
            (*env)->DeleteLocalRef(env, record);
        }
    } else {
        (*env)->ExceptionClear(env);
    }

    jmethodID mid = (*env)->GetMethodID(env, cls, "getValue", "()Ljava/lang/Object;");
    if (mid) {
        jobject val = (*env)->CallObjectMethod(env, state_obj, mid);
        (*env)->DeleteLocalRef(env, cls);
        return val;
    }
    (*env)->ExceptionClear(env);
    (*env)->DeleteLocalRef(env, cls);
    return 0;
}

static inline jobject jni_get_attached_property(JNIEnv* env, jobject obj, const char* key) {
    if (!env || !obj || !key) return 0;
    jclass bridge_cls = (*env)->FindClass(env, "com/mandagram/plugin/nativebridge/NativeBridge");
    if (!bridge_cls) return 0;
    jmethodID mid = (*env)->GetStaticMethodID(env, bridge_cls, "getAttachedField", "(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;");
    if (!mid) {
        (*env)->DeleteLocalRef(env, bridge_cls);
        return 0;
    }
    jstring jkey = (*env)->NewStringUTF(env, key);
    jobject res = (*env)->CallStaticObjectMethod(env, bridge_cls, mid, obj, jkey);
    (*env)->DeleteLocalRef(env, jkey);
    (*env)->DeleteLocalRef(env, bridge_cls);
    return res;
}

static inline void jni_set_attached_property(JNIEnv* env, jobject obj, const char* key, jobject val) {
    if (!env || !obj || !key) return;
    jclass bridge_cls = (*env)->FindClass(env, "com/mandagram/plugin/nativebridge/NativeBridge");
    if (!bridge_cls) return;
    jmethodID mid = (*env)->GetStaticMethodID(env, bridge_cls, "setAttachedField", "(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;");
    if (!mid) {
        (*env)->DeleteLocalRef(env, bridge_cls);
        return;
    }
    jstring jkey = (*env)->NewStringUTF(env, key);
    (*env)->CallStaticObjectMethod(env, bridge_cls, mid, obj, jkey, val);
    (*env)->DeleteLocalRef(env, jkey);
    (*env)->DeleteLocalRef(env, bridge_cls);
}

#ifdef __cplusplus
}
#endif

#endif
