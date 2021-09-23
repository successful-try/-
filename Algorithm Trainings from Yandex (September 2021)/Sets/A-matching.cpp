#include <iostream>
#include <set>
#include <algorithm>
using namespace std;

int main()
{
    set<int>s1;
    set<int>s2;
    set<int> intersect;

    int x;
    cin >> x;
    s1.insert(x);

    char c = getchar();   //Пропускаем пробел

    while(c != '\n')
    {
        cin >> x;
        s1.insert(x);
        c = getchar();
    }

    cin >> x;
    s2.insert(x);
    c = getchar();

    while(c != EOF)
    {
        cin >> x;
        s2.insert(x);
        c = getchar();
    }


    set_intersection(s1.begin(), s1.end(), s2.begin(), s2.end(),
                 inserter(intersect, intersect.begin()));

    cout << intersect.size();


    return 0;
}
