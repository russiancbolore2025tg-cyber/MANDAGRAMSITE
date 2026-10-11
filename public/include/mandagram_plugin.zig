const std = @import("std");

pub const jobject = ?*anyopaque;
pub const jclass = jobject;
pub const jfieldID = ?*anyopaque;
pub const jmethodID = ?*anyopaque;
pub const jstring = jobject;
pub const jboolean = u8;
pub const jbyte = i8;
pub const jchar = u16;
pub const jshort = i16;
pub const jint = i32;
pub const jlong = i64;
pub const jfloat = f32;
pub const jdouble = f64;
pub const jsize = jint;
pub const jobjectArray = jobject;

pub const JNINativeInterface = extern struct {
    reserved0: ?*anyopaque,
    reserved1: ?*anyopaque,
    reserved2: ?*anyopaque,
    reserved3: ?*anyopaque,

    GetVersion: ?*const fn (env: *JNIEnv) callconv(.c) jint,
    DefineClass: ?*anyopaque,
    FindClass: ?*const fn (env: *JNIEnv, name: [*:0]const u8) callconv(.c) jclass,
    FromReflectedMethod: ?*anyopaque,
    FromReflectedField: ?*anyopaque,
    ToReflectedMethod: ?*anyopaque,
    GetSuperclass: ?*anyopaque,
    IsAssignableFrom: ?*anyopaque,
    ToReflectedField: ?*anyopaque,

    Throw: ?*anyopaque,
    ThrowNew: ?*anyopaque,
    ExceptionOccurred: ?*anyopaque,
    ExceptionDescribe: ?*anyopaque,
    ExceptionClear: ?*const fn (env: *JNIEnv) callconv(.c) void,
    FatalError: ?*anyopaque,

    PushLocalFrame: ?*const fn (env: *JNIEnv, capacity: jint) callconv(.c) jint,
    PopLocalFrame: ?*const fn (env: *JNIEnv, result: jobject) callconv(.c) jobject,
    NewGlobalRef: ?*const fn (env: *JNIEnv, obj: jobject) callconv(.c) jobject,
    DeleteGlobalRef: ?*const fn (env: *JNIEnv, obj: jobject) callconv(.c) void,
    DeleteLocalRef: ?*const fn (env: *JNIEnv, obj: jobject) callconv(.c) void,
    IsSameObject: ?*anyopaque,
    NewLocalRef: ?*anyopaque,
    EnsureLocalCapacity: ?*anyopaque,

    AllocObject: ?*anyopaque,
    NewObject: ?*anyopaque,
    NewObjectA: ?*anyopaque,
    NewObjectV: ?*anyopaque,

    GetObjectClass: ?*const fn (env: *JNIEnv, obj: jobject) callconv(.c) jclass,
    IsInstanceOf: ?*const fn (env: *JNIEnv, obj: jobject, clazz: jclass) callconv(.c) jboolean,
    GetMethodID: ?*const fn (env: *JNIEnv, clazz: jclass, name: [*:0]const u8, sig: [*:0]const u8) callconv(.c) jmethodID,

    CallObjectMethod: ?*const fn (env: *JNIEnv, obj: jobject, methodID: jmethodID, ...) callconv(.c) jobject,
    CallObjectMethodV: ?*anyopaque,
    CallObjectMethodA: ?*anyopaque,
    CallBooleanMethod: ?*const fn (env: *JNIEnv, obj: jobject, methodID: jmethodID, ...) callconv(.c) jboolean,
    CallBooleanMethodV: ?*anyopaque,
    CallBooleanMethodA: ?*anyopaque,
    CallByteMethod: ?*anyopaque,
    CallByteMethodV: ?*anyopaque,
    CallByteMethodA: ?*anyopaque,
    CallCharMethod: ?*anyopaque,
    CallCharMethodV: ?*anyopaque,
    CallCharMethodA: ?*anyopaque,
    CallShortMethod: ?*anyopaque,
    CallShortMethodV: ?*anyopaque,
    CallShortMethodA: ?*anyopaque,
    CallIntMethod: ?*const fn (env: *JNIEnv, obj: jobject, methodID: jmethodID, ...) callconv(.c) jint,
    CallIntMethodV: ?*anyopaque,
    CallIntMethodA: ?*anyopaque,
    CallLongMethod: ?*const fn (env: *JNIEnv, obj: jobject, methodID: jmethodID, ...) callconv(.c) jlong,
    CallLongMethodV: ?*anyopaque,
    CallLongMethodA: ?*anyopaque,
    CallFloatMethod: ?*anyopaque,
    CallFloatMethodV: ?*anyopaque,
    CallFloatMethodA: ?*anyopaque,
    CallDoubleMethod: ?*anyopaque,
    CallDoubleMethodV: ?*anyopaque,
    CallDoubleMethodA: ?*anyopaque,
    CallVoidMethod: ?*const fn (env: *JNIEnv, obj: jobject, methodID: jmethodID, ...) callconv(.c) void,
    CallVoidMethodV: ?*anyopaque,
    CallVoidMethodA: ?*anyopaque,

    CallNonvirtualObjectMethod: ?*anyopaque,
    CallNonvirtualObjectMethodV: ?*anyopaque,
    CallNonvirtualObjectMethodA: ?*anyopaque,
    CallNonvirtualBooleanMethod: ?*anyopaque,
    CallNonvirtualBooleanMethodV: ?*anyopaque,
    CallNonvirtualBooleanMethodA: ?*anyopaque,
    CallNonvirtualByteMethod: ?*anyopaque,
    CallNonvirtualByteMethodV: ?*anyopaque,
    CallNonvirtualByteMethodA: ?*anyopaque,
    CallNonvirtualCharMethod: ?*anyopaque,
    CallNonvirtualCharMethodV: ?*anyopaque,
    CallNonvirtualCharMethodA: ?*anyopaque,
    CallNonvirtualShortMethod: ?*anyopaque,
    CallNonvirtualShortMethodV: ?*anyopaque,
    CallNonvirtualShortMethodA: ?*anyopaque,
    CallNonvirtualIntMethod: ?*anyopaque,
    CallNonvirtualIntMethodV: ?*anyopaque,
    CallNonvirtualIntMethodA: ?*anyopaque,
    CallNonvirtualLongMethod: ?*anyopaque,
    CallNonvirtualLongMethodV: ?*anyopaque,
    CallNonvirtualLongMethodA: ?*anyopaque,
    CallNonvirtualFloatMethod: ?*anyopaque,
    CallNonvirtualFloatMethodV: ?*anyopaque,
    CallNonvirtualFloatMethodA: ?*anyopaque,
    CallNonvirtualDoubleMethod: ?*anyopaque,
    CallNonvirtualDoubleMethodV: ?*anyopaque,
    CallNonvirtualDoubleMethodA: ?*anyopaque,
    CallNonvirtualVoidMethod: ?*anyopaque,
    CallNonvirtualVoidMethodV: ?*anyopaque,
    CallNonvirtualVoidMethodA: ?*anyopaque,

    GetFieldID: ?*const fn (env: *JNIEnv, clazz: jclass, name: [*:0]const u8, sig: [*:0]const u8) callconv(.c) jfieldID,
    GetObjectField: ?*const fn (env: *JNIEnv, obj: jobject, fieldID: jfieldID) callconv(.c) jobject,
    GetBooleanField: ?*const fn (env: *JNIEnv, obj: jobject, fieldID: jfieldID) callconv(.c) jboolean,
    GetByteField: ?*anyopaque,
    GetCharField: ?*anyopaque,
    GetShortField: ?*anyopaque,
    GetIntField: ?*const fn (env: *JNIEnv, obj: jobject, fieldID: jfieldID) callconv(.c) jint,
    GetLongField: ?*const fn (env: *JNIEnv, obj: jobject, fieldID: jfieldID) callconv(.c) jlong,
    GetFloatField: ?*anyopaque,
    GetDoubleField: ?*anyopaque,

    SetObjectField: ?*const fn (env: *JNIEnv, obj: jobject, fieldID: jfieldID, val: jobject) callconv(.c) void,
    SetBooleanField: ?*const fn (env: *JNIEnv, obj: jobject, fieldID: jfieldID, val: jboolean) callconv(.c) void,
    SetByteField: ?*anyopaque,
    SetCharField: ?*anyopaque,
    SetShortField: ?*anyopaque,
    SetIntField: ?*const fn (env: *JNIEnv, obj: jobject, fieldID: jfieldID, val: jint) callconv(.c) void,
    SetLongField: ?*const fn (env: *JNIEnv, obj: jobject, fieldID: jfieldID, val: jlong) callconv(.c) void,
    SetFloatField: ?*anyopaque,
    SetDoubleField: ?*anyopaque,

    GetStaticMethodID: ?*const fn (env: *JNIEnv, clazz: jclass, name: [*:0]const u8, sig: [*:0]const u8) callconv(.c) jmethodID,
    CallStaticObjectMethod: ?*const fn (env: *JNIEnv, clazz: jclass, methodID: jmethodID, ...) callconv(.c) jobject,
    CallStaticObjectMethodV: ?*anyopaque,
    CallStaticObjectMethodA: ?*anyopaque,
    CallStaticBooleanMethod: ?*const fn (env: *JNIEnv, clazz: jclass, methodID: jmethodID, ...) callconv(.c) jboolean,
    CallStaticBooleanMethodV: ?*anyopaque,
    CallStaticBooleanMethodA: ?*anyopaque,
    CallStaticByteMethod: ?*anyopaque,
    CallStaticByteMethodV: ?*anyopaque,
    CallStaticByteMethodA: ?*anyopaque,
    CallStaticCharMethod: ?*anyopaque,
    CallStaticCharMethodV: ?*anyopaque,
    CallStaticCharMethodA: ?*anyopaque,
    CallStaticShortMethod: ?*anyopaque,
    CallStaticShortMethodV: ?*anyopaque,
    CallStaticShortMethodA: ?*anyopaque,
    CallStaticIntMethod: ?*const fn (env: *JNIEnv, clazz: jclass, methodID: jmethodID, ...) callconv(.c) jint,
    CallStaticIntMethodV: ?*anyopaque,
    CallStaticIntMethodA: ?*anyopaque,
    CallStaticLongMethod: ?*const fn (env: *JNIEnv, clazz: jclass, methodID: jmethodID, ...) callconv(.c) jlong,
    CallStaticLongMethodV: ?*anyopaque,
    CallStaticLongMethodA: ?*anyopaque,
    CallStaticFloatMethod: ?*anyopaque,
    CallStaticFloatMethodV: ?*anyopaque,
    CallStaticFloatMethodA: ?*anyopaque,
    CallStaticDoubleMethod: ?*anyopaque,
    CallStaticDoubleMethodV: ?*anyopaque,
    CallStaticDoubleMethodA: ?*anyopaque,
    CallStaticVoidMethod: ?*const fn (env: *JNIEnv, clazz: jclass, methodID: jmethodID, ...) callconv(.c) void,
    CallStaticVoidMethodV: ?*anyopaque,
    CallStaticVoidMethodA: ?*anyopaque,

    GetStaticFieldID: ?*const fn (env: *JNIEnv, clazz: jclass, name: [*:0]const u8, sig: [*:0]const u8) callconv(.c) jfieldID,
    GetStaticObjectField: ?*const fn (env: *JNIEnv, clazz: jclass, fieldID: jfieldID) callconv(.c) jobject,
    GetStaticBooleanField: ?*anyopaque,
    GetStaticByteField: ?*anyopaque,
    GetStaticCharField: ?*anyopaque,
    GetStaticShortField: ?*anyopaque,
    GetStaticIntField: ?*anyopaque,
    GetStaticLongField: ?*anyopaque,
    GetStaticFloatField: ?*anyopaque,
    GetStaticDoubleField: ?*anyopaque,

    SetStaticObjectField: ?*anyopaque,
    SetStaticBooleanField: ?*anyopaque,
    SetStaticByteField: ?*anyopaque,
    SetStaticCharField: ?*anyopaque,
    SetStaticShortField: ?*anyopaque,
    SetStaticIntField: ?*anyopaque,
    SetStaticLongField: ?*anyopaque,
    SetStaticFloatField: ?*anyopaque,
    SetStaticDoubleField: ?*anyopaque,

    NewString: ?*anyopaque,
    GetStringLength: ?*anyopaque,
    GetStringChars: ?*anyopaque,
    ReleaseStringChars: ?*anyopaque,

    NewStringUTF: ?*const fn (env: *JNIEnv, utf: [*:0]const u8) callconv(.c) jstring,
    GetStringUTFLength: ?*const fn (env: *JNIEnv, str: jstring) callconv(.c) jsize,
    GetStringUTFChars: ?*const fn (env: *JNIEnv, str: jstring, isCopy: ?*jboolean) callconv(.c) [*:0]const u8,
    ReleaseStringUTFChars: ?*const fn (env: *JNIEnv, str: jstring, utf: [*:0]const u8) callconv(.c) void,

    GetArrayLength: ?*const fn (env: *JNIEnv, array: jobject) callconv(.c) jsize,
    NewObjectArray: ?*const fn (env: *JNIEnv, len: jsize, clazz: jclass, init: jobject) callconv(.c) jobjectArray,
    GetObjectArrayElement: ?*const fn (env: *JNIEnv, array: jobjectArray, index: jsize) callconv(.c) jobject,
    SetObjectArrayElement: ?*const fn (env: *JNIEnv, array: jobjectArray, index: jsize, val: jobject) callconv(.c) void,
};

