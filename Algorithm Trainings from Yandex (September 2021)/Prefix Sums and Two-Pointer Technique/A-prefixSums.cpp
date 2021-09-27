#include <sstream>
#include <iostream>
#include <vector>

using namespace std;

int main() {

    int n,q;
    cin >> n >> q;
    vector<long long>pref_sum(n+1);
    pref_sum[0]=0;
    int left,right;
    int a;
    long long result;

    for(int i=1; i<(n+1); ++i){                //считаем преффиксную сумму
        cin >> a;
        pref_sum[i] = pref_sum[i-1] + a;
    }

    while(q){

        cin >> left >> right;

        cout << pref_sum[right] - pref_sum[left-1]  << '\n';

        --q;
    }


    return 0;
}


