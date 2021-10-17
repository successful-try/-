#include <bits/stdc++.h>
#include <string>
#include <iostream>
#include <algorithm>
using namespace std;

int find_left_border(const vector<int>& v, int value){

    int left  = 0;
    int right = v.size();                   //
    int mid = 0;

    while(right > left){

      mid = (right + left) / 2;
      if(v[mid] >= value){
        right = mid;
      }
      else{
        left = mid + 1;                      //Если mid строго меньше value,
      }                                      //то left сдвигаем на следующий
                                             //индекс прямо за mid
     }
     return left;
}

int main()
{
       int N;
       cin >> N;
       int x;

       vector<int>v(N);
       for(int i=0;i<N;++i){
         cin >> x;
         v[i] = x;
       }

       sort(v.begin(),v.end());

       int K;
       cin >> K;
       int left,right,l,r;

       while(K){

        cin >> left >> right;

        l = find_left_border(v,left);
        r = find_left_border(v,right+1);        //Передаём right на +1 больше, чтобы
                                                //учесть все максимальнве элементы
        cout << r-l << " ";                     //массива, которые равны value

          --K;
       }

       return 0;

}