pub const JNIEnv = *const JNINativeInterface;

pub const HookParam = extern struct {
    env: ?*anyopaque,
    this_ptr: ?*anyopaque,
    args: [*]?*anyopaque,
    args_count: u32,
    padding: u32 = 0,
    result: ?*anyopaque,
    return_early: u8,
    has_result: u8,
    reserved: u16 = 0,

    pub inline fn getEnv(self: *HookParam) ?*JNIEnv {
        return @ptrCast(@alignCast(self.env));
    }

    pub inline fn cancel(self: *HookParam) void {
        self.return_early = 1;
    }

    pub inline fn setResult(self: *HookParam, res: ?*anyopaque) void {
        self.result = res;
        self.has_result = 1;
        self.return_early = 1;
    }

    pub fn getComposer(self: *HookParam) jobject {
        const env = self.getEnv() orelse return null;
        if (env.*.FindClass == null or env.*.IsInstanceOf == null) return null;
        const composer_cls = env.*.FindClass.?(env, "androidx/compose/runtime/Composer") orelse {
            if (env.*.ExceptionClear) |c| c(env);
            return null;
        };
        defer if (env.*.DeleteLocalRef) |del| del(env, composer_cls);
        var i: u32 = 0;
        while (i < self.args_count) : (i += 1) {
            if (self.args[i]) |arg| {
                if (env.*.IsInstanceOf.?(env, arg, composer_cls) != 0) {
                    return arg;
                }
            }
        }
        return null;
    }

    pub fn replaceComposable(self: *HookParam, api: *const PluginApi, cb: ComposableFn, user_data: usize) void {
        if (api.replace_composable) |replace_fn| {
            replace_fn(self, cb, user_data);
        } else {
            self.cancel();
        }
    }
};

