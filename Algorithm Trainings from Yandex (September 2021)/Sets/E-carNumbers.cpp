#include <iostream>
#include <set>
#include <algorithm>
#include <sstream>
#include <string>
#include <array>
#include <vector>
using namespace std;

int main()
{
    string str;

    int M;
    cin >> M;

    vector<string> Witness(M);

    for(int i = 0; i < M; ++i){

        cin >> str;
        Witness[i] = str;

    }

    int N;
    cin >> N;

    vector<string> Sign(N);

    for(int i = 0; i < N; ++i){

        cin >> str;
        Sign[i] = str;

    }

    vector<int> result;
    int min_counter = 0;
    string string_intersection,tmp_Sign, tmp_Witness ;

    for(int i = 0; i < N; ++i){
        min_counter = 20;
        for(int j = 0; j < M; ++j){
            tmp_Sign = Sign[i];
            tmp_Witness = Witness[j];
            sort(tmp_Sign.begin(), tmp_Sign.end());
            sort(tmp_Witness.begin(),tmp_Witness.end());
            string_intersection.clear();
            set_intersection(tmp_Sign.begin(), tmp_Sign.end(),
                             tmp_Witness.begin(), tmp_Witness.end(),
                             inserter(string_intersection, string_intersection.begin()));
            if(min_counter > string_intersection.size()){
                min_counter = string_intersection.size();
            }

        }
        result.push_back(min_counter);
    }

   int max_ = *max_element(result.begin(),result.end());

   for(int i = 0; i<N; ++i){
        if(result[i] == max_){
            cout << Sign[i] << endl;
        }
   }

    return 0;
}


