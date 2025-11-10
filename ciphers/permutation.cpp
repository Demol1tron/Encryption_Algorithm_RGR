#include "api.h"
#include <vector>
#include <sstream>
#include <algorithm>

const char* GetCipherName()
{
    return "Шифр фиксированной перестановки (размер блока переменный)";
}

bool ValidateKey(const std::string &key)
{
    std::stringstream ss(key);
    std::vector<int> permutation;
    std::string token;
    
    while (std::getline(ss, token, ',')) {
        try {
            int num = std::stoi(token);
            permutation.push_back(num);
        } catch (...) {
            return false;
        }
    }
    
    int k = permutation.size();
    if (k < 2)
        return false;
    
    std::vector<int> sorted = permutation;
    std::sort(sorted.begin(), sorted.end());
    for (int i = 0; i < k; ++i)
        if (sorted[i] != i + 1)
            return false;
    
    return true;
}

void EncryptData(const uint8_t *inputData, uint8_t *outputData, size_t dataSize,
                const std::string &key)
{
    std::stringstream ss(key);
    std::vector<int> permutation;
    std::string token;
    
    while (std::getline(ss, token, ',')) {
        try {
            int num = std::stoi(token);
            permutation.push_back(num);
        } catch (...) {
            return;
        }
    }
    
    int blockSize = permutation.size();
    if (blockSize < 2)
        return;
    
    std::vector<int> newPositions(blockSize);
    for (int i = 0; i < blockSize; ++i)
        newPositions[i] = permutation[i] - 1;
    
    for (size_t blockStart = 0; blockStart < dataSize; blockStart += blockSize) {
        int currentBlockSize = std::min(static_cast<int>(dataSize - blockStart), blockSize);
        
        // блок с пробелами
        std::vector<uint8_t> block(blockSize, ' ');
        
        // копируем данные
        for (int i = 0; i < currentBlockSize; ++i)
            block[i] = inputData[blockStart + i];
        
        // перестановка
        for (int i = 0; i < blockSize; ++i)
            outputData[blockStart + i] = block[newPositions[i]];
    }
}

void DecryptData(const uint8_t *inputData, uint8_t *outputData, size_t dataSize, 
                const std::string &key)
{
    std::stringstream ss(key);
    std::vector<int> permutation;
    std::string token;
    
    while (std::getline(ss, token, ',')) {
        try {
            int num = std::stoi(token);
            permutation.push_back(num);
        } catch (...) {
            return;
        }
    }
    
    int blockSize = permutation.size();
    if (blockSize < 2)
        return;
    
    std::vector<int> originalPositions(blockSize);
    for (int i = 0; i < blockSize; ++i)
        originalPositions[i] = permutation[i] - 1;
    
    std::vector<int> inversePositions(blockSize);
    for (int i = 0; i < blockSize; ++i)
        inversePositions[originalPositions[i]] = i;
    
    for (size_t blockStart = 0; blockStart < dataSize; blockStart += blockSize) {
        // блок с пробелами
        std::vector<uint8_t> block(blockSize, ' ');
        
        // копируем шифрованные данные
        for (int i = 0; i < blockSize; ++i)
            block[i] = inputData[blockStart + i];
        
        // обратная перестановка
        for (int i = 0; i < blockSize; ++i)
            outputData[blockStart + i] = block[inversePositions[i]];
    }
}