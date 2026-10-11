module chaos_plugin;

import mandagram_plugin;

import core.stdc.stdint;
import core.stdc.stdio;
import core.stdc.string;

bool is_nan(float f) {
    return f != f;
}

float fast_sin(float x) {
    return x - (x * x * x) / 6.0f;
}

float fast_cos(float x) {
    return 1.0f - (x * x) * 0.5f;
}

extern(C):

enum PLUGIN_NAME = "UltimateChaosD\0";

export __gshared int _fltused = 0;

export bool _DllMainCRTStartup(void* hinstDLL, uint32_t fdwReason, void* lpReserved) {
    return true;
}

__gshared const(PluginApi)* g_api = null;

__gshared PluginMetadata g_meta = PluginMetadata(
    "Ultimate Pure Chaos & Acid (D)".ptr,
    "3.2.0".ptr,
    "MandaGram Team".ptr,
    "Takes every Compose element by the balls: Synchronized Skia canvas rotation + matching hitbox offsets on every element, RTL layout mirror, and toxic acid neon theme.".ptr
);

export PluginMetadata* mandagram_plugin_metadata() {
    return &g_meta;
}

struct JniScope {
    JNIEnv env;
    bool active;

    static JniScope enter(JNIEnv env, int capacity = 16) {
        JniScope s;
        s.env = env;
        if (env !is null && *env !is null && (*env).PushLocalFrame !is null) {
            s.active = ((*env).PushLocalFrame(cast(void*)env, capacity) == 0);
        }
        return s;
    }

    jobject leave(jobject result) {
        if (active && env !is null && *env !is null && (*env).PopLocalFrame !is null) {
            jobject res = (*env).PopLocalFrame(cast(void*)env, result);
            active = false;
            return res;
        }
        return result;
    }

    void deinit() {
        leave(null);
    }
}

__gshared void* active_transform_coord = null;

__gshared jmethodID mid_canvas_save = null;
__gshared jmethodID mid_canvas_restore = null;
__gshared jmethodID mid_canvas_trans = null;
__gshared jmethodID mid_canvas_rot = null;

__gshared jmethodID mid_coord_wrapped_by = null;
__gshared jmethodID mid_coord_size = null;
__gshared jmethodID mid_coord_pos = null;
__gshared jmethodID mid_coord_layout_node = null;

__gshared jmethodID mid_ln_parent = null;
__gshared jmethodID mid_ln_width = null;
__gshared jmethodID mid_ln_height = null;

__gshared jclass sys_cls_ref = null;
__gshared jmethodID mid_identity_hash = null;

__gshared jclass long_cls_ref = null;
__gshared jmethodID mid_long_value = null;
__gshared jmethodID mid_long_of = null;

// Умеренные, читаемые углы наклона плашек (градусы): кривой стиль без воронки
immutable float[12] JITTER_ANGLES = [ -2.4f, 2.7f, -1.9f, 2.2f, -2.8f, 2.0f, -1.6f, 2.5f, -2.3f, 1.8f, -2.6f, 2.3f ];

// Аккуратные смещения плашек (пиксели)
immutable float[10] OFFSETS_X = [ -4.0f, 5.0f, -5.0f, 4.0f, -6.0f, 5.0f, -3.0f, 5.0f, -4.0f, 6.0f ];
immutable float[10] OFFSETS_Y = [ 3.0f, -4.0f, 5.0f, -3.0f, 4.0f, -5.0f, 3.0f, -4.0f, 5.0f, -3.0f ];

size_t get_coord_hash(JNIEnv env, jobject obj) {
    if (mid_identity_hash is null) {
        jclass sys = (*env).FindClass(cast(void*)env, "java/lang/System\0".ptr);
        if (sys !is null) {
            sys_cls_ref = (*env).NewGlobalRef !is null ? (*env).NewGlobalRef(cast(void*)env, sys) : sys;
            mid_identity_hash = (*env).GetStaticMethodID(cast(void*)env, sys, "identityHashCode\0".ptr, "(Ljava/lang/Object;)I\0".ptr);
            if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
        }
    }
    if (sys_cls_ref !is null && mid_identity_hash !is null) {
        jint h = (*env).CallStaticIntMethod(cast(void*)env, sys_cls_ref, mid_identity_hash, obj);
        if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
        return cast(size_t)(cast(uint32_t)h);
    }
    return 0;
}

