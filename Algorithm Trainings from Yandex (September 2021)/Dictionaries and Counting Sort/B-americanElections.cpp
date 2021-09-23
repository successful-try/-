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

    string surname;
    int votes;
    map<string,int>m;


    while(cin >> surname){

        cin >> votes;

        if(m.find(surname) == m.end()){
            m[surname] = votes;
        }
        else
            m[surname]+=votes;
    }


    for(const auto& m_ : m){

        cout << m_.first << " " << m_.second  << '\n';
    }


    return 0;
}


