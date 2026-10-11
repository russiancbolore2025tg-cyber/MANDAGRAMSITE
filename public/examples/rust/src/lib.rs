use std::ffi::{CStr, CString};
use std::os::raw::{c_char, c_void};
use std::sync::atomic::{AtomicPtr, Ordering};

pub const PLUGIN_NAME: &str = "RustSecurityPlugin";

#[repr(C)]
pub struct HookParam {
    pub env: *mut c_void,
    pub this_ptr: *mut c_void,
    pub args: *mut *mut c_void,
    pub args_count: u32,
    pub padding: u32,
    pub result: *mut c_void,
    pub return_early: u8,
    pub has_result: u8,
    pub reserved: u16,
}

impl HookParam {
    pub fn cancel(&mut self) {
        self.return_early = 1;
    }

    pub fn set_result(&mut self, res: *mut c_void) {
        self.result = res;
        self.has_result = 1;
        self.return_early = 1;
    }
}

pub type HookBeforeFn = unsafe extern "C" fn(param: *mut HookParam);
pub type HookAfterFn = unsafe extern "C" fn(param: *mut HookParam);

#[repr(C)]
pub struct PluginMetadata {
    pub name: *const c_char,
    pub version: *const c_char,
    pub author: *const c_char,
    pub description: *const c_char,
}

static PLUGIN_NAME_C: &[u8] = b"Rust Security Plugin\0";
static PLUGIN_VERSION_C: &[u8] = b"1.1.0\0";
static PLUGIN_AUTHOR_C: &[u8] = b"MandaGram Community\0";
static PLUGIN_DESC_C: &[u8] = b"Rust native plugin\0";

static METADATA: PluginMetadata = PluginMetadata {
    name: PLUGIN_NAME_C.as_ptr() as *const c_char,
    version: PLUGIN_VERSION_C.as_ptr() as *const c_char,
    author: PLUGIN_AUTHOR_C.as_ptr() as *const c_char,
    description: PLUGIN_DESC_C.as_ptr() as *const c_char,
};

#[no_mangle]
pub extern "C" fn mandagram_plugin_metadata() -> *const PluginMetadata {
    &METADATA
}

#[repr(C)]
pub struct PluginApi {
    pub register_hook: unsafe extern "C" fn(
        class_name: *const c_char,
        method_name: *const c_char,
        method_descriptor: *const c_char,
        before_cb: Option<HookBeforeFn>,
        after_cb: Option<HookAfterFn>,
    ) -> i32,
    pub log_info: unsafe extern "C" fn(tag: *const c_char, msg: *const c_char),
    pub log_error: unsafe extern "C" fn(tag: *const c_char, msg: *const c_char),
    pub get_storage_dir: Option<unsafe extern "C" fn(plugin_name: *const c_char, out_buf: *mut c_char, max_len: u32) -> i32>,
    pub get_cache_dir: Option<unsafe extern "C" fn(plugin_name: *const c_char, out_buf: *mut c_char, max_len: u32) -> i32>,
    pub resolve_asset: Option<unsafe extern "C" fn(plugin_name: *const c_char, asset_name: *const c_char, out_buf: *mut c_char, max_len: u32) -> i32>,
    pub get_current_user_id: Option<unsafe extern "C" fn() -> i64>,
    pub get_active_chat_id: Option<unsafe extern "C" fn() -> i64>,
    pub execute_tdlib_query: Option<unsafe extern "C" fn(json_query: *const c_char, out_buf: *mut c_char, max_len: u32) -> i32>,
}

static GLOBAL_API: AtomicPtr<PluginApi> = AtomicPtr::new(std::ptr::null_mut());

fn log_info(msg: &str) {
    let api_ptr = GLOBAL_API.load(Ordering::SeqCst);
    if api_ptr.is_null() { return; }
    unsafe {
        let tag = CString::new(PLUGIN_NAME).unwrap();
        let message = CString::new(msg).unwrap();
        ((*api_ptr).log_info)(tag.as_ptr(), message.as_ptr());
    }
}

fn log_error(msg: &str) {
    let api_ptr = GLOBAL_API.load(Ordering::SeqCst);
    if api_ptr.is_null() { return; }
    unsafe {
        let tag = CString::new(PLUGIN_NAME).unwrap();
        let message = CString::new(msg).unwrap();
        ((*api_ptr).log_error)(tag.as_ptr(), message.as_ptr());
    }
}

unsafe extern "C" fn on_before_message_send(param: *mut HookParam) {
    if param.is_null() { return; }
    let _param_ref = &mut *param;
    log_info("Intercepted outgoing message in TelegramService.sendMessage");
}

unsafe extern "C" fn on_after_message_send(param: *mut HookParam) {
    if param.is_null() { return; }
    log_info("TelegramService.sendMessage successfully dispatched");
}

#[no_mangle]
pub unsafe extern "C" fn mandagram_plugin_init(api: *const PluginApi) -> bool {
    if api.is_null() {
        return false;
    }

    GLOBAL_API.store(api as *mut PluginApi, Ordering::SeqCst);
    let api_ref = &*api;

    log_info("Rust plugin loaded");

    if let Some(get_uid) = api_ref.get_current_user_id {
        let uid = get_uid();
        log_info(&format!("Current user ID: {}", uid));
    }

    if let Some(get_cid) = api_ref.get_active_chat_id {
        let cid = get_cid();
        log_info(&format!("Active chat ID: {}", cid));
    }

    if let Some(get_storage) = api_ref.get_storage_dir {
        let mut buf = [0u8; 512];
        let tag = CString::new(PLUGIN_NAME).unwrap();
        let len = get_storage(tag.as_ptr(), buf.as_mut_ptr() as *mut c_char, buf.len() as u32);
        if len > 0 {
            if let Ok(path) = CStr::from_ptr(buf.as_ptr() as *const c_char).to_str() {
                log_info(&format!("Plugin private data directory: {}", path));
            }
        }
    }

    let target_class = CString::new("com/mandagram/network/TelegramService").unwrap();
    let target_method = CString::new("sendMessage").unwrap();

    let res = (api_ref.register_hook)(
        target_class.as_ptr(),
        target_method.as_ptr(),
        std::ptr::null(),
        Some(on_before_message_send),
        Some(on_after_message_send),
    );

    if res != 0 {
        log_error("Failed to register hook for TelegramService");
        return false;
    }

    true
}