jlong unbox_long(JNIEnv env, jobject obj) {
    if (mid_long_value is null) {
        jclass cls = (*env).FindClass(cast(void*)env, "java/lang/Long\0".ptr);
        if (cls !is null) {
            long_cls_ref = (*env).NewGlobalRef !is null ? (*env).NewGlobalRef(cast(void*)env, cls) : cls;
            mid_long_value = (*env).GetMethodID(cast(void*)env, cls, "longValue\0".ptr, "()J\0".ptr);
            mid_long_of = (*env).GetStaticMethodID(cast(void*)env, cls, "valueOf\0".ptr, "(J)Ljava/lang/Long;\0".ptr);
            if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
        }
    }
    if (mid_long_value !is null) {
        jlong res = (*env).CallLongMethod(cast(void*)env, obj, mid_long_value);
        if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
        return res;
    }
    return 0;
}

jobject box_long(JNIEnv env, jlong val) {
    if (long_cls_ref !is null && mid_long_of !is null) {
        jobject res = (*env).CallStaticObjectMethod(cast(void*)env, long_cls_ref, mid_long_of, val);
        if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
        return res;
    }
    return null;
}

struct CoordParams {
    bool is_plaque;
    float angle;
    float dx;
    float dy;
    float pos_x;
    float pos_y;
    float half_w;
    float half_h;
}

bool is_container(int w, int h) {
    if (w >= 700 && h >= 350) return true; // Главная рабочая область окна
    if (h >= 400) return true;               // Высокие списки (LazyColumn чатов, сообщений)
    if (w >= 750) return true;               // Полноэкранный топ-бар
    return false;
}

