#include "name.hpp"
#include <iostream>

using namespace std;

string ask_name() {
    cout << "What is your name? ";
    string name;
    getline(cin, name);
    return name;
}
