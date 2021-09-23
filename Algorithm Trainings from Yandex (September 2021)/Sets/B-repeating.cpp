#include <iostream>
#include <vector>
#include <set>
#include <algorithm>
#include <stdio.h>
#include <sstream>
#include <string>
using namespace std;

int main()
{
    set<int>s;
    int x;
    string str;

    while(cin >> x)
    {

        if(s.find(x) == s.end()){
            cout << "NO" << endl;
        }
        else
            cout << "YES" << endl;

        s.insert(x);

    }

    return 0;
}



