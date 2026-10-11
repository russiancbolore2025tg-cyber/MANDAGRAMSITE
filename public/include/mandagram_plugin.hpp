#ifndef MANDAGRAM_PLUGIN_HPP
#define MANDAGRAM_PLUGIN_HPP

#include "mandagram_plugin.h"
#include <string>
#include <vector>
#include <stdexcept>
#include <functional>
#include <memory>

namespace mandagram {

class HookContext {
public:
    explicit HookContext(HookParam* param) : param_(param) {}

    HookParam* raw() const noexcept { return param_; }

    void* thisPtr() const noexcept {
        return param_ ? param_->this_ptr : nullptr;
    }

    size_t argsCount() const noexcept {
        return param_ ? static_cast<size_t>(param_->args_count) : 0;
    }

    void* getArg(size_t index) const {
        if (!param_ || index >= param_->args_count) {
            throw std::out_of_range("Arg index out of range");
        }
        return param_->args[index];
    }

    template <typename T>
    T* getArgAs(size_t index) const {
        return static_cast<T*>(getArg(index));
    }

    void setResult(void* res) {
        if (param_) {
            param_->result = res;
            param_->has_result = 1;
        }
    }

    void returnEarly(void* res = nullptr) {
        if (param_) {
            param_->return_early = 1;
            if (res != nullptr) {
                param_->result = res;
                param_->has_result = 1;
            }
        }
    }

    void* getResult() const noexcept {
        return param_ ? param_->result : nullptr;
    }

    bool hasResult() const noexcept {
        return param_ && param_->has_result != 0;
    }

private:
    HookParam* param_;
};

class Plugin {
public:
    explicit Plugin(const PluginApi* api) : api_(api) {}
    virtual ~Plugin() = default;

    const PluginApi* rawApi() const noexcept { return api_; }

    bool registerHook(
        const std::string& className,
        const std::string& methodName,
        const std::string& methodDescriptor,
        HookBeforeFn beforeCb,
        HookAfterFn afterCb
    ) {
        if (!api_ || !api_->register_hook) return false;
        return api_->register_hook(
            className.c_str(),
            methodName.c_str(),
            methodDescriptor.c_str(),
            beforeCb,
            afterCb
        ) == 0;
    }

    void logInfo(const std::string& tag, const std::string& message) {
        if (api_ && api_->log_info) {
            api_->log_info(tag.c_str(), message.c_str());
        }
    }

    void logError(const std::string& tag, const std::string& message) {
        if (api_ && api_->log_error) {
            api_->log_error(tag.c_str(), message.c_str());
        }
    }

    std::string getStorageDir(const std::string& pluginName) {
        if (!api_ || !api_->get_storage_dir) return "";
        char buf[1024] = {0};
        int32_t len = api_->get_storage_dir(pluginName.c_str(), buf, sizeof(buf));
        return (len > 0) ? std::string(buf, len) : "";
    }

    std::string getCacheDir(const std::string& pluginName) {
        if (!api_ || !api_->get_cache_dir) return "";
        char buf[1024] = {0};
        int32_t len = api_->get_cache_dir(pluginName.c_str(), buf, sizeof(buf));
        return (len > 0) ? std::string(buf, len) : "";
    }

    int64_t getCurrentUserId() {
        if (!api_ || !api_->get_current_user_id) return 0;
        return api_->get_current_user_id();
    }

    int64_t getActiveChatId() {
        if (!api_ || !api_->get_active_chat_id) return 0;
        return api_->get_active_chat_id();
    }

    std::string executeTdlibQuery(const std::string& jsonQuery) {
        if (!api_ || !api_->execute_tdlib_query) return "";
        char buf[8192] = {0};
        int32_t len = api_->execute_tdlib_query(jsonQuery.c_str(), buf, sizeof(buf));
        return (len > 0) ? std::string(buf, len) : "";
    }

    bool registerUpdateHook(UpdateHookFn cb, uintptr_t userData = 0) {
        if (!api_ || !api_->register_update_hook) return false;
        return api_->register_update_hook(cb, userData) == 0;
    }

    bool registerMessageSendHook(MessageBeforeSendFn beforeCb, MessageAfterSendFn afterCb = nullptr, uintptr_t userData = 0) {
        if (!api_ || !api_->register_message_send_hook) return false;
        return api_->register_message_send_hook(beforeCb, afterCb, userData) == 0;
    }

    bool registerMessageReceiveHook(MessageReceiveFn cb, uintptr_t userData = 0) {
        if (!api_ || !api_->register_message_receive_hook) return false;
        return api_->register_message_receive_hook(cb, userData) == 0;
    }

    bool registerChatAction(const std::string& id, const std::string& label, ChatActionClickFn clickCb, uintptr_t userData = 0) {
        if (!api_ || !api_->register_chat_action) return false;
        return api_->register_chat_action(id.c_str(), label.c_str(), clickCb, userData) == 0;
    }

private:
    const PluginApi* api_;
};

}

#define MANDAGRAM_DECLARE_METADATA(NAME, VERSION, AUTHOR, DESCRIPTION) \
    extern "C" PLUGIN_EXPORT const PluginMetadata* mandagram_plugin_metadata(void) { \
        static const PluginMetadata meta = { \
            NAME, \
            VERSION, \
            AUTHOR, \
            DESCRIPTION \
        }; \
        return &meta; \
    }

#endif
