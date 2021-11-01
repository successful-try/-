// B. Родословная: предки и потомки

// Ограничение времени               2 секунды
// Ограничение памяти                64Mb
// Ввод                              стандартный ввод или input.txt
// Вывод                             стандартный вывод или output.txt

// В генеалогическом древе у каждого человека, кроме родоначальника, есть ровно
// один родитель.

// Каждом элементу дерева сопоставляется целое неотрицательное число, называемое
// высотой. У родоначальника высота равна 0, у любого другого элемента высота на
// 1 больше, чем у его родителя.

// Даны два элемента в дереве. Определите, является ли один из них потомком
// другого.

// Формат ввода

// Программа получает на вход число элементов в генеалогическом древе N. Далее
// следует N−1 строка, задающие родителя для каждого элемента древа, кроме
// родоначальника. Каждая строка имеет вид имя_потомка имя_родителя.

// Далее до конца файла идут строки, содержащие имена двух элементов дерева.

// Формат вывода

// Для каждого такого запроса выведите одно из трех чисел: 1, если первый
// элемент является предком второго, 2, если второй является предком первого или
// 0, если ни один из них не является предком другого.

// Пример

// Ввод                          Вывод
// 9                             1 2 0
// Alexei Peter_I
// Anna Peter_I
// Elizabeth Peter_I
// Peter_II Alexei
// Peter_III Anna
// Paul_I Peter_III
// Alexander_I Paul_I
// Nicholaus_I Paul_I
// Anna Nicholaus_I
// Peter_II Peter_I
// Alexei Paul_I


#include <bits/stdc++.h>
#include <string>
#include <map>
using namespace std;


int main(){

    int n;
    string child,parent,person_1,person_2,str;
    map<string,string> child_parent;

    cin >> n;
    --n;

    while(n){
        cin >> child >> parent;
        child_parent[child] = parent;
        --n;
    }

    getchar();
    while(getline(cin,str)){

        int pos = str.find(" ");
        person_1 = str.substr(0,pos);
        person_2 = str.substr(pos+1,str.size()-pos);
        string tmp = person_1;


        while( (child_parent.find(tmp) != child_parent.end()) && (child_parent[tmp] != person_2)){

            tmp = child_parent[tmp];

        }

        if(child_parent.find(tmp) != child_parent.end()){
            cout << 2 << " ";
            continue;
        }

        tmp = person_2;
        while( (child_parent.find(tmp) != child_parent.end()) && (child_parent[tmp] != person_1)){

            tmp = child_parent[tmp];

        }

        if(child_parent.find(tmp) != child_parent.end()){
            cout << 1  << " ";
            continue;
        }

        cout << 0  << " ";


    }


	return 0;
}



