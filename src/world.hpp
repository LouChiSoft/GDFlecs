#pragma once

#include <map>

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/variant/typed_array.hpp>

#include <flecs.h>

namespace GDFlecs {
    class Component;

    class World final : public godot::Node {
        GDCLASS(World, godot::Node)
    public:
        World() = default;
        ~World() override = default;

        void _ready() override;

    protected:
        auto component_registered(const godot::String& commponent_name) const -> bool;
        auto register_new_component() -> void;

        static auto _bind_methods() -> void;

    private:
        flecs::world _world;
        std::map<godot::String, flecs::entity> _registered_components;
    };
}
