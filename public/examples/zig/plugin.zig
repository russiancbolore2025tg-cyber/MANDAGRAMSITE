const std = @import("std");

pub const HookParam = extern struct {
    env: ?*anyopaque,
    this_ptr: ?*anyopaque,
    args: [*]?*anyopaque,
    args_count: u32,
    padding: u32 = 0,
    result: ?*anyopaque = null,
    return_early: u8 = 0,
    has_result: u8 = 0,
    reserved: u16 = 0,

    pub inline fn cancel(self: *HookParam) void {
        self.return_early = 1;
    }

    pub inline fn setResult(self: *HookParam, res: ?*anyopaque) void {
        self.result = res;
        self.has_result = 1;
        self.return_early = 1;
    }
};

pub const HookBeforeFn = *const fn (param: *HookParam) callconv(.c) void;
pub const HookAfterFn = *const fn (param: *HookParam) callconv(.c) void;

pub const PluginMetadata = extern struct {
    name: [*:0]const u8,
    version: [*:0]const u8,
    author: [*:0]const u8,
    description: [*:0]const u8,
};

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
};

const PLUGIN_NAME = "ZigTelemetryPlugin";
var global_api: ?*const PluginApi = null;

const metadata = PluginMetadata{
    .name = "Zig Telemetry Plugin",
    .version = "1.2.0",
    .author = "MandaGram Community",
    .description = "Native Zig telemetry and monitoring plugin",
};

pub export fn mandagram_plugin_metadata() callconv(.c) *const PluginMetadata {
    return &metadata;
}

fn on_before_render(param: *HookParam) callconv(.c) void {
    const api = global_api orelse return;
    _ = param;
    api.log_info(PLUGIN_NAME, "Before ChatDetailPanel.MessageBubble hook triggered");
}

fn on_after_render(param: *HookParam) callconv(.c) void {
    const api = global_api orelse return;
    _ = param;
    api.log_info(PLUGIN_NAME, "After ChatDetailPanel.MessageBubble finished execution");
}

pub export fn mandagram_plugin_init(api: *const PluginApi) callconv(.c) bool {
    global_api = api;
    api.log_info(PLUGIN_NAME, "Zig plugin loaded");

    if (api.get_current_user_id) |get_uid| {
        const uid = get_uid();
        var buf: [64]u8 = undefined;
        if (std.fmt.bufPrint(&buf, "Current User ID: {d}", .{uid})) |msg| {
            var msg_z: [65]u8 = undefined;
            @memcpy(msg_z[0..msg.len], msg);
            msg_z[msg.len] = 0;
            api.log_info(PLUGIN_NAME, msg_z[0..msg.len :0].ptr);
        } else |_| {}
    }

    const status = api.register_hook(
        "com/mandagram/ui/chat/ChatDetailPanel",
        "MessageBubble",
        null,
        on_before_render,
        on_after_render,
    );

    if (status != 0) {
        api.log_error(PLUGIN_NAME, "Failed to register hook for ChatDetailPanel");
        return false;
    }

    return true;
}
