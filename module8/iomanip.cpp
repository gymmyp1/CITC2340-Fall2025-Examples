#include <iostream>
#include <iomanip>

using namespace std;

int main () {
    cout << "hi" << setw(10) << "MeiLi" << "hello" << endl;
    cout << setfill('-') << setw(10) << "MeiLi" << endl;
    cout << setfill(' '); //reset fill char back to space

    cout << left << setw(10) << "Left" << "|" << endl;
    cout << right << setw(10) << "Right" << "|" << endl;
    return 0;
}