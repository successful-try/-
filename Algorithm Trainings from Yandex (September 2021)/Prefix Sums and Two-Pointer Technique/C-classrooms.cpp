#include <bits/stdc++.h>
using namespace std;
int main()
{
    vector<pair<int,int> > g,r;
    int n,m,i,j,x,y;
    cin>>n>>m;

    for(i=0;i<n;i++)
    {
        cin>>x;
        g.push_back(make_pair(x+1,i));
    }
    for(j=1;j<=m;j++)
    {
        cin>>x;
        r.push_back(make_pair(x,j));
    }

    sort(g.begin(),g.end());
    sort(r.begin(),r.end());

    y=0;i=0;j=0;

    int ans[n];

    while(i<n && j<m)
    {
        if (g[i].first<=r[j].first)
        {
            ans[g[i].second]=r[j].second;
            i++;j++;y++;
        }
        else
        {
            j++;
        }
    }

    while(i<n)                      //i для оставшихся нераспределенных групп
    {
        ans[g[i].second]=0;
        i++;
    }

    cout<<y<<endl;                  //Counter

    for(i=0;i<n;i++)
    {
        cout<<ans[i]<<" ";
    }

       return 0;

}

