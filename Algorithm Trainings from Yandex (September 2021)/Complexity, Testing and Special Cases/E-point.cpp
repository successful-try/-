#include <iostream>
#include <math.h>
#include <vector>
#include <algorithm>
#include <array>
#include <bits/stdc++.h>
using namespace std;

int main()
{
    int d;
    cin >> d;                                                           //Координаты вершин треугольника
    int x,y, result;                                                    //Координаты точки, которую анализируем
    cin >> x >> y;
    int dist_1,dist_2,dist_3;

    if( (x <= d) && (y <= d) && (y <= (d-x)) && (x >= 0) && (y >= 0) )  //Условия на определение точки внутри треугольника
    {                                                                   //или на стороне треугольника.
        cout << 0 << endl;
    }
    else{
        dist_1 = sqrt(x*x + y*y);                                       //Высчитываем расстояние точки до вершин треугольника
        dist_2 = sqrt((x - d) * (x - d) + y*y);
        dist_3 = sqrt(x*x + (y-d)*(y-d) );

        if((dist_1 <= dist_2) && (dist_1 <= dist_3)){                   //Определяем ближайшую вершину к точке
            cout << 1;
        }
        else if((dist_2 <= dist_1) && (dist_2 <= dist_3)){
            cout << 2;
        }
        else
            cout << 3;


    }


    return 0;
}
