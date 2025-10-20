#include <iostream>

using namespace std;

void f( int &i );

int main()
{
	int i = 6;
	f( i );
	cout << i;	       // What prints out here?
	return( 0 );
}
void f( int &i )
{
	i = -1;
}