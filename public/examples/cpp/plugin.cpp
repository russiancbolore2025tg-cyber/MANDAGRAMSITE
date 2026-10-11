#include "../../src/native/include/mandagram_plugin.hpp"
#include <iostream>

MANDAGRAM_DECLARE_METADATA(
    "CppSamplePlugin",
    "1.0.0",
    "MandaGram Team",
    "Modern C++ sample plugin for MandaGram"
)

static void on_before_dialog_open(HookParam* param) {
    mandagram::HookContext ctx(param);
}

extern "C" PLUGIN_EXPORT bool mandagram_plugin_init(const PluginApi* raw_api) {
    if (!raw_api) {
        return false;
    }

    mandagram::Plugin plugin(raw_api);
    plugin.logInfo("CppSamplePlugin", "Plugin loaded successfully");

    int64_t my_uid = plugin.getCurrentUserId();
    plugin.logInfo("CppSamplePlugin", "Current user ID: " + std::to_string(my_uid));

    int64_t active_chat = plugin.getActiveChatId();
    plugin.logInfo("CppSamplePlugin", "Active chat ID: " + std::to_string(active_chat));

    return true;
}
