#include <iostream>
#include <set>
#include <algorithm>
#include <sstream>
#include <string>
#include <array>
#include <vector>
#include <map>
#include <cstdint>
using namespace std;


int main()
{
    int n;
    cin >> n;
    int64_t key;
    int64_t value;
    map<int64_t,int64_t>m;


    for(int i=0;i<n;++i){
        cin >> key;
        cin >> value;
        if(m.find(key) == m.end()){
            m[key] = value;
        }
        else
            m[key]+=value;
    }


    for(const auto& m_ : m){

        cout << m_.first << " " << m_.second  << '\n';
    }


    return 0;
}


