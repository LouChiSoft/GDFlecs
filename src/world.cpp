#include "world.hpp"

#include "component.hpp"

#include <godot_cpp/classes/script.hpp>
#include <godot_cpp/variant/utility_functions.hpp>

#include "../build/Release/_deps/godot-cpp-src/include/godot_cpp/variant/typed_array.hpp"

using namespace godot;

namespace GDFlecs {
    void World::_ready() {

        Ref<Script> script = get_script();
        if(script.is_valid() && script->is_class("GDScript")) {


            UtilityFunctions::prints("Script name: ", script->get_global_name());
            TypedArray<Dictionary> properties = get_property_list();
            for(int i = 0; i < properties.size(); i++)
            {
                Dictionary property = properties[i];
                int usage = property["usage"];
                if((usage & PROPERTY_USAGE_SCRIPT_VARIABLE) == PROPERTY_USAGE_SCRIPT_VARIABLE)
                {
                    UtilityFunctions::prints("-- Name:", property["name"],"- Type:", property["type"], "- Usage:", property["usage"]);
                }
            }
        }

        // For every GD entity
            // For every GD component
                // Make Flecs entity
                    // Make Flecs component
    }



    auto World::component_registered(const String& commponent_name) const -> bool {
        return _registered_components.count(commponent_name);
    }

    auto World::register_new_component() -> void {

    }


    void World::_bind_methods() {

    }
}