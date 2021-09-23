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
    string word;
    map<string,int>m;
    map<int,set<string>, greater <int>>reverse_;


    while(cin >> word){                          //���������� ������� ����

        if(m.find(word) == m.end()){
            m[word] = 1;
        }
        else
            m[word]+=1;
    }

    for(const auto& x: m){
            reverse_[x.second].insert(x.first);   //������ �� ��������� � ������ �����
    }                                             //���� � �������� � ���������� � ������� ��������

    map<int,set<string>> :: iterator it;

    for (it = reverse_.begin() ; it!=reverse_.end() ; ++it){
        for(const auto& x : it->second ){
            cout << x <<  endl;
        }
    }

    return 0;
}


