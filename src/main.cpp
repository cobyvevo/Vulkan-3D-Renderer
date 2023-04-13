#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

#include <iostream>
#include <stdexcept>
#include <cstdlib>
#include <vector>
#include <string.h>
#include <cstring>
#include <optional>
#include <set>
#include <limits>
#include <algorithm>
#include <fstream>

#include "engine.hpp"
#include "meshtools.hpp"

int main() {
    MainEngine engine(9999,9999); //fullscreen

    //Scene* scene = &engine.testscene;


    Scene myscene;
    engine.SCENE_set_active(&myscene);

    //DEBUG
    engine.SCENE_new_material(&myscene,"assets/tex.png", "SmileTexture");
    Object* cool_object = engine.SCENE_new_object(&myscene,"assets/cube.obj", "Cube", "SmileTexture");
    
    //GAME
    Object* camera = engine.SCENE_new_object(&myscene,"none", "Camera", "none");

    engine.SCENE_new_material(&myscene,"assets/tabletexture.png", "Table_Texture");
    engine.SCENE_new_object(&myscene,"assets/table.obj", "TestAsset", "Table_Texture");

    //engine.SCENE_set_viewport(&myscene,cool_object);

    std::vector<Object*> balls;

    int ballcount = 5;
    //int offset = 0;

    float ballscale = 0.2f;

    for (int e = 0; e < 5; e++) {
        for (int i = 0; i < ballcount; i++) {
            Object* cool_object = engine.SCENE_new_object(&myscene,"assets/ball.obj", "Ball", "none");
            float fi = (float) i;
            float fe = (float) e;

            glm::vec3 objcenter = {((fi-(float) ballcount/2))* ballscale,1.3f,fe* ballscale};
            glm::vec3 scaleval = {0.5f * ballscale,0.5f* ballscale,0.5f* ballscale};
            cool_object->SetPosition(objcenter);
            cool_object->Scale(scaleval);

            balls.push_back(cool_object);
        }
        ballcount--;
    }

    while (engine.StepEngine()) {

        glm::vec3 objcenter = {sin(engine.tick*4) * 4.0f,0.0f,0.0f};
        cool_object->SetPosition(objcenter);

    }

    std::cout << "ended" << std::endl;

    engine.cleanup();

    
    return 0;

}