CoordParams get_params_for_coord(JNIEnv env, jobject coord) {
    CoordParams res;
    res.is_plaque = false;
    res.angle = 0.0f;
    res.dx = 0.0f;
    res.dy = 0.0f;
    res.pos_x = 0.0f;
    res.pos_y = 0.0f;
    res.half_w = 0.0f;
    res.half_h = 0.0f;

    jclass coord_cls = (*env).GetObjectClass(cast(void*)env, coord);
    if (coord_cls is null) return res;
    scope(exit) if ((*env).DeleteLocalRef !is null) (*env).DeleteLocalRef(cast(void*)env, coord_cls);

    if (mid_coord_wrapped_by is null) {
        mid_coord_wrapped_by = (*env).GetMethodID(cast(void*)env, coord_cls, "getWrappedBy$ui\0".ptr, "()Landroidx/compose/ui/node/NodeCoordinator;\0".ptr);
        if (mid_coord_wrapped_by is null && (*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
    }
    if (mid_coord_size is null) {
        mid_coord_size = (*env).GetMethodID(cast(void*)env, coord_cls, "getSize-YbymL2g\0".ptr, "()J\0".ptr);
        if (mid_coord_size is null && (*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
    }
    if (mid_coord_pos is null) {
        mid_coord_pos = (*env).GetMethodID(cast(void*)env, coord_cls, "getPosition-nOcc-ac\0".ptr, "()J\0".ptr);
        if (mid_coord_pos is null && (*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
    }
    if (mid_coord_layout_node is null) {
        mid_coord_layout_node = (*env).GetMethodID(cast(void*)env, coord_cls, "getLayoutNode\0".ptr, "()Landroidx/compose/ui/node/LayoutNode;\0".ptr);
        if (mid_coord_layout_node is null && (*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
    }

    // 1. Плашкой может быть только outerCoordinator (wrappedBy == null)
    if (mid_coord_wrapped_by !is null) {
        jobject wb = (*env).CallObjectMethod(cast(void*)env, coord, mid_coord_wrapped_by);
        if (wb !is null) {
            if ((*env).DeleteLocalRef !is null) (*env).DeleteLocalRef(cast(void*)env, wb);
            return res;
        }
    }
    if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);

    // 2. Размеры этого элемента
    if (mid_coord_size is null) return res;
    jlong size = (*env).CallLongMethod(cast(void*)env, coord, mid_coord_size);
    if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
    int w = cast(int)(size >> 32);
    int h = cast(int)(size & 0xFFFFFFFF);
    if (w <= 16 || h <= 16 || is_container(w, h)) return res;

    // 3. Проверка предков LayoutNode (предотвращает наклон элементов внутри уже наклоненной плашки)
    if (mid_coord_layout_node is null) return res;
    jobject layout_node = (*env).CallObjectMethod(cast(void*)env, coord, mid_coord_layout_node);
    if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
    if (layout_node is null) return res;
    scope(exit) if ((*env).DeleteLocalRef !is null) (*env).DeleteLocalRef(cast(void*)env, layout_node);

    if (mid_ln_parent is null || mid_ln_width is null || mid_ln_height is null) {
        jclass ln_cls = (*env).GetObjectClass(cast(void*)env, layout_node);
        if (ln_cls !is null) {
            scope(exit) if ((*env).DeleteLocalRef !is null) (*env).DeleteLocalRef(cast(void*)env, ln_cls);
            mid_ln_parent = (*env).GetMethodID(cast(void*)env, ln_cls, "getParent$ui\0".ptr, "()Landroidx/compose/ui/node/LayoutNode;\0".ptr);
            if (mid_ln_parent is null && (*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
            mid_ln_width = (*env).GetMethodID(cast(void*)env, ln_cls, "getWidth\0".ptr, "()I\0".ptr);
            if (mid_ln_width is null && (*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
            mid_ln_height = (*env).GetMethodID(cast(void*)env, ln_cls, "getHeight\0".ptr, "()I\0".ptr);
            if (mid_ln_height is null && (*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
        }
    }

    if (mid_ln_parent !is null && mid_ln_width !is null && mid_ln_height !is null) {
        jobject cur_parent = (*env).CallObjectMethod(cast(void*)env, layout_node, mid_ln_parent);
        if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
        if (cur_parent is null) return res;

        int depth = 0;
        bool inside_plaque = false;
        while (depth < 3) {
            depth++;
            int pw = (*env).CallIntMethod(cast(void*)env, cur_parent, mid_ln_width);
            int ph = (*env).CallIntMethod(cast(void*)env, cur_parent, mid_ln_height);
            if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);

            if (pw > 16 && ph > 16) {
                if (!is_container(pw, ph)) {
                    inside_plaque = true;
                    break;
                } else {
                    break;
                }
            }

            jobject next_parent = (*env).CallObjectMethod(cast(void*)env, cur_parent, mid_ln_parent);
            if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
            if ((*env).DeleteLocalRef !is null) (*env).DeleteLocalRef(cast(void*)env, cur_parent);
            cur_parent = next_parent;
            if (cur_parent is null) break;
        }

        if (cur_parent !is null) {
            if ((*env).DeleteLocalRef !is null) (*env).DeleteLocalRef(cast(void*)env, cur_parent);
        }

        if (inside_plaque) return res;
    }

    // 4. Позиция элемента в родителе
    int px = 0;
    int py = 0;
    if (mid_coord_pos !is null) {
        jlong pos = (*env).CallLongMethod(cast(void*)env, coord, mid_coord_pos);
        if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
        px = cast(int)(pos >> 32);
        py = cast(int)(pos & 0xFFFFFFFF);
    }

    res.is_plaque = true;
    res.pos_x = cast(float)px;
    res.pos_y = cast(float)py;
    res.half_w = cast(float)w * 0.5f;
    res.half_h = cast(float)h * 0.5f;

    size_t hash = get_coord_hash(env, coord);
    res.angle = JITTER_ANGLES[hash % JITTER_ANGLES.length];
    res.dx = OFFSETS_X[(hash / 7) % OFFSETS_X.length];
    res.dy = OFFSETS_Y[(hash / 13) % OFFSETS_Y.length];

    return res;
}

/// 1. НАКЛОН И СМЕЩЕНИЕ ПЛАШЕК НА ЭКРАНЕ (ХАРДВАРНЫЙ SKIA CANVAS)
void before_node_draw(HookParam* param) {
    if (active_transform_coord !is null) return;
    if (param is null || param.args_count < 1 || param.args[0] is null || param.this_ptr is null) return;
    JNIEnv env = param.getEnv();
    if (env is null || *env is null) return;

    auto scope_ = JniScope.enter(env, 16);
    scope(exit) scope_.deinit();

    jobject coord = param.this_ptr;
    CoordParams p = get_params_for_coord(env, coord);
    if (!p.is_plaque) return;

    jobject canvas = param.args[0];
    jclass canvas_cls = (*env).GetObjectClass(cast(void*)env, canvas);
    if (canvas_cls is null) return;
    scope(exit) if ((*env).DeleteLocalRef !is null) (*env).DeleteLocalRef(cast(void*)env, canvas_cls);

    if (mid_canvas_save is null) {
        mid_canvas_save = (*env).GetMethodID(cast(void*)env, canvas_cls, "save\0".ptr, "()V\0".ptr);
        if (mid_canvas_save is null && (*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
        mid_canvas_restore = (*env).GetMethodID(cast(void*)env, canvas_cls, "restore\0".ptr, "()V\0".ptr);
        if (mid_canvas_restore is null && (*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
        mid_canvas_trans = (*env).GetMethodID(cast(void*)env, canvas_cls, "translate\0".ptr, "(FF)V\0".ptr);
        if (mid_canvas_trans is null && (*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
        mid_canvas_rot = (*env).GetMethodID(cast(void*)env, canvas_cls, "rotate\0".ptr, "(F)V\0".ptr);
        if (mid_canvas_rot is null && (*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
    }

    if (mid_canvas_save is null || mid_canvas_restore is null || mid_canvas_trans is null || mid_canvas_rot is null) return;

    // 1. Сохраняем состояние Skia Canvas
    (*env).CallVoidMethod(cast(void*)env, canvas, mid_canvas_save);
    active_transform_coord = coord;

    // Физический центр плашки в родительской системе координат
    float cx = p.pos_x + p.half_w;
    float cy = p.pos_y + p.half_h;

    // 2. Сдвиг в центр плашки + джиттер
    (*env).CallVoidMethod(cast(void*)env, canvas, mid_canvas_trans, cast(double)(cx + p.dx), cast(double)(cy + p.dy));

    // 3. Вращение вокруг собственного центра плашки
    (*env).CallVoidMethod(cast(void*)env, canvas, mid_canvas_rot, cast(double)p.angle);

    // 4. Возврат из центра
    (*env).CallVoidMethod(cast(void*)env, canvas, mid_canvas_trans, cast(double)(-cx), cast(double)(-cy));

    if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
}

void after_node_draw(HookParam* param) {
    if (active_transform_coord is null) return;
    if (param is null || param.args_count < 1 || param.args[0] is null || param.this_ptr is null) return;
    if (active_transform_coord !is param.this_ptr) return;

    JNIEnv env = param.getEnv();
    if (env is null || *env is null) return;

    auto scope_ = JniScope.enter(env, 8);
    scope(exit) scope_.deinit();

    jobject canvas = param.args[0];
    if (mid_canvas_restore !is null) {
        (*env).CallVoidMethod(cast(void*)env, canvas, mid_canvas_restore);
    }
    active_transform_coord = null;
    if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
}

/// 2. ИДЕАЛЬНАЯ СИНХРОНИЗАЦИЯ ХИТБОКСОВ ДЛЯ КЛИКОВ И КУРСОРА:
/// Точная аналитическая инверсия поворота и смещения вокруг (half_w, half_h).
/// Хитбокс гарантированно ложится 1-в-1 на визуальную плашку!
void after_from_parent_position(HookParam* param) {
    if (param is null || param.result is null || param.this_ptr is null) return;
    JNIEnv env = param.getEnv();
    if (env is null || *env is null) return;

    auto scope_ = JniScope.enter(env, 16);

    jobject coord = param.this_ptr;
    CoordParams p = get_params_for_coord(env, coord);
    if (!p.is_plaque || p.half_w <= 0.0f || p.half_h <= 0.0f) {
        scope_.deinit();
        return;
    }

    jlong pos = unbox_long(env, param.result);
    uint32_t raw_x = cast(uint32_t)(pos >> 32);
    uint32_t raw_y = cast(uint32_t)(pos & 0xFFFFFFFF);
    float lx = *cast(float*)&raw_x;
    float ly = *cast(float*)&raw_y;

    if (is_nan(lx) || is_nan(ly)) {
        scope_.deinit();
        return;
    }

    // lx, ly — локальные координаты от Compose (parent_pos - pos):
    float delta_x = lx - p.half_w - p.dx;
    float delta_y = ly - p.half_h - p.dy;
    float rad = p.angle * (3.141592653589793f / 180.0f);
    float cos_a = fast_cos(rad);
    float sin_a = fast_sin(rad);

    // Точная обратная формула:
    float inv_u = p.half_w + (delta_x * cos_a + delta_y * sin_a);
    float inv_v = p.half_h + (-delta_x * sin_a + delta_y * cos_a);

    uint32_t packed_x = *cast(uint32_t*)&inv_u;
    uint32_t packed_y = *cast(uint32_t*)&inv_v;
    jlong new_pos = (cast(int64_t)packed_x << 32) | cast(int64_t)packed_y;

    jobject boxed = box_long(env, new_pos);
    if (boxed !is null) {
        jobject res_obj = scope_.leave(boxed);
        param.result = res_obj;
        param.has_result = 1;
        param.return_early = 1;
    } else {
        scope_.deinit();
    }
}

/// 3. СИНХРОНИЗАЦИЯ ПОЗИЦИЙ ДЕТЕЙ И ПОПАПОВ (toParentPosition):
void after_to_parent_position(HookParam* param) {
    if (param is null || param.result is null || param.this_ptr is null) return;
    JNIEnv env = param.getEnv();
    if (env is null || *env is null) return;

    auto scope_ = JniScope.enter(env, 16);

    jobject coord = param.this_ptr;
    CoordParams p = get_params_for_coord(env, coord);
    if (!p.is_plaque || p.half_w <= 0.0f || p.half_h <= 0.0f) {
        scope_.deinit();
        return;
    }

    jlong pos = unbox_long(env, param.result);
    uint32_t raw_x = cast(uint32_t)(pos >> 32);
    uint32_t raw_y = cast(uint32_t)(pos & 0xFFFFFFFF);
    float parent_x = *cast(float*)&raw_x;
    float parent_y = *cast(float*)&raw_y;

    if (is_nan(parent_x) || is_nan(parent_y)) {
        scope_.deinit();
        return;
    }

    float u = parent_x - p.pos_x;
    float v = parent_y - p.pos_y;

    float delta_u = u - p.half_w;
    float delta_v = v - p.half_h;
    float rad = p.angle * (3.141592653589793f / 180.0f);
    float cos_a = fast_cos(rad);
    float sin_a = fast_sin(rad);

    float fwd_x = p.pos_x + p.half_w + p.dx + (delta_u * cos_a - delta_v * sin_a);
    float fwd_y = p.pos_y + p.half_h + p.dy + (delta_u * sin_a + delta_v * cos_a);

    uint32_t packed_x = *cast(uint32_t*)&fwd_x;
    uint32_t packed_y = *cast(uint32_t*)&fwd_y;
    jlong new_pos = (cast(int64_t)packed_x << 32) | cast(int64_t)packed_y;

    jobject boxed = box_long(env, new_pos);
    if (boxed !is null) {
        jobject res_obj = scope_.leave(boxed);
        param.result = res_obj;
        param.has_result = 1;
        param.return_early = 1;
    } else {
        scope_.deinit();
    }
}

/// 4. Хаос бейджей: 9999
void before_chat_list_item(HookParam* param) {
    if (param is null || param.args_count < 1 || param.args[0] is null) return;
    JNIEnv env = param.getEnv();
    if (env is null || *env is null) return;

    auto scope_ = JniScope.enter(env, 16);

    jobject chat = param.args[0];
    jclass chat_cls = (*env).GetObjectClass(cast(void*)env, chat);
    if (chat_cls !is null) {
        jfieldID fid_unread = (*env).GetFieldID(cast(void*)env, chat_cls, "unreadCount\0".ptr, "I\0".ptr);
        if (fid_unread !is null) {
            (*env).SetIntField(cast(void*)env, chat, fid_unread, 9999);
        }
    }
    if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
}

/// 5. Выворот сообщений наизнанку
void before_message_bubble(HookParam* param) {
    if (param is null || param.args_count < 1 || param.args[0] is null) return;
    JNIEnv env = param.getEnv();
    if (env is null || *env is null) return;

    auto scope_ = JniScope.enter(env, 16);

    jobject msg = param.args[0];
    jclass msg_cls = (*env).GetObjectClass(cast(void*)env, msg);
    if (msg_cls is null) return;

    jfieldID fid_out = (*env).GetFieldID(cast(void*)env, msg_cls, "isOutgoing\0".ptr, "Z\0".ptr);
    if (fid_out !is null) {
        jboolean is_out = (*env).GetBooleanField(cast(void*)env, msg, fid_out);
        (*env).SetBooleanField(cast(void*)env, msg, fid_out, is_out ? 0 : 1);
    }
    if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
}

/// 6. Зеркальный интерфейс (RTL)
void before_set_layout_direction(HookParam* param) {
    if (param is null || param.args_count < 1 || param.args[0] is null) return;
    JNIEnv env = param.getEnv();
    if (env is null || *env is null) return;

    auto scope_ = JniScope.enter(env, 16);

    jobject cur_dir = param.args[0];
    jclass dir_cls = (*env).GetObjectClass(cast(void*)env, cur_dir);
    if (dir_cls is null) return;
    scope(exit) if ((*env).DeleteLocalRef !is null) (*env).DeleteLocalRef(cast(void*)env, dir_cls);

    jfieldID fid_rtl = (*env).GetStaticFieldID(cast(void*)env, dir_cls, "Rtl\0".ptr, "Landroidx/compose/ui/unit/LayoutDirection;\0".ptr);
    if (fid_rtl !is null) {
        jobject rtl_val = (*env).GetStaticObjectField(cast(void*)env, dir_cls, fid_rtl);
        if (rtl_val !is null) {
            param.args[0] = rtl_val;
        }
    }
    if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
}

jlong compose_color(uint32_t argb) {
    return cast(jlong)((cast(uint64_t)argb) << 32);
}

/// 7. КИСЛОТНЫЙ НЕОНОВЫЙ ХУЕСТИЛЬ (Toxic Neon Acid Theme)
void after_get_dark_scheme(HookParam* param) {
    if (param is null || param.result is null) return;
    jobject scheme = param.result;
    JNIEnv env = param.getEnv();
    if (env is null || *env is null) return;

    auto scope_ = JniScope.enter(env, 32);

    jclass scheme_cls = (*env).GetObjectClass(cast(void*)env, scheme);
    if (scheme_cls is null) return;
    scope(exit) if ((*env).DeleteLocalRef !is null) (*env).DeleteLocalRef(cast(void*)env, scheme_cls);

    jlong neon_green = compose_color(0xFF39FF14);
    jlong void_black = compose_color(0xFF0B0014);
    jlong dark_green = compose_color(0xFF003B00);
    jlong radio_yellow = compose_color(0xFFCCFF00);
    jlong electric_cyan = compose_color(0xFF00F0FF);
    jlong deep_cyan = compose_color(0xFF003840);
    jlong bright_cyan = compose_color(0xFF80FFFF);
    jlong hot_magenta = compose_color(0xFFFF007F);
    jlong dark_magenta = compose_color(0xFF4A0025);
    jlong radio_pink = compose_color(0xFFFF80DF);
    jlong void_surface = compose_color(0xFF140026);
    jlong acid_container = compose_color(0xFF240045);
    jlong acid_bright_cont = compose_color(0xFF380066);
    jlong acid_ultraviolet = compose_color(0xFF4D008C);
    jlong radio_red = compose_color(0xFFFF0033);

    struct ColorEntry {
        const(char)* name;
        jlong value;
    }

    ColorEntry[26] entries = [
        ColorEntry("primary\0".ptr, neon_green),
        ColorEntry("onPrimary\0".ptr, void_black),
        ColorEntry("primaryContainer\0".ptr, dark_green),
        ColorEntry("onPrimaryContainer\0".ptr, radio_yellow),
        ColorEntry("secondary\0".ptr, electric_cyan),
        ColorEntry("onSecondary\0".ptr, void_black),
        ColorEntry("secondaryContainer\0".ptr, deep_cyan),
        ColorEntry("onSecondaryContainer\0".ptr, bright_cyan),
        ColorEntry("tertiary\0".ptr, hot_magenta),
        ColorEntry("onTertiary\0".ptr, void_black),
        ColorEntry("tertiaryContainer\0".ptr, dark_magenta),
        ColorEntry("onTertiaryContainer\0".ptr, radio_pink),
        ColorEntry("background\0".ptr, void_black),
        ColorEntry("onBackground\0".ptr, neon_green),
        ColorEntry("surface\0".ptr, void_surface),
        ColorEntry("onSurface\0".ptr, electric_cyan),
        ColorEntry("surfaceVariant\0".ptr, acid_container),
        ColorEntry("onSurfaceVariant\0".ptr, radio_yellow),
        ColorEntry("surfaceContainer\0".ptr, acid_container),
        ColorEntry("surfaceContainerHigh\0".ptr, acid_bright_cont),
        ColorEntry("surfaceContainerHighest\0".ptr, acid_ultraviolet),
        ColorEntry("surfaceContainerLow\0".ptr, void_black),
        ColorEntry("surfaceContainerLowest\0".ptr, void_black),
        ColorEntry("outline\0".ptr, neon_green),
        ColorEntry("outlineVariant\0".ptr, hot_magenta),
        ColorEntry("error\0".ptr, radio_red)
    ];

    foreach (entry; entries) {
        jfieldID fid = (*env).GetFieldID(cast(void*)env, scheme_cls, entry.name, "J\0".ptr);
        if (fid !is null) {
            (*env).SetLongField(cast(void*)env, scheme, fid, entry.value);
        }
        if ((*env).ExceptionClear !is null) (*env).ExceptionClear(cast(void*)env);
    }
}

export bool mandagram_plugin_init(const(PluginApi)* api) {
    g_api = api;
    api.log_info(PLUGIN_NAME.ptr, "Initializing Ultimate Pure Chaos & Acid plugin (D v3.2)...\0".ptr);

    // 1. НАКЛОН И СМЕЩЕНИЕ КООРДИНАТ КАЖДОГО ЭЛЕМЕНТА КОМПОУЗА ЧЕРЕЗ SKIA CANVAS
    api.register_hook(
        "androidx/compose/ui/node/NodeCoordinator\0".ptr,
        "draw\0".ptr,
        "(Landroidx/compose/ui/graphics/Canvas;Landroidx/compose/ui/graphics/layer/GraphicsLayer;)V\0".ptr,
        &before_node_draw,
        &after_node_draw
    );

    // 2. СИНХРОНИЗАЦИЯ ХИТБОКСОВ ДЛЯ КЛИКОВ И НАВЕДЕНИЯ МЫШИ
    api.register_hook(
        "androidx/compose/ui/node/NodeCoordinator\0".ptr,
        "fromParentPosition-8S9VItk\0".ptr,
        "(JZ)J\0".ptr,
        null,
        &after_from_parent_position
    );

    // 3. СИНХРОНИЗАЦИЯ ПОЗИЦИЙ ДЛЯ ПОПАПОВ И ТУЛТИПОВ
    api.register_hook(
        "androidx/compose/ui/node/NodeCoordinator\0".ptr,
        "toParentPosition-8S9VItk\0".ptr,
        "(JZ)J\0".ptr,
        null,
        &after_to_parent_position
    );

    // 4. Хаос бейджей: 9999
    api.register_hook(
        "com/mandagram/ui/chat/ChatListComponentsKt\0".ptr,
        "ChatListItem\0".ptr,
        null,
        &before_chat_list_item,
        null
    );

    // 5. Выворот сообщений наизнанку
    api.register_hook(
        "com/mandagram/ui/chat/MessageBubbleKt\0".ptr,
        "MessageBubble\0".ptr,
        null,
        &before_message_bubble,
        null
    );

    // 6. Зеркальный интерфейс (RTL)
    api.register_hook(
        "androidx/compose/ui/node/LayoutNode\0".ptr,
        "setLayoutDirection\0".ptr,
        "(Landroidx/compose/ui/unit/LayoutDirection;)V\0".ptr,
        &before_set_layout_direction,
        null
    );

    // 7. Кислотный стиль (ExteraMonetEveningRedDarkScheme)
    api.register_hook(
        "com/mandagram/ui/theme/ThemeKt\0".ptr,
        "getExteraMonetEveningRedDarkScheme\0".ptr,
        null,
        null,
        &after_get_dark_scheme
    );

    // 8. Кислотный стиль (ExteraMonetPistachioDarkScheme)
    api.register_hook(
        "com/mandagram/ui/theme/ThemeKt\0".ptr,
        "getExteraMonetPistachioDarkScheme\0".ptr,
        null,
        null,
        &after_get_dark_scheme
    );

    api.log_info(PLUGIN_NAME.ptr, "Ultimate Pure Chaos (D) loaded! Skia canvas tilt and hitboxes are fully synchronized.\0".ptr);
    return true;
}
