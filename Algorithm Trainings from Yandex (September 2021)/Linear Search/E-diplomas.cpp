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
   int x;

   int sec=0;
   int max_folder = 0;

   for(int i=0;i<N;++i){
    cin >> x;
    if(x > max_folder){
        max_folder = x;
    }
    sec+=x;
   }

    sec-=max_folder;
    cout << sec <<endl;


    return 0;
}
