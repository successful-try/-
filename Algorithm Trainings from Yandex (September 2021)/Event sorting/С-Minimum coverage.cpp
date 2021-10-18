#include <bits/stdc++.h>
using namespace std;


int main(){

	int M;
	cin >> M;

	vector<pair<int,int>>v;

	int l,r;
	cin >> l >> r;

	while(l!=0 || r!=0){
        v.push_back(make_pair(l,r));
        cin >> l >> r;
	}

	sort(v.begin(),v.end());


	int max_ = 0;
	int left,right,last_right = 0;
	int i = 0;
	int pos = 0;
    vector<int>order;


    while (i < v.size()) {
        max_ = 0;
     //   cout << v[i].first << " " << v[i].second << " " << last_right << endl << endl;
        while (i < v.size() && v[i].first <= last_right){         //»щем самую правую точку
            if(v[i].second > last_right){                         //от last_right
                if(max_ < v[i].second - last_right){
                    max_  = v[i].second - last_right;
                    right = v[i].second;
                    pos = i;
                }
            }
            ++i;
        }


        if(max_ == 0){
            cout << "No solution";
            return 0;
        }
        else{
            order.push_back(pos);
            last_right = right;                                   //ƒелаем новые рубеж дл€ след-х
            if(last_right >= M){                                  //итераций.
                break;
            }
        }

        i = pos + 1;
    }

    if(last_right < M){
        cout << "No solution";
        return 0;
    }

    cout << order.size() << endl;

    for(int j = 0;j<order.size();++j){
        cout << v[order[j]].first << " " << v[order[j]].second << endl;
    }


	return 0;
}



