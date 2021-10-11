#include <iostream>
#include <set>
#include <algorithm>
#include <sstream>
#include <string>
#include <array>
#include <vector>
#include <map>
#include <cstdint>
#include<bits/stdc++.h>
using namespace std;

//Падает на 15-м тесте
int main()
{

     map<string,int>m;
     map<int , set<pair<int,string>, greater <pair<int,string>> >, greater <int>>r;
     int first_election_number = 0;
     string str;
     vector<string>v;


    string party;
    int votes = 0;

    int seats = 450;
    int overall = 0;
    int border = 450;
    int reminder = 0;
    size_t found;

    while(getline(cin, str)){

        found = str.rfind(" ");                      //Ищем последний пробел
        votes = 0;                                   
        for(int i = found+1; i < str.size(); ++i){
            votes = votes*10 + (str[i] - '0');       //Преобразовываем строку в числу поразрядно
        }                                            
        party = str.substr(0,found);
        v.push_back(party);                          

        m[party] = votes;
        overall += votes;
    }

    for(auto& m_ : m){
        border -= m_.second * 450 / overall;
        reminder = m_.second * 450 % overall;
        m[m_.first] = m_.second * 450 / overall;

        r[reminder].insert(make_pair(m[m_.first],m_.first));
    }

    if(border > 0){
        for(auto& r_ : r){

            if(border == 0){
                break;
            }

            for(auto& pair_ : r[r_.first]){
                ++m[pair_.second];
                --border;
                if(border == 0){
                    break;
                }
            }
        }
    }

    for(const auto& v_ : v){
     cout << v_ << " " << m[v_] << endl;
    }

    return 0;
}


