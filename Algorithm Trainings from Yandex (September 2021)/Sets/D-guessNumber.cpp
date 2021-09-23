#include <iostream>
#include <set>
#include <algorithm>
#include <sstream>
#include <string>
using namespace std;

int main()
{

    string str;
    getline(cin , str);
    stringstream flow(str);

    int n;
    flow >> n;

    set<int>Possible;               //Записываем возм. числа Августа
    for(int i = 1; i <= n; ++i){
        Possible.insert(i);
    }

    set<int> Beatrice;
    set<int> intersect;
    int x;


    flow.str("");
    flow.clear();

    getline(cin , str);
    flow << str;


while(str != "HELP"){

   while(!flow.eof()){

        flow >> x;
        Beatrice.insert(x);       //Записываем догадки Беатрис
    }

    getline(cin,str);

    if(str == "NO"){
       for(auto &b : Beatrice){
            Possible.erase(b);   //Удаляем числа, которые точно
       }                         //не подходят
    }
    else if(str == "YES"){
        set_intersection(Possible.begin(), Possible.end(),
                         Beatrice.begin(), Beatrice.end(),
                    inserter(intersect, intersect.begin()));

        Possible = intersect;    //
    }


    flow.str("");
    flow.clear();

    getline(cin , str);
    flow << str;

    Beatrice.clear();
    intersect.clear();

}

    for(auto &p : Possible){
            cout << p << " ";
        }

    return 0;
}


