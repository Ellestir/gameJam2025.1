#include "hexBoard.h"

#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/godot.hpp>

using namespace godot;

void HexBoard::_bind_methods(){
    ClassDB::bind_method(D_METHOD("generateHexBoard", "radius"), &HexBoard::generateHexBoard, DEFVAL(5));
}

HexBoard::HexBoard(){
    isHexBoardGenerated = false;
}

HexBoard::~HexBoard(){

}

void HexBoard::_process(double delta){
    if (!isHexBoardGenerated) {
        isHexBoardGenerated = true;
        generateHexBoard(5);
    }
}

void HexBoard::generateHexBoard(int radius){
    double size = 1.0;
    double xOffset = 0.0;
    double zOffset = 0.0;
    double gapReductionOffset = 0.0;

    xOffset = size * sqrt(3);
    zOffset = (size * 2 - 0.01) * 0.87;
    gapReductionOffset = xOffset * 0.49;
    hex = (Ref<Node3D>) ResourceLoader::get_singleton()->load("res://scenes/hexagon.tscn");
    for (int x = 0; x < radius; x++) {
        for (int z = 0; z < radius; z++) {
            hex.instantiate();
            add_child(*hex);
            if (x % 2 == 0) {
                hex->set_global_transform(Transform3D(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, (xOffset * gapReductionOffset) * x, 0, zOffset * z));
            }
            else {
                hex->set_global_transform(Transform3D(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, (xOffset * gapReductionOffset) * x, 0, zOffset * z + gapReductionOffset));
            }
        }
    }
}