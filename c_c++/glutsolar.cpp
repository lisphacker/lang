#include <stdio.h>
#include <GL/glut.h>

struct V2 {
    float x;
    float y;

    V2(V2 &v) {
        *this = v;
    }
    
    V2 &operator=(V2 &v) {
        x = v.x;
        y = v.y;

        return *this;
    }
};
    
class CelObj {
public:
    CelObj(V2 &pos, V2 &vel, float radius)
        : pos_(pos), vel_(vel), radius_(radius) {
    }

protected:
    V2 pos_;
    V2 vel_;
    float radius_;
};

class Game {
public:
    ~Game();

    static Game *get_object() {
        if (object_ == NULL)
            return (object_ = new Game());
        else
            return object_;
    };

    void update_display() {
        printf("display\n");
    }
    
protected:
    Game();

private:
    static Game *object_;
};

Game *Game::object_ = NULL;
    
void display_func() {
    Game::get_object()->update_display();
}

void mouse_func(int button, int state, int x, int y) {
    printf("mouse : %d %d %d %d\n", button, state, x, y);
}

void keyboard_func(unsigned char key, int x, int y) {
    printf("key: %c %d %d\n", key, x, y);
}

int main(int argc, char **argv) {
    glutInit(&argc, argv);                      \
    
    glutInitWindowSize(800, 600);
    glutInitWindowPosition(100, 100);
    glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE);

    glutCreateWindow("Solar");

    glutDisplayFunc(display_func);
    glutKeyboardFunc(keyboard_func);
    glutMouseFunc(mouse_func);
    
    glutMainLoop();
    
    return 0;
}
