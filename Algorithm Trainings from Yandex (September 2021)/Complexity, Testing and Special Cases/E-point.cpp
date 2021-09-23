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
    cin >> d;                                                           //���������� ������ ������������
    int x,y, result;                                                    //���������� �����, ������� �����������
    cin >> x >> y;
    int dist_1,dist_2,dist_3;

    if( (x <= d) && (y <= d) && (y <= (d-x)) && (x >= 0) && (y >= 0) )  //������� �� ����������� ����� ������ ������������
    {                                                                   //��� �� ������� ������������.
        cout << 0 << endl;
    }
    else{
        dist_1 = sqrt(x*x + y*y);                                       //����������� ���������� ����� �� ������ ������������
        dist_2 = sqrt((x - d) * (x - d) + y*y);
        dist_3 = sqrt(x*x + (y-d)*(y-d) );

        if((dist_1 <= dist_2) && (dist_1 <= dist_3)){                   //���������� ��������� ������� � �����
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
