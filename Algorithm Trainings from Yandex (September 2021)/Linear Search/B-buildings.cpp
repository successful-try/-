#include <iostream>
#include <math.h>
#include <vector>
#include <algorithm>
#include <array>
#include <bits/stdc++.h>
using namespace std;

int main()
{
    vector<int> v(10);
    for(auto& x : v)
    {
        cin >> x;
    }

    int house = 1;
    int shop = 2;
    int min_dist;
    int max_min_dist = 0;
    int tmp = 0;

    for(int i=0;i<10;++i){               // � ������� ���� ������ ������������ ����������� ��������� �� ��������
        if(v[i] == 1){                   //  ��� i-�� ����, � ����� ���������� ������������ ��������� �� ���������

           min_dist = 100;               //"��������" ����������� ��������� ��� ������ ������
           for (int j=0;j<10;++j){
                if(v[j] == 2){
                   tmp = abs(i-j);
                   if(tmp < min_dist){
                       min_dist = tmp;
                   }
                }
           }
           if(min_dist > max_min_dist){
                max_min_dist = min_dist;
         }

        }
    }

    cout << max_min_dist << endl;

    return 0;
}
