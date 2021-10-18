#include <bits/stdc++.h>
#include <string>
#include <iostream>
#include <algorithm>
#include <math.h>
using namespace std;


int main()
{
    int N;
    cin >> N;

    vector<pair<long long,long long>>v(N);

    for(int i=0;i<N;++i){

        cin >> v[i].first >> v[i].second;

    }

    sort(v.begin(),v.end());                       // ���������� �� first
    long long length = v[0].second - v[0].first;   //������� ����� ������� �������
    long long left   = v[0].first;
    long long right  = v[0].second;


    for(int i=1;i<N;++i){

        if(v[i].first >= right){
            length += v[i].second - v[i].first;    //���� ������ ����������
            left    = v[i].first;                  //������� ������ ����� ����-��,
            right   = v[i].second;                 //�� ���������� ��� �����
        }

        else{
            if(v[i].second > right){                //���� ����� ����-��
                length += v[i].second - right;      //������� ������ ����� ����-��,
                right   = v[i].second;              //�� ���������� �� �������
            }
         }
      }

    cout << length;
   /* for(const auto& a: v){
        cout << a.first << " " << a.second;
        cout << endl;
    }
*/


       return 0;

}

