// C. Родословная: LCA

// Ограничение времени                 2 секунды
// Ограничение памяти                  64Mb
// Ввод                                стандартный ввод или input.txt
// Вывод                               стандартный вывод или output.txt

// В генеалогическом древе определите для двух элементов их наименьшего общего 
// предка. Наименьшим общим предком элементов A и B является такой элемент C, 
// что С является предком A, C является предком B, при этом глубина C является 
// наибольшей из возможных. При этом элемент считается своим собственным 
// предком.

// Формат ввода

// Формат входных данных аналогичен предыдущей задаче.

// Формат вывода

// Для каждого запроса выведите наименьшего общего предка данных элементов.

// Пример
// Ввод                            Вывод
// 9                               Paul_I
// Alexei Peter_I                  Peter_I
// Anna Peter_I                    Anna
// Elizabeth Peter_I
// Peter_II Alexei
// Peter_III Anna
// Paul_I Peter_III
// Alexander_I Paul_I
// Nicholaus_I Paul_I
// Alexander_I Nicholaus_I
// Peter_II Paul_I
// Alexander_I Anna


#include <bits/stdc++.h>
#include <string>
#include <map>
#include <set>
#include <utility>
using namespace std;

/*1. Ïðîâåðèòü ñåáÿ
2. Êîìïàðàòîð äîáàâèòü*/

struct comp{
    bool operator()(pair<string , int> a , pair<string , int> b){

            return a.first < b.first;
    }
  //set will now be ordered on the basis of the second elements i.e. marks in descending order.
};


int main(){

    int n;
    string child,parent,person_1,person_2,str;
    map<string,string> child_parent;

    cin >> n;
    int i = n-1;

    while(i){
        cin >> child >> parent;
        child_parent[child] = parent;
        --i;
    }

    getchar();
    while(getline(cin,str)){

        int pos = str.find(" ");
        person_1 = str.substr(0,pos);
        person_2 = str.substr(pos+1,str.size()-pos);

        string tmp = person_1;
        int depth = 0;

        set <pair <string,int>, comp> parents_1,parents_2,ans;


        pair<string, int> p1 (person_1,0);                           //Ïðîâåðêà ñàìîãî ñåáÿ
        parents_1.insert(p1);

        while(child_parent.find(tmp) != child_parent.end()){

            pair<string, int> add (child_parent[tmp],++depth);
            parents_1.insert(add);
            tmp = child_parent[tmp];

        }

        tmp = person_2;
        depth = 0;


        pair<string, int> p2 (person_2,0);                           //Ïðîâåðêà ñàìîãî ñåáÿ
        parents_2.insert(p2);

        while(child_parent.find(tmp) != child_parent.end()){

            pair<string, int> add (child_parent[tmp],++depth);
            parents_2.insert(add);
            tmp = child_parent[tmp];

        }


         set_intersection(parents_1.begin(), parents_1.end(),
                          parents_2.begin(), parents_2.end(),
                          inserter(ans, ans.begin()), comp());


        int min_ = n;
        string answer;
        for(auto a:ans){

            if(a.second < min_){
                min_ = a.second;
                answer = a.first;
            }
        //    cout << a.first << ":" << a.second << endl;
        }


        cout << answer << endl;
      //  cout << '\n';


    }


	return 0;
}



