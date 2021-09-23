#include <iostream>
using namespace std;

int main()
{
    int x, y, z;
	int result = 0;
    cin >> x >> y >> z;

	if(x >= 13 || y >= 13 || (x == y)){
		result = 1;
	}

    cout << result << endl;

    return 0;
}
