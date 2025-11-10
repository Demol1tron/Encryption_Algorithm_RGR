#ifndef CIPHER_PLUGIN_H
#define CIPHER_PLUGIN_H

#include <functional>
#include <cstdint>
#include <string>

struct CipherPlugin {
    void* libraryHandle;
    std::function<const char*()> GetCipherName;
    std::function<bool(const std::string&)> ValidateKey;
    std::function<void(const uint8_t*, uint8_t*, size_t, const std::string&)> EncryptData;
    std::function<void(const uint8_t*, uint8_t*, size_t, const std::string&)> DecryptData;
};

extern std::vector<CipherPlugin> loadedCiphers;

#endif