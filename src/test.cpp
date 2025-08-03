#include "test.h"

#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/godot.hpp>

using namespace godot;

void Test::_bind_methods(){

}

Test::Test(){
    time_passed = 0.0;
}

Test::~Test(){

}

void Test::_process(double delta){
    time_passed += delta;

	Vector2 new_position = Vector2(10.0 + (10.0 * sin(time_passed * 2.0)), 10.0 + (10.0 * cos(time_passed * 1.5)));

	set_position(new_position);
}