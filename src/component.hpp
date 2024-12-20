#pragma once

#include <map>

#include <flecs.h>

#include <godot_cpp/classes/resource.hpp>

#include <godot_cpp/core/class_db.hpp>



namespace GDFlecs {

    class World;

    class Component : public godot::Resource {
        GDCLASS(Component, godot::Resource)
    // friend World;
    public:
        Component() {
            _position = godot::Vector3(0, 0, 0);
        };
        ~Component() override = default;

        auto get_position() const -> godot::Vector3 { return _position; }
        auto set_position(const godot::Vector3& p) -> void { _position = p; }

    protected:
        static auto _bind_methods() -> void {
            using namespace godot;
            ClassDB::bind_method(D_METHOD("get_position"), &Component::get_position);
            ClassDB::bind_method(D_METHOD("set_position", "position"), &Component::set_position);
            ADD_PROPERTY(PropertyInfo(Variant::VECTOR3, "position"), "set_position", "get_position");
        }

    private:
        godot::Vector3 _position;
    };

}
