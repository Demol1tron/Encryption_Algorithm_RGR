#ifndef FUNCS_H
#define FUNCS_H

#include <string>

bool LoadCipher(const std::string &libraryPath);
void UnloadAllCiphers();
void ProcessTextEncryption();
void ProcessFileEncryption();
void ShowKeyGenerator();

#endif