#include <iostream>

using namespace std;

void swap_values(int &a, int &b);

int main() {
    int n1;
    int n2;
    
    cout << "Enter a number: ";
    cin >> n1;

    cout << "Enter another number: ";
    cin >> n2;

    cout << "Before swap: " << endl;
    cout << "n1: " << n1 << endl;
    cout << "n2: " << n2 << endl;

    swap_values(n1,n2);

    cout << "After swap: " << endl;
    cout << "n1: " << n1 << endl;
    cout << "n2: " << n2 << endl;

    return 0;
}

void swap_values(int &a, int &b) {
    int temp = a;
    a = b;
    b = temp;
}