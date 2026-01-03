#pragma once


#define Single Float

template<typename T>
struct GetType {
    using type = ::Float;
};

#define EXTRACT_TYPE(inClass) GetType<decltype(inClass)>::type