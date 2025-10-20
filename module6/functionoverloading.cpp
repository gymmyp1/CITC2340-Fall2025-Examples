#include <iostream>

using namespace std;

double avg(double n1, double n2);
double avg(double n1, double n2, double n3);

int main() {
    cout << avg(2, 4) << endl;
    cout << avg(2, 4, 6) << endl;
    return 0;
}

double avg(double n1, double n2) {
    cout << "using avg function with 2 parameters" << endl;
    return (n1 + n2)/2;
}
double avg(double n1, double n2, double n3) {
    cout << "using avg function with 3 parameters" << endl;
    return  (n1 + n2 + n3)/3;
}