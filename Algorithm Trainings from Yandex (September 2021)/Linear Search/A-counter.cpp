#include <iostream>
#include <math.h>
#include <vector>
#include <algorithm>
#include <array>
#include <bits/stdc++.h>
using namespace std;


int main()
{
    int N;
    cin >> N;
    int counter = 0;
    int max_ = N;

    while(N != 0){

        if(max_ < N){               //Определяем максимальный элемент
            max_ = N;
            counter = 1;
        }

        else if ( max_ == N){       //Увеличиваем счётчик максимального элемента
            counter++;
        }

        cin >> N;
    }


    cout << counter;



    return 0;
}
