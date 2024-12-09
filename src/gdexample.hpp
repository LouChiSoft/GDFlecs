#pragma once

#include <godot_cpp/classes/sprite2d.hpp>

using namespace godot;

class GDExample : public Sprite2D {
    GDCLASS(GDExample, Sprite2D)
public:
    GDExample();

    void _process(double delta) override;

    [[nodiscard]] double get_amplitude() const;
    void set_amplitude(const double p_amplitude);

    [[nodiscard]] double get_speed() const;
    void set_speed(const double p_speed);

protected:
    static void _bind_methods();

private:
    double time_passed;
    double amplitude;
    double speed;
};
