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

int main()
{

     map<string,int>m;
     map<int , set<pair<int,string>, greater <pair<int,string>> >, greater <int>>r;
     int first_election_number = 0;
   // map<int,set<string>, greater <int>>reverse_;
     string str;
     vector<string>v;
    //flow(str);

    string party;
    int votes = 0;

    int seats = 450;
    int overall = 0;
    int border = 450;
    int reminder = 0;
    size_t found;

    while(getline(cin, str)){

        found = str.rfind(" ");
        votes = 0;
        for(int i = found+1; i < str.size(); ++i){
            votes = votes*10 + (str[i] - '0');
        }
        party = str.substr(0,found);
        v.push_back(party);

        m[party] = votes;
        overall += votes;
    }

   /* first_election_number = overall/seats;
    if(first_election_number == 0){
        first_election_number = 450;
    }*/

    for(auto& m_ : m){
        //border -= m_.second/first_election_number;
        border -= m_.second * 450 / overall;
       // reminder = m_.second % first_election_number;
        reminder = m_.second * 450 % overall;
       // m[m_.first] = m_.second / first_election_number;
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


