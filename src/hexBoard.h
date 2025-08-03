#ifndef HEXBOARD_H
#define HEXBOARD_H

#include <godot_cpp/classes/node3d.hpp>
#include <godot_cpp/classes/resource_loader.hpp>
#include <godot_cpp/classes/resource.hpp>

namespace godot{
    class HexBoard : public Node3D{
        GDCLASS(HexBoard, Node3D)

        private:
            Ref<Node3D> hex;
            bool isHexBoardGenerated;

        protected:
            static void _bind_methods();

        public:
            HexBoard();
            ~HexBoard();
            void generateHexBoard(int radius);
            void _process(double delta);
    };
}

#endif//HEXBOARD_H