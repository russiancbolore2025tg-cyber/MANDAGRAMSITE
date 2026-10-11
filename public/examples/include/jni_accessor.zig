const std = @import("std");
const plugin = @import("mandagram_plugin.zig");

pub const JNIEnv = plugin.JNIEnv;
pub const jobject = plugin.jobject;
pub const jclass = plugin.jclass;
pub const jfieldID = plugin.jfieldID;
pub const jmethodID = plugin.jmethodID;
pub const jstring = plugin.jstring;
pub const jboolean = plugin.jboolean;
pub const jint = plugin.jint;
pub const jlong = plugin.jlong;

pub const JniAccessor = struct {
    pub fn getObjectClass(env: *JNIEnv, obj: jobject) ?jclass {
        if (obj == null) return null;
        if (env.*.GetObjectClass) |f| {
            return f(env, obj);
        }
        return null;
    }

    pub fn findClass(env: *JNIEnv, class_name: [*:0]const u8) ?jclass {
        if (env.*.FindClass) |f| {
            return f(env, class_name);
        }
        return null;
    }

    pub fn getFieldID(env: *JNIEnv, clazz: jclass, name: [*:0]const u8, sig: [*:0]const u8) ?jfieldID {
        if (clazz == null) return null;
        if (env.*.GetFieldID) |f| {
            const fid = f(env, clazz, name, sig);
            if (fid == null) {
                if (env.*.ExceptionClear) |clear| clear(env);
            }
            return fid;
        }
        return null;
    }

    pub fn getFieldIdFromObject(env: *JNIEnv, obj: jobject, name: [*:0]const u8, sig: [*:0]const u8) ?jfieldID {
        const clazz = getObjectClass(env, obj) orelse return null;
        defer if (env.*.DeleteLocalRef) |del| del(env, clazz);
        return getFieldID(env, clazz, name, sig);
    }

    pub fn getObjectField(env: *JNIEnv, obj: jobject, name: [*:0]const u8, sig: [*:0]const u8) jobject {
        const fid = getFieldIdFromObject(env, obj, name, sig) orelse return null;
        if (env.*.GetObjectField) |f| {
            return f(env, obj, fid);
        }
        return null;
    }

    pub fn getIntField(env: *JNIEnv, obj: jobject, name: [*:0]const u8) jint {
        const fid = getFieldIdFromObject(env, obj, name, "I") orelse return 0;
        if (env.*.GetIntField) |f| {
            return f(env, obj, fid);
        }
        return 0;
    }

    pub fn getLongField(env: *JNIEnv, obj: jobject, name: [*:0]const u8) jlong {
        const fid = getFieldIdFromObject(env, obj, name, "J") orelse return 0;
        if (env.*.GetLongField) |f| {
            return f(env, obj, fid);
        }
        return 0;
    }

    pub fn getBooleanField(env: *JNIEnv, obj: jobject, name: [*:0]const u8) bool {
        const fid = getFieldIdFromObject(env, obj, name, "Z") orelse return false;
        if (env.*.GetBooleanField) |f| {
            return f(env, obj, fid) != 0;
        }
        return false;
    }

    pub fn setObjectField(env: *JNIEnv, obj: jobject, name: [*:0]const u8, sig: [*:0]const u8, val: jobject) void {
        const fid = getFieldIdFromObject(env, obj, name, sig) orelse return;
        if (env.*.SetObjectField) |f| {
            f(env, obj, fid, val);
        }
    }

    pub fn setIntField(env: *JNIEnv, obj: jobject, name: [*:0]const u8, val: jint) void {
        const fid = getFieldIdFromObject(env, obj, name, "I") orelse return;
        if (env.*.SetIntField) |f| {
            f(env, obj, fid, val);
        }
    }

    pub fn setBooleanField(env: *JNIEnv, obj: jobject, name: [*:0]const u8, val: bool) void {
        const fid = getFieldIdFromObject(env, obj, name, "Z") orelse return;
        if (env.*.SetBooleanField) |f| {
            f(env, obj, fid, if (val) 1 else 0);
        }
    }

    pub fn setLongField(env: *JNIEnv, obj: jobject, name: [*:0]const u8, val: jlong) void {
        const fid = getFieldIdFromObject(env, obj, name, "J") orelse return;
        if (env.*.SetLongField) |f| {
            f(env, obj, fid, val);
        }
    }

    pub fn getSnapshotStateValue(env: *JNIEnv, state_obj: jobject) jobject {
        if (state_obj == null) return null;
        const clazz = getObjectClass(env, state_obj) orelse return null;
        defer if (env.*.DeleteLocalRef) |del| del(env, clazz);

        const next_fid = getFieldID(env, clazz, "next", "Landroidx/compose/runtime/snapshots/StateRecord;");
        if (next_fid != null and env.*.GetObjectField != null) {
            const record = env.*.GetObjectField.?(env, state_obj, next_fid.?);
            if (record != null) {
                defer if (env.*.DeleteLocalRef) |del| del(env, record);
                const rec_clazz = getObjectClass(env, record) orelse return null;
                defer if (env.*.DeleteLocalRef) |del| del(env, rec_clazz);

                const value_fid = getFieldID(env, rec_clazz, "value", "Ljava/lang/Object;");
                if (value_fid != null) {
                    return env.*.GetObjectField.?(env, record, value_fid.?);
                }
            }
        }

        if (env.*.GetMethodID) |mid_fn| {
            const mid = mid_fn(env, clazz, "getValue", "()Ljava/lang/Object;");
            if (mid != null and env.*.CallObjectMethod != null) {
                return env.*.CallObjectMethod.?(env, state_obj, mid);
            }
            if (env.*.ExceptionClear) |clear| clear(env);
        }

        return null;
    }

    pub fn setSnapshotStateValue(env: *JNIEnv, state_obj: jobject, new_value: jobject) void {
        if (state_obj == null) return;
        const clazz = getObjectClass(env, state_obj) orelse return;
        defer if (env.*.DeleteLocalRef) |del| del(env, clazz);

        if (env.*.GetMethodID) |mid_fn| {
            const mid = mid_fn(env, clazz, "setValue", "(Ljava/lang/Object;)V");
            if (mid != null and env.*.CallVoidMethod != null) {
                env.*.CallVoidMethod.?(env, state_obj, mid, new_value);
                return;
            }
            if (env.*.ExceptionClear) |clear| clear(env);
        }

        const next_fid = getFieldID(env, clazz, "next", "Landroidx/compose/runtime/snapshots/StateRecord;");
        if (next_fid != null and env.*.GetObjectField != null) {
            const record = env.*.GetObjectField.?(env, state_obj, next_fid.?);
            if (record != null) {
                defer if (env.*.DeleteLocalRef) |del| del(env, record);
                const rec_clazz = getObjectClass(env, record) orelse return;
                defer if (env.*.DeleteLocalRef) |del| del(env, rec_clazz);

                const value_fid = getFieldID(env, rec_clazz, "value", "Ljava/lang/Object;");
                if (value_fid != null and env.*.SetObjectField != null) {
                    env.*.SetObjectField.?(env, record, value_fid.?, new_value);
                }
            }
        }
    }

    pub fn getAttachedProperty(env: *JNIEnv, obj: jobject, key: [*:0]const u8) jobject {
        if (obj == null) return null;
        const bridge_cls = findClass(env, "com/mandagram/plugin/nativebridge/NativeBridge") orelse return null;
        defer if (env.*.DeleteLocalRef) |del| del(env, bridge_cls);

        if (env.*.GetStaticMethodID) |mid_fn| {
            const mid = mid_fn(env, bridge_cls, "getAttachedField", "(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;");
            if (mid != null and env.*.CallStaticObjectMethod != null) {
                const jkey = newStringUtf(env, key);
                defer if (env.*.DeleteLocalRef) |del| del(env, jkey);
                return env.*.CallStaticObjectMethod.?(env, bridge_cls, mid, obj, jkey);
            }
            if (env.*.ExceptionClear) |clear| clear(env);
        }
        return null;
    }

    pub fn setAttachedProperty(env: *JNIEnv, obj: jobject, key: [*:0]const u8, val: jobject) void {
        if (obj == null) return;
        const bridge_cls = findClass(env, "com/mandagram/plugin/nativebridge/NativeBridge") orelse return;
        defer if (env.*.DeleteLocalRef) |del| del(env, bridge_cls);

        if (env.*.GetStaticMethodID) |mid_fn| {
            const mid = mid_fn(env, bridge_cls, "setAttachedField", "(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;");
            if (mid != null and env.*.CallStaticObjectMethod != null) {
                const jkey = newStringUtf(env, key);
                defer if (env.*.DeleteLocalRef) |del| del(env, jkey);
                _ = env.*.CallStaticObjectMethod.?(env, bridge_cls, mid, obj, jkey, val);
                return;
            }
            if (env.*.ExceptionClear) |clear| clear(env);
        }
    }

    pub fn newStringUtf(env: *JNIEnv, text: [*:0]const u8) jstring {
        if (env.*.NewStringUTF) |f| {
            return f(env, text);
        }
        return null;
    }

    pub fn getStringUtfChars(env: *JNIEnv, str: jstring) ?[*:0]const u8 {
        if (str == null) return null;
        if (env.*.GetStringUTFChars) |f| {
            return f(env, str, null);
        }
        return null;
    }

    pub fn releaseStringUtfChars(env: *JNIEnv, str: jstring, chars: [*:0]const u8) void {
        if (str == null) return;
        if (env.*.ReleaseStringUTFChars) |f| {
            f(env, str, chars);
        }
    }

    pub const JniScope = plugin.JniScope;
};
