#include <iostream>
#include <math.h>
#include <vector>
#include <algorithm>
#include <array>
#include <bits/stdc++.h>
using namespace std;

int main()
{
   string s;
   cin >> s;
   int counter = 0;

   for(int i=0;i<s.size()/2;++i){      //Необходимо сравнить только половину значений
        if(s[i] != s[s.size()-1-i]){   // по схеме: 1-й с n-м, 2-й с (n-1)-м и т.д.
            ++counter;
        }
   }

   cout << counter << endl;

    return 0;
}
