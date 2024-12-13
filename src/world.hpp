#pragma once

#include <map>

#include <godot_cpp/classes/node.hpp>
#include <flecs.h>

class FlecsWorld : public godot::Node {
    GDCLASS(FlecsWorld, godot::Node)
public:
    FlecsWorld() = default;
    ~FlecsWorld() override = default;

    void _ready() override;

protected:
    auto component_registered(const godot::String& commponent_name) const -> bool;
    auto register_new_component() -> void;

    static auto _bind_methods() -> void;

private:
    flecs::world _world;
    std::map<godot::String, flecs::entity> _registered_components;
};
