#include <bits/stdc++.h>
#include <string>
#include <iostream>
#include <algorithm>
#include <math.h>
using namespace std;

int a,b,c,d;

double equation(double x){

    double result;
    result = a*x*x*x + b*x*x + c*x + d;
    return result;

}

double find_point(double left, double right){

    double mid = 0;

    while(fabs(right - left) > 0.0000001){

      mid = (right + left) / 2;

      if(equation(right)*equation(mid)> 0){
            right = mid;
      }

      else{
            left = mid;
      }

    }
     return mid;
}

int main()
{

       cin >> a >> b >> c >> d;



       int first = 0,second=0;
       double res,left=-1001,right=1001;
       res = d;


        res = find_point(left,right);
        cout << setprecision(10) << res;

        return 0;

}

