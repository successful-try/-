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

/*
#include <iostream>
#include <vector>
#include <cstdint>
#include <unordered_map>

using namespace std;

vector<int64_t> Vector() {
    int n;
    cin >> n;
    vector<int64_t> v(n);
    for(int i = 0; i < n; ++i) {
        int64_t number;
        cin >> number;
        v[i] = number;
    }
    return v;
}

unordered_map<int64_t, int> Map() {
    int n;
    cin >> n;
    unordered_map<int64_t, int> m;
    for(int i = 0; i < n; ++i) {
        int64_t number;
        cin >> number;
        if(m.find(number) == m.end()) {
            m[number] = i;
        }
    }
    return m;
}

int main() {
    int64_t S;
    cin >> S;
    auto A = Vector();
    auto B = Vector();
    auto C = Map();
    vector<int> answer = {-1};
    for (int i = 0; i < A.size(); ++i) {
        for(int j = 0; j < B.size(); ++j) {
            if(C.find(S - A[i] - B[j]) != C.end()) {               //Из заданного числа S
                answer = vector<int>{i, j, C[S - A[i] - B[j]]};    //вычитаем числа из массивов
                i = A.size();                                      //A и B, а затем ищем остаток
                j = B.size();                                      //в мапе С
            }
        }
    }

    for(auto i : answer) {
        cout << i << " ";
    }

    return 0;
}


*/
