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

   for(int i=0;i<s.size()/2;++i){      //���������� �������� ������ �������� ��������
        if(s[i] != s[s.size()-1-i]){   // �� �����: 1-� � n-�, 2-� � (n-1)-� � �.�.
            ++counter;
        }
   }

   cout << counter << endl;

    return 0;
}
