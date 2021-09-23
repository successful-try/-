#include <iostream>
#include <math.h>
#include <vector>
#include <array>
#include <bits/stdc++.h>
using namespace std;

//Binary sorting// - не проходит по TimeLimit;

int main()
{
/*    int N;

	long long sum_1 = 0;
	long long sum_2 = 0;

	cin >> N;
	int arr[N];*/



	/*for(auto& x : v){
		cin >> x;
	}*/

	/*
	for(int i=0; i<N; ++i){
        cin >> arr[i];
	}


	int left = arr[0];
	int right = arr[N-1]+1;
	int mid_1 = 0;
    int mid_2 = 0;*/
/*
	while(left != right-1)
    {
        mid_1 =(left + right)/2;
        mid_2 = mid_1 - 1;
        sum_1 = 0;
        sum_2 = 0;

        for(int i=0; i<N; ++i){
           sum_1 += abs(mid_1 - arr[i]);
           sum_2 += abs(mid_2 - arr[i]);
	}*/

        /*for(auto& x : v){
		   sum_1 += abs(mid_1 - x);
           sum_2 += abs(mid_2 - x);
		}*/

/*
        if(sum_1 <= sum_2){
            left = mid_1;
        }
        else{
            right = mid_1;
        }*/

      /*  cout << "sum_1:" << sum_1 << endl;
         cout << "sum_2:" << sum_2 << endl;
          cout << "left:" << left << endl;
           cout << "right:" << right << endl;*/

	/*cout << left << endl;*/




  vector<int> a;
  int n, bb;
  cin >>n;
  for (int i = 0; i < n; ++i){
    cin >> bb;
    a.push_back(bb) ;
     }
  cout << a[a.size()/2];                //Берём индекс среднего ученика



    return 0;
}
