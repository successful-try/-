#include <iostream>
#include <vector>
#include <set>
#include <algorithm>
#include <stdio.h>
#include <sstream>
#include <string>
using namespace std;

int main()
{
   vector<int>v;
   set<int>s;
   set<int>povtor;
   int x;
   string str;

   getline(cin , str);
   stringstream flow(str);

   while(!flow.eof()){
        flow >> x;
        v.push_back(x);

        if(s.find(x) != s.end()){            //Складируем элементы с повтором и без
            povtor.insert(x);                //в два различных множества
        }
        else{
             s.insert(x);
        }

    }

    for(auto& elem : v){                      //Вывод неповтовторяющихся
        if(povtor.find(elem) == povtor.end()) //элементов в порядке появления
            cout << elem << " ";
    }


    return 0;
}
