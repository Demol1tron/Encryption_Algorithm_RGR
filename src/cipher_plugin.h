#ifndef CIPHER_PLUGIN_H
#define CIPHER_PLUGIN_H

#include <functional>
#include <cstdint>

struct CipherPlugin {
    void* libraryHandle;
    std::function<const char*()> GetCipherName;
    std::function<bool(const uint8_t*)> ValidateKey;
    std::function<void(const uint8_t*, uint8_t*, size_t, const uint8_t*)> EncryptData;
    std::function<void(const uint8_t*, uint8_t*, size_t, const uint8_t*)> DecryptData;
};

extern std::vector<CipherPlugin> loadedCiphers;

#endif