pub const ComposableFn = *const fn (env: *JNIEnv, composer: jobject, user_data: usize) callconv(.c) void;
pub const ScopedComposableFn = *const fn (env: *JNIEnv, scope: jobject, composer: jobject, user_data: usize) callconv(.c) void;

pub const HookBeforeFn = *const fn (param: *HookParam) callconv(.c) void;
pub const HookAfterFn = *const fn (param: *HookParam) callconv(.c) void;

pub const JniScope = struct {
    env: *JNIEnv,
    active: bool,

    pub fn enter(env: *JNIEnv, capacity: jint) JniScope {
        if (env.*.PushLocalFrame) |push| {
            if (push(env, capacity) == 0) {
                return JniScope{ .env = env, .active = true };
            }
        }
        return JniScope{ .env = env, .active = false };
    }

    pub fn leave(self: *JniScope, result: jobject) jobject {
        if (self.active) {
            self.active = false;
            if (self.env.*.PopLocalFrame) |pop| {
                return pop(self.env, result);
            }
        }
        return result;
    }

    pub fn deinit(self: *JniScope) void {
        _ = self.leave(null);
    }
};

pub const PluginMetadata = extern struct {
    name: [*:0]const u8,
    version: [*:0]const u8,
    author: [*:0]const u8,
    description: [*:0]const u8,
};

