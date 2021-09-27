#include <bits/stdc++.h>
#include <string>
#include <iostream>
using namespace std;

int main()
{
      int S;
      cin >> S;

      int n_a;
      cin >> n_a;
      int x;

      vector<int>v1(n_a);
      for(int i=0;i<n_a;++i){
        cin >> x;
        v1[i] = x;
      }


      int n_b;
      cin >> n_b;
      vector<int>v2(n_b);
      for(int i=0;i<n_b;++i){
        cin >> x;
        v2[i] = x;
      }


      int n_c;
      cin >> n_c;
    /*  vector<int>v3(n_c);
      for(int i=0;i<n_c;++i){
        cin >> x;
        v3[i] = x;
      }*/

      map<int,int>m;

      for(int i=0;i<n_c;++i){
          cin >> x;
          if(m.find(x) == m.end())
                m[x] = i;
      }

      int num_to_find;

      for(int i=0;i<n_a;++i){
        for(int j=0;j<n_b;++j){
             num_to_find = S - v1[i] - v2[j];
             if(num_to_find > 0 && m.find(num_to_find) != m.end()){
                cout << i << " " << j << " " << m[num_to_find];
                return 0;
            }
        }
      }


        cout << -1;
        return 0;


}

