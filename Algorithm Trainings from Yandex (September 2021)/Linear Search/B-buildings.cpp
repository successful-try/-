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

    for(int i=0;i<10;++i){               // С помощью двух циклов рассчитываем минимальную дистанцию до магазина
        if(v[i] == 1){                   //  для i-го дома, а затем определяем максимильную дистанцию из мнималных

           min_dist = 100;               //"Обнуляем" минимальную дистанцию для нового здания
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
