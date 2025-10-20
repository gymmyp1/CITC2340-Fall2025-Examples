int main() {
    double n = 20;
    bool even;
    char posOrNeg;
    int integerPart;

    figureIt(n, even, posOrNeg, integerPart);

    if(even) {
        cout << "the number is even." << endl;
    }
    return 0;
}

/* Description: figures out information about x
   Parameters:
     x - the number to figure information about
     divisible - true if x is even, false otherwise
     sign - whether the number is positive or not
     intPart - the integer part of x (no rounding)
   Returns:  nothing
   Pre-condition: x is initialized to a valid number
   Post-condition: divisible, sign, and intPart all have their actual values 
   altered based off the criteria above
*/
void figureIt( double x, bool& divisible, char& sign, int& intPart ) {
    //determine if the number is even or not
    if(x % 2 == 0) {
        //then it's even
        divisible = true;
    } else {
        divisible = false;
    }

    //determine if it's positive or negative
    //not done

    
    //determine the integer part of x
    //not done
}
