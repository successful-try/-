#include <sstream>
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {

    int n;
    cin >> n;

    vector<long long>v(n,0) ;
    long long a;

    for(int i=0; i<n; ++i){
        cin >> a;
        v[i] = a;
    }

    long long ans = v[0], sum = 0, min_sum =0;

    for(int i=0;i<n;++i){
        sum +=v[i];
        ans = max(ans, sum - min_sum);
        min_sum = min (min_sum, sum);
    }

    cout << ans << endl;


    return 0;
}


