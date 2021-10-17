#include <bits/stdc++.h>
#include <string>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <cstdint>
using namespace std;

uint64_t how_many_days(uint64_t A,  uint64_t K, uint64_t B, uint64_t M, uint64_t X){

   uint64_t left  = 0;
   uint64_t right = 2 * X / A + 1;                    //Увеличиваем Х в два раза, поскольку можно отдыхать каждый второй день

   uint64_t mid;
   uint64_t in_progress;
   uint64_t Dm_rest;
   uint64_t Fd_rest;

    while(right > left){

        mid = (right+left)/2;                         //Кол-во дней вырубки для сравнения

        Dm_rest = mid/K;
        Fd_rest = mid/M;

        in_progress = A*(mid - Dm_rest) + B*(mid-Fd_rest);

        if(in_progress >= X){
            right = mid;
        }
        else{
            left  = mid+1;
        }

    }

     return left;
}

int main()
{
   uint64_t Dm_work, Dm_rest;
   uint64_t Fd_work, Fd_rest, Trees;
   cin >> Dm_work >> Dm_rest >> Fd_work >> Fd_rest >> Trees;

   cout << how_many_days(Dm_work,Dm_rest,Fd_work,Fd_rest,Trees);


       return 0;

}

