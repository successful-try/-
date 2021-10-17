#include <bits/stdc++.h>
#include <string>
#include <iostream>
#include <algorithm>
using namespace std;

int find_left_border(const vector<int>& v, int value){

    int left  = 0;
    int right = v.size();
    int mid = 0;

    while(right > left){

      mid = (right + left) / 2;
      if(v[mid] >= value){
        right = mid;
      }
      else{
        left = mid + 1;
      }

     }
     return left;
}

int main()
{
       int N;
       cin >> N;
       vector<int>v(N);
       int x;

       for(int i=0;i<N;++i){
            cin >>  v[i];
       }

       int M;
       cin >> M;

       int result;
       int auxillary;
       for(int i=0;i<M;++i){

            cin >> x;

            result    = find_left_border(v , x);
            auxillary = find_left_border(v , x+1);

            if(result == v.size()){                            // Если нет элемента, при этом
                cout << "0 0" << endl;                         // данный элемент справа
            }

            else if(v[result] != x){                           // Если нет элемента, при этом
                                                               // данный элемент слева
                    cout << "0 0" << endl;
            }

            else{
                cout << ++result << " " << auxillary << endl;  //
            }
       }
       return 0;

}