/// Чистый API движка: хуки, TDLib, хранилище, и примитивы Compose runtime
pub const PluginApi = extern struct {
    register_hook: *const fn (
        class_name: [*:0]const u8,
        method_name: [*:0]const u8,
        method_descriptor: ?[*:0]const u8,
        before_callback: ?HookBeforeFn,
        after_callback: ?HookAfterFn,
    ) callconv(.c) i32,
    log_info: *const fn (tag: [*:0]const u8, msg: [*:0]const u8) callconv(.c) void,
    log_error: *const fn (tag: [*:0]const u8, msg: [*:0]const u8) callconv(.c) void,
    get_storage_dir: ?*const fn (plugin_name: [*:0]const u8, out_buf: [*]u8, max_len: u32) callconv(.c) i32 = null,
    get_cache_dir: ?*const fn (plugin_name: [*:0]const u8, out_buf: [*]u8, max_len: u32) callconv(.c) i32 = null,
    resolve_asset: ?*const fn (plugin_name: [*:0]const u8, asset_name: [*:0]const u8, out_buf: [*]u8, max_len: u32) callconv(.c) i32 = null,
    get_current_user_id: ?*const fn () callconv(.c) i64 = null,
    get_active_chat_id: ?*const fn () callconv(.c) i64 = null,
    execute_tdlib_query: ?*const fn (json_query: [*:0]const u8, out_buf: [*]u8, max_len: u32) callconv(.c) i32 = null,

    // Низкоуровневые примитивы Compose рантайма
    create_composable_lambda: ?*const fn (cb: ComposableFn, user_data: usize) callconv(.c) jobject = null,
    create_scoped_lambda: ?*const fn (cb: ScopedComposableFn, user_data: usize) callconv(.c) jobject = null,
    replace_composable: ?*const fn (param: *HookParam, cb: ComposableFn, user_data: usize) callconv(.c) void = null,
    composer_start_group: ?*const fn (composer: jobject, key: i32) callconv(.c) void = null,
    composer_end_group: ?*const fn (composer: jobject) callconv(.c) void = null,
    composer_get_remembered: ?*const fn (composer: jobject) callconv(.c) jobject = null,
    composer_set_remembered: ?*const fn (composer: jobject, val: jobject) callconv(.c) void = null,
    composer_is_skipping: ?*const fn (composer: jobject) callconv(.c) bool = null,
};

