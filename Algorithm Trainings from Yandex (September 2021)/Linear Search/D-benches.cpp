#include <iostream>
#include <math.h>
#include <vector>
#include <algorithm>
#include <array>
#include <bits/stdc++.h>
using namespace std;

int main()
{
   int L,K;                             //L-длина лавочки
   cin >> L >> K;                       //К- количество блоков
   vector<int> v(K);

   for(auto& x : v){                    //Положения блоков относительно
        cin >> x;                       //левого края лавочки
   }

    int middle = L/2;
    bool flag = false;
    int left,right;

    for(int i = 0; i<K;  ++i){

        if(v[i] == middle && (L%2!=0)){ //Если длина лавочки нечётное число
            flag = true;                //и один из блоков стоит точно в
            cout << middle;             //середние, то это и есть ответ
            break;
        }

        else if(v[i] < middle)          //В случае, если нет блока в середине
        {                               //лавочки, то оставляем ближайше два
            left = v[i];                //блока к середине: один слева, другой
        }                               //справа

         else if(v[i] >= middle)
        {
            right = v[i];
            break;
        }

    }

    if(!flag){
        cout << left << " " << right << endl;
    }




    return 0;
}
