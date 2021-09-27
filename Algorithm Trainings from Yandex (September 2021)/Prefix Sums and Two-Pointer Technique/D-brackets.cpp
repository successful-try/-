#include <bits/stdc++.h>
#include <string>
#include <iostream>
using namespace std;

int main()
{
       string s;
       cin >> s;
       bool flag=true;

       if(s.size()%2 != 0){
         cout << "NO" << endl;
         return 0;
       }

       int counter_right=0;
       int counter_left=0;

       for(int i=0;i<s.size();++i){

            if(s[i] == '('){
                ++counter_left;
            }
            else if(s[i] == ')'){
                ++counter_right;
            }

            if(counter_right > counter_left){        //Если закрывыющих скобок стало больше, то NO
                cout << "NO" << endl;
                flag = false;
                return 0;
            }

       }

       if(counter_left != counter_right){             //Если тест только с открывающими скобками
            cout << "NO" << endl;
            return 0;
       }

       if(flag){
        cout<< "YES";
       }

       return 0;

}

