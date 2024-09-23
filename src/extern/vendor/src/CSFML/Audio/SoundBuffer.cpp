////////////////////////////////////////////////////////////
//
// SFML - Simple and Fast Multimedia Library
// Copyright (C) 2007-2024 Laurent Gomila (laurent@sfml-dev.org)
//
// This software is provided 'as-is', without any express or implied warranty.
// In no event will the authors be held liable for any damages arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it freely,
// subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented;
//    you must not claim that you wrote the original software.
//    If you use this software in a product, an acknowledgment
//    in the product documentation would be appreciated but is not required.
//
// 2. Altered source versions must be plainly marked as such,
//    and must not be misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any source distribution.
//
////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// Headers
////////////////////////////////////////////////////////////
#include <CSFML/Audio/SoundBuffer.h>
#include <CSFML/Audio/SoundBufferStruct.hpp>
#include <CSFML/CallbackStream.hpp>


////////////////////////////////////////////////////////////
sfSoundBuffer* sfSoundBuffer_createFromFile(const char* filename)
{
    assert(filename);

    sf::SoundBuffer soundBuffer;
    if (!soundBuffer.loadFromFile(filename))
        return nullptr;

    return new sfSoundBuffer{std::move(soundBuffer)};
}


////////////////////////////////////////////////////////////
sfSoundBuffer* sfSoundBuffer_createFromMemory(const void* data, size_t sizeInBytes)
{
    sf::SoundBuffer soundBuffer;
    if (!soundBuffer.loadFromMemory(data, sizeInBytes))
        return nullptr;

    return new sfSoundBuffer{std::move(soundBuffer)};
}


////////////////////////////////////////////////////////////
sfSoundBuffer* sfSoundBuffer_createFromStream(sfInputStream* stream)
{
    assert(stream);

    CallbackStream  sfmlStream(stream);
    sf::SoundBuffer soundBuffer;
    if (!soundBuffer.loadFromStream(sfmlStream))
        return nullptr;

    return new sfSoundBuffer{std::move(soundBuffer)};
}


////////////////////////////////////////////////////////////
sfSoundBuffer* sfSoundBuffer_createFromSamples(
    const int16_t*  samples,
    uint64_t        sampleCount,
    unsigned int    channelCount,
    unsigned int    sampleRate,
    sfSoundChannel* channelMapData,
    size_t          channelMapSize)
{
    std::vector<sf::SoundChannel> channelMap(channelMapSize);
    for (std::size_t i = 0; i < channelMap.size(); ++i)
        channelMap[i] = static_cast<sf::SoundChannel>(channelMapData[i]);

    sf::SoundBuffer soundBuffer;
    if (!soundBuffer.loadFromSamples(samples, sampleCount, channelCount, sampleRate, channelMap))
        return nullptr;

    return new sfSoundBuffer{std::move(soundBuffer)};
}


////////////////////////////////////////////////////////////
sfSoundBuffer* sfSoundBuffer_copy(const sfSoundBuffer* soundBuffer)
{
    assert(soundBuffer);
    return new sfSoundBuffer(*soundBuffer);
}


////////////////////////////////////////////////////////////
void sfSoundBuffer_destroy(const sfSoundBuffer* soundBuffer)
{
    delete soundBuffer;
}


////////////////////////////////////////////////////////////
bool sfSoundBuffer_saveToFile(const sfSoundBuffer* soundBuffer, const char* filename)
{
    assert(soundBuffer);
    assert(filename);
    return soundBuffer->This.saveToFile(filename);
}


////////////////////////////////////////////////////////////
const int16_t* sfSoundBuffer_getSamples(const sfSoundBuffer* soundBuffer)
{
    assert(soundBuffer);
    return soundBuffer->This.getSamples();
}


////////////////////////////////////////////////////////////
uint64_t sfSoundBuffer_getSampleCount(const sfSoundBuffer* soundBuffer)
{
    assert(soundBuffer);
    return soundBuffer->This.getSampleCount();
}


////////////////////////////////////////////////////////////
unsigned int sfSoundBuffer_getSampleRate(const sfSoundBuffer* soundBuffer)
{
    assert(soundBuffer);
    return soundBuffer->This.getSampleRate();
}


////////////////////////////////////////////////////////////
unsigned int sfSoundBuffer_getChannelCount(const sfSoundBuffer* soundBuffer)
{
    assert(soundBuffer);
    return soundBuffer->This.getChannelCount();
}


////////////////////////////////////////////////////////////
sfTime sfSoundBuffer_getDuration(const sfSoundBuffer* soundBuffer)
{
    assert(soundBuffer);
    return {soundBuffer->This.getDuration().asMicroseconds()};
}