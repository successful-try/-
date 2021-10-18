#include <bits/stdc++.h>
#define ll long long int
using namespace std;

bool comp(const pair<int, bool>&a , const pair<int, bool>&b)
{
    if (a.first < b.first)
        return true;
    else if (a.first > b.first)
        return false;
    else
        return a.second > b.second;

}

int main(){
	ios_base::sync_with_stdio(0);
	cin.tie(0); cout.tie(0);

	int n;
	cin >> n;
	vector<pair<int, bool>> a;
	a.reserve(2 * n);                    //резерв в 2 раза больше, чтобы
	for (int i = 0; i < n; i++){         //было место для сортировка
		int t, l;
		cin >> t >> l;
		a.push_back({t, 0});             //время прибытия до обработки - false
		a.push_back({t + l, 1});         //вреия прибытия+обработка true
	}
	sort(a.begin(), a.end(), comp);
	int bal = 0, ans = 0;
	for (auto& item : a){
		if (!item.second) bal++;
		else bal--;
		ans = max(ans, bal);
	}
	cout << ans;

	return 0;
}