/// SDK ХЕЛПЕР ДЛЯ COMPOSE:
/// Позволяет плагинам свободно вызывать ЛЮБЫЕ Compose классы и методы через JNI
/// без каких-либо заготовок со стороны движка!
pub const ComposeHelper = struct {
    pub fn getEmptyModifier(env: *JNIEnv) jobject {
        const mod_cls = env.*.FindClass.?(env, "androidx/compose/ui/Modifier") orelse return null;
        defer if (env.*.DeleteLocalRef) |del| del(env, mod_cls);
        const fid = env.*.GetStaticFieldID.?(env, mod_cls, "Companion", "Landroidx/compose/ui/Modifier$Companion;") orelse return null;
        return env.*.GetStaticObjectField.?(env, mod_cls, fid);
    }

    pub fn size(env: *JNIEnv, mod: jobject, width_dp: f32, height_dp: f32) jobject {
        const cls = env.*.FindClass.?(env, "androidx/compose/foundation/layout/SizeKt") orelse return mod;
        defer if (env.*.DeleteLocalRef) |del| del(env, cls);
        const mid = env.*.GetStaticMethodID.?(env, cls, "size-VpY3zN4", "(Landroidx/compose/ui/Modifier;FF)Landroidx/compose/ui/Modifier;") orelse return mod;
        return env.*.CallStaticObjectMethod.?(env, cls, mid, mod, width_dp, height_dp);
    }

    pub fn width(env: *JNIEnv, mod: jobject, width_dp: f32) jobject {
        const cls = env.*.FindClass.?(env, "androidx/compose/foundation/layout/SizeKt") orelse return mod;
        defer if (env.*.DeleteLocalRef) |del| del(env, cls);
        const mid = env.*.GetStaticMethodID.?(env, cls, "width-3ABfNKs", "(Landroidx/compose/ui/Modifier;F)Landroidx/compose/ui/Modifier;") orelse return mod;
        return env.*.CallStaticObjectMethod.?(env, cls, mid, mod, width_dp);
    }

    pub fn height(env: *JNIEnv, mod: jobject, height_dp: f32) jobject {
        const cls = env.*.FindClass.?(env, "androidx/compose/foundation/layout/SizeKt") orelse return mod;
        defer if (env.*.DeleteLocalRef) |del| del(env, cls);
        const mid = env.*.GetStaticMethodID.?(env, cls, "height-3ABfNKs", "(Landroidx/compose/ui/Modifier;F)Landroidx/compose/ui/Modifier;") orelse return mod;
        return env.*.CallStaticObjectMethod.?(env, cls, mid, mod, height_dp);
    }

    pub fn fillMaxWidth(env: *JNIEnv, mod: jobject) jobject {
        const cls = env.*.FindClass.?(env, "androidx/compose/foundation/layout/SizeKt") orelse return mod;
        defer if (env.*.DeleteLocalRef) |del| del(env, cls);
        const mid = env.*.GetStaticMethodID.?(env, cls, "fillMaxWidth$default", "(Landroidx/compose/ui/Modifier;FILjava/lang/Object;)Landroidx/compose/ui/Modifier;");
        if (mid) |m| {
            return env.*.CallStaticObjectMethod.?(env, cls, m, mod, @as(f32, 1.0), @as(jint, 1), @as(jobject, null));
        }
        if (env.*.ExceptionClear) |c| c(env);
        const mid_direct = env.*.GetStaticMethodID.?(env, cls, "fillMaxWidth", "(Landroidx/compose/ui/Modifier;F)Landroidx/compose/ui/Modifier;") orelse return mod;
        return env.*.CallStaticObjectMethod.?(env, cls, mid_direct, mod, @as(f32, 1.0));
    }

    pub fn fillMaxHeight(env: *JNIEnv, mod: jobject) jobject {
        const cls = env.*.FindClass.?(env, "androidx/compose/foundation/layout/SizeKt") orelse return mod;
        defer if (env.*.DeleteLocalRef) |del| del(env, cls);
        const mid = env.*.GetStaticMethodID.?(env, cls, "fillMaxHeight$default", "(Landroidx/compose/ui/Modifier;FILjava/lang/Object;)Landroidx/compose/ui/Modifier;");
        if (mid) |m| {
            return env.*.CallStaticObjectMethod.?(env, cls, m, mod, @as(f32, 1.0), @as(jint, 1), @as(jobject, null));
        }
        if (env.*.ExceptionClear) |c| c(env);
        const mid_direct = env.*.GetStaticMethodID.?(env, cls, "fillMaxHeight", "(Landroidx/compose/ui/Modifier;F)Landroidx/compose/ui/Modifier;") orelse return mod;
        return env.*.CallStaticObjectMethod.?(env, cls, mid_direct, mod, @as(f32, 1.0));
    }

    pub fn padding(env: *JNIEnv, mod: jobject, start_dp: f32, top_dp: f32, end_dp: f32, bottom_dp: f32) jobject {
        const cls = env.*.FindClass.?(env, "androidx/compose/foundation/layout/PaddingKt") orelse return mod;
        defer if (env.*.DeleteLocalRef) |del| del(env, cls);
        const mid = env.*.GetStaticMethodID.?(env, cls, "padding-qDBjuR0", "(Landroidx/compose/ui/Modifier;FFFF)Landroidx/compose/ui/Modifier;") orelse return mod;
        return env.*.CallStaticObjectMethod.?(env, cls, mid, mod, start_dp, top_dp, end_dp, bottom_dp);
    }

    pub fn createShape(env: *JNIEnv, corner_radius_dp: f32) jobject {
        if (corner_radius_dp <= 0.0) {
            const rect_cls = env.*.FindClass.?(env, "androidx/compose/ui/graphics/RectangleShapeKt") orelse return null;
            defer if (env.*.DeleteLocalRef) |del| del(env, rect_cls);
            const mid = env.*.GetStaticMethodID.?(env, rect_cls, "getRectangleShape", "()Landroidx/compose/ui/graphics/Shape;") orelse return null;
            return env.*.CallStaticObjectMethod.?(env, rect_cls, mid);
        }
        const shape_cls = env.*.FindClass.?(env, "androidx/compose/foundation/shape/RoundedCornerShapeKt") orelse return null;
        defer if (env.*.DeleteLocalRef) |del| del(env, shape_cls);
        const mid = env.*.GetStaticMethodID.?(env, shape_cls, "RoundedCornerShape-0680j_4", "(F)Landroidx/compose/foundation/shape/RoundedCornerShape;") orelse return null;
        return env.*.CallStaticObjectMethod.?(env, shape_cls, mid, corner_radius_dp);
    }

    pub fn colorLong(env: *JNIEnv, argb: u32) jlong {
        const color_cls = env.*.FindClass.?(env, "androidx/compose/ui/graphics/ColorKt") orelse {
            if (env.*.ExceptionClear) |c| c(env);
            return @as(jlong, @intCast(argb)) << 32;
        };
        defer if (env.*.DeleteLocalRef) |del| del(env, color_cls);
        const mid = env.*.GetStaticMethodID.?(env, color_cls, "Color", "(I)J") orelse {
            if (env.*.ExceptionClear) |c| c(env);
            return @as(jlong, @intCast(argb)) << 32;
        };
        return env.*.CallStaticLongMethod.?(env, color_cls, mid, @as(jint, @bitCast(argb)));
    }

    pub fn background(env: *JNIEnv, mod: jobject, argb: u32, corner_radius_dp: f32) jobject {
        const bg_cls = env.*.FindClass.?(env, "androidx/compose/foundation/BackgroundKt") orelse return mod;
        defer if (env.*.DeleteLocalRef) |del| del(env, bg_cls);
        const mid = env.*.GetStaticMethodID.?(env, bg_cls, "background-bw27NRU", "(Landroidx/compose/ui/Modifier;JLandroidx/compose/ui/graphics/Shape;)Landroidx/compose/ui/Modifier;") orelse return mod;
        const shape = createShape(env, corner_radius_dp);
        defer if (shape != null and env.*.DeleteLocalRef != null) env.*.DeleteLocalRef.?(env, shape);
        const c = colorLong(env, argb);
        return env.*.CallStaticObjectMethod.?(env, bg_cls, mid, mod, c, shape);
    }

    pub fn border(env: *JNIEnv, mod: jobject, width_dp: f32, argb: u32, corner_radius_dp: f32) jobject {
        const border_cls = env.*.FindClass.?(env, "androidx/compose/foundation/BorderKt") orelse return mod;
        defer if (env.*.DeleteLocalRef) |del| del(env, border_cls);
        const mid = env.*.GetStaticMethodID.?(env, border_cls, "border-xT4_qwU", "(Landroidx/compose/ui/Modifier;FJLandroidx/compose/ui/graphics/Shape;)Landroidx/compose/ui/Modifier;") orelse return mod;
        const shape = createShape(env, corner_radius_dp);
        defer if (shape != null and env.*.DeleteLocalRef != null) env.*.DeleteLocalRef.?(env, shape);
        const c = colorLong(env, argb);
        return env.*.CallStaticObjectMethod.?(env, border_cls, mid, mod, width_dp, c, shape);
    }

    pub fn clickable(env: *JNIEnv, mod: jobject, on_click: jobject) jobject {
        if (on_click == null) return mod;
        const click_cls = env.*.FindClass.?(env, "androidx/compose/foundation/ClickableKt") orelse return mod;
        defer if (env.*.DeleteLocalRef) |del| del(env, click_cls);
        const mid = env.*.GetStaticMethodID.?(env, click_cls, "clickable-XHw0xAI$default", "(Landroidx/compose/ui/Modifier;ZLjava/lang/String;Landroidx/compose/ui/semantics/Role;Lkotlin/jvm/functions/Function0;ILjava/lang/Object;)Landroidx/compose/ui/Modifier;") orelse return mod;
        return env.*.CallStaticObjectMethod.?(env, click_cls, mid, mod, @as(jboolean, 1), @as(jstring, null), @as(jobject, null), on_click, @as(jint, 6), @as(jobject, null));
    }

    pub fn weight(env: *JNIEnv, scope: jobject, mod: jobject, w: f32) jobject {
        if (scope == null) return mod;
        const scope_cls = env.*.GetObjectClass.?(env, scope) orelse return mod;
        defer if (env.*.DeleteLocalRef) |del| del(env, scope_cls);
        const mid = env.*.GetMethodID.?(env, scope_cls, "weight", "(Landroidx/compose/ui/Modifier;FZ)Landroidx/compose/ui/Modifier;") orelse {
            if (env.*.ExceptionClear) |c| c(env);
            return mod;
        };
        return env.*.CallObjectMethod.?(env, scope, mid, mod, w, @as(jboolean, 1));
    }

    pub fn invokeRow(env: *JNIEnv, composer: jobject, mod: jobject, content_lambda: jobject) void {
        const row_cls = env.*.FindClass.?(env, "androidx/compose/foundation/layout/RowKt") orelse return;
        defer if (env.*.DeleteLocalRef) |del| del(env, row_cls);
        const mid = env.*.GetStaticMethodID.?(env, row_cls, "Row", "(Landroidx/compose/ui/Modifier;Landroidx/compose/foundation/layout/Arrangement$Horizontal;Landroidx/compose/ui/Alignment$Vertical;Lkotlin/jvm/functions/Function3;Landroidx/compose/runtime/Composer;II)V") orelse return;
        env.*.CallStaticVoidMethod.?(env, row_cls, mid, mod, @as(jobject, null), @as(jobject, null), content_lambda, composer, @as(jint, 0), @as(jint, 6));
    }

    pub fn invokeColumn(env: *JNIEnv, composer: jobject, mod: jobject, content_lambda: jobject) void {
        const col_cls = env.*.FindClass.?(env, "androidx/compose/foundation/layout/ColumnKt") orelse return;
        defer if (env.*.DeleteLocalRef) |del| del(env, col_cls);
        const mid = env.*.GetStaticMethodID.?(env, col_cls, "Column", "(Landroidx/compose/ui/Modifier;Landroidx/compose/foundation/layout/Arrangement$Vertical;Landroidx/compose/ui/Alignment$Horizontal;Lkotlin/jvm/functions/Function3;Landroidx/compose/runtime/Composer;II)V") orelse return;
        env.*.CallStaticVoidMethod.?(env, col_cls, mid, mod, @as(jobject, null), @as(jobject, null), content_lambda, composer, @as(jint, 0), @as(jint, 6));
    }

    pub fn invokeBox(env: *JNIEnv, composer: jobject, mod: jobject, content_lambda: jobject) void {
        const box_cls = env.*.FindClass.?(env, "androidx/compose/foundation/layout/BoxKt") orelse return;
        defer if (env.*.DeleteLocalRef) |del| del(env, box_cls);
        if (content_lambda == null) {
            const mid = env.*.GetStaticMethodID.?(env, box_cls, "Box", "(Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V") orelse return;
            env.*.CallStaticVoidMethod.?(env, box_cls, mid, mod, composer, @as(jint, 0));
        } else {
            const mid = env.*.GetStaticMethodID.?(env, box_cls, "Box", "(Landroidx/compose/ui/Modifier;Landroidx/compose/ui/Alignment;ZLkotlin/jvm/functions/Function3;Landroidx/compose/runtime/Composer;II)V") orelse return;
            env.*.CallStaticVoidMethod.?(env, box_cls, mid, mod, @as(jobject, null), @as(jboolean, 0), content_lambda, composer, @as(jint, 0), @as(jint, 6));
        }
    }

    pub fn invokeSpacer(env: *JNIEnv, composer: jobject, mod: jobject) void {
        const sp_cls = env.*.FindClass.?(env, "androidx/compose/foundation/layout/SpacerKt") orelse return;
        defer if (env.*.DeleteLocalRef) |del| del(env, sp_cls);
        const mid = env.*.GetStaticMethodID.?(env, sp_cls, "Spacer", "(Landroidx/compose/ui/Modifier;Landroidx/compose/runtime/Composer;I)V") orelse return;
        env.*.CallStaticVoidMethod.?(env, sp_cls, mid, mod, composer, @as(jint, 0));
    }

    pub fn invokeText(
        env: *JNIEnv,
        composer: jobject,
        text: [*:0]const u8,
        mod: jobject,
        argb: u32,
        font_size_sp: f32,
        is_bold: bool,
        max_lines: i32,
    ) void {
        const j_text = if (env.*.NewStringUTF) |f| f(env, text) else null;
        defer if (j_text != null and env.*.DeleteLocalRef != null) env.*.DeleteLocalRef.?(env, j_text);

        // Используем Material3 TextKt.Text или BasicTextKt
        const text_cls = env.*.FindClass.?(env, "androidx/compose/material3/TextKt") orelse {
            if (env.*.ExceptionClear) |c| c(env);
            return;
        };
        defer if (env.*.DeleteLocalRef) |del| del(env, text_cls);

        const mid = env.*.GetStaticMethodID.?(
            env,
            text_cls,
            "Text--4IGK_g",
            "(Ljava/lang/String;Landroidx/compose/ui/Modifier;JJLandroidx/compose/ui/text/font/FontStyle;Landroidx/compose/ui/text/font/FontWeight;Landroidx/compose/ui/text/font/FontFamily;JLandroidx/compose/ui/text/style/TextDecoration;Landroidx/compose/ui/text/style/TextAlign;JIZIILkotlin/jvm/functions/Function1;Landroidx/compose/ui/text/TextStyle;Landroidx/compose/runtime/Composer;IIII)V",
        );
        if (mid) |m| {
            const color = colorLong(env, argb);
            const weight_cls = env.*.FindClass.?(env, "androidx/compose/ui/text/font/FontWeight") orelse null;
            defer if (weight_cls != null and env.*.DeleteLocalRef != null) env.*.DeleteLocalRef.?(env, weight_cls);
            var weight_obj: jobject = null;
            if (weight_cls != null and is_bold) {
                const w_fid = env.*.GetStaticFieldID.?(env, weight_cls.?, "Bold", "Landroidx/compose/ui/text/font/FontWeight;");
                if (w_fid != null) {
                    weight_obj = env.*.GetStaticObjectField.?(env, weight_cls.?, w_fid.?);
                }
            }

            env.*.CallStaticVoidMethod.?(
                env,
                text_cls,
                m,
                j_text,
                mod,
                color,
                @as(jlong, 0), // fontSize TextUnit.Unspecified
                @as(jobject, null), // FontStyle
                weight_obj,
                @as(jobject, null), // FontFamily
                @as(jlong, 0), // letterSpacing
                @as(jobject, null), // TextDecoration
                @as(jobject, null), // TextAlign
                @as(jlong, 0), // lineHeight
                @as(jint, 0), // overflow
                @as(jboolean, 0), // softWrap
                max_lines,
                @as(jint, 0), // minLines
                @as(jobject, null), // onTextLayout
                @as(jobject, null), // TextStyle
                composer,
                @as(jint, 0),
                @as(jint, 0),
                @as(jint, 0),
                @as(jint, 0),
            );
            return;
        }
        if (env.*.ExceptionClear) |c| c(env);

        // Fallback: BasicTextKt
        const basic_cls = env.*.FindClass.?(env, "androidx/compose/foundation/text/BasicTextKt") orelse return;
        defer if (env.*.DeleteLocalRef) |del| del(env, basic_cls);
        const basic_mid = env.*.GetStaticMethodID.?(
            env,
            basic_cls,
            "BasicText-BpD7jsM",
            "(Ljava/lang/String;Landroidx/compose/ui/Modifier;Landroidx/compose/ui/text/TextStyle;Lkotlin/jvm/functions/Function1;IZILandroidx/compose/runtime/Composer;II)V",
        );
        if (basic_mid) |bm| {
            _ = font_size_sp;
            env.*.CallStaticVoidMethod.?(env, basic_cls, bm, j_text, mod, @as(jobject, null), @as(jobject, null), @as(jint, 0), @as(jboolean, 0), max_lines, composer, @as(jint, 0), @as(jint, 0));
        }
    }

    pub fn getAvatarBitmap(env: *JNIEnv, path: [*:0]const u8) ?jobject {
        const cache_cls = env.*.FindClass.?(env, "com/mandagram/managers/AvatarCacheManager") orelse {
            if (env.*.ExceptionClear) |c| c(env);
            return null;
        };
        defer if (env.*.DeleteLocalRef) |del| del(env, cache_cls);
        const mid = env.*.GetStaticMethodID.?(env, cache_cls, "get", "(Ljava/lang/String;)Landroidx/compose/ui/graphics/ImageBitmap;") orelse {
            if (env.*.ExceptionClear) |c| c(env);
            return null;
        };
        const j_path = if (env.*.NewStringUTF) |f| f(env, path) else null;
        defer if (j_path != null and env.*.DeleteLocalRef != null) env.*.DeleteLocalRef.?(env, j_path);
        return env.*.CallStaticObjectMethod.?(env, cache_cls, mid, j_path);
    }

    pub fn invokeImage(env: *JNIEnv, composer: jobject, bitmap: jobject, mod: jobject) void {
        if (bitmap == null) return;
        const img_cls = env.*.FindClass.?(env, "androidx/compose/foundation/ImageKt") orelse {
            if (env.*.ExceptionClear) |c| c(env);
            return;
        };
        defer if (env.*.DeleteLocalRef) |del| del(env, img_cls);
        const mid = env.*.GetStaticMethodID.?(
            env,
            img_cls,
            "Image$default",
            "(Landroidx/compose/ui/graphics/ImageBitmap;Ljava/lang/String;Landroidx/compose/ui/Modifier;Landroidx/compose/ui/Alignment;Landroidx/compose/ui/layout/ContentScale;FLandroidx/compose/ui/graphics/ColorFilter;Landroidx/compose/runtime/Composer;IIIILjava/lang/Object;)V",
        );
        if (mid) |m| {
            env.*.CallStaticVoidMethod.?(
                env,
                img_cls,
                m,
                bitmap,
                @as(jstring, null),
                mod,
                @as(jobject, null),
                @as(jobject, null),
                @as(f32, 1.0),
                @as(jobject, null),
                composer,
                @as(jint, 0),
                @as(jint, 0),
                @as(jint, 0),
                @as(jint, 0x3F8),
                @as(jobject, null),
            );
        }
    }
};
