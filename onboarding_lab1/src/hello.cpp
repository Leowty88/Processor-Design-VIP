#include "name.hpp"
#include <iostream>

using namespace std;

int main() {
    string name = ask_name();
    cout << "Hello, " << name << "!" << endl;
    return 0;
}
