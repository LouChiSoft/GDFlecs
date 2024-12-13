#pragma once

#include <map>

#include <godot_cpp/classes/object.hpp>
#include <flecs.h>

class World;

class FlecsComponent : public godot::Object {
    GDCLASS(FlecsComponent, godot::Object)
friend World;
public:
    FlecsComponent() = default;
    ~FlecsComponent() override = default;

protected:
    

    static auto _bind_methods() -> void;
};
