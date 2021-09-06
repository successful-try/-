#include <iostream>
#include <vector>
#include <map>
#include <ctime>
#include <algorithm>

void PrintVector(const std::vector<int>& v)
{
    if (v.empty())
    {
        std::cout << "Vector is empty"<< std::endl;
    }
    for (int i = 0; i < v.size(); i++)
    {
        std::cout << 'v' << '[' << i << ']' << " = " << v[i] << std::endl;
    }
}
void PrintMap(const std::map<int,int>& m)
{
    if (m.empty())
    {
        std::cout << "Map is empty" << std::endl;
    }
    for (const auto& key : m)
    {
        std::cout << '{' << key.first << " : " << key.second << '}' << std::endl;
    }
}
void Vector_Map_Synchronization(std::vector<int>& v, std::map<int,int>& m)
{
    bool flag = false;
    for (int i = 0; i < v.size(); )
    {
        flag = false;
        for (std::map<int, int>::iterator it = m.begin(); it != m.end(); ++it)
        {
            if (v[i] == it->second)
            {
                flag = true;
                break;
            }
        }

        if (!flag)
        {
            v.erase(v.begin() + i);
        }
        else
        {
            i++;
        }
    }

    for (std::map<int, int>::iterator it = m.begin(); it != m.end(); )
    {
        flag = false;
        for (int i = 0; i < v.size(); i++)
            if (it->second == v[i])
            {
                flag = true;
                break;
            }

        if (!flag)
        {
            std::map<int, int>::iterator tmp_it = it;
            ++tmp_it;
            m.erase(it);
            it = tmp_it;
        }
        else
        {
            ++it;
        }

    }
}


int main()
{
    std::cout << "Enter vector and map size, please" << std::endl;
    int to_insert_number; // vector or map size
    std::cin >> to_insert_number;
    std::vector<int>v(to_insert_number);
    std::map<int,int>m;
    std::srand(time(nullptr));
    int random_number;

    for (int i = 0; i < to_insert_number; i++)
    {
        random_number = std::rand()%10;
        v[i] = random_number;
        random_number = std::rand()%10;
        m[i] = random_number;
    }

    PrintVector(v);
    std::cout << std::endl;
    PrintMap(m);
    std::cout << std::endl;

    int to_delete_number = std::rand() % std::min(16, to_insert_number);
    std::cout << "The number of elements to be deleted: " << to_delete_number << std::endl;
    int to_delete_index_number;

    for (int i = 0; i < to_delete_number; i++)
    {
        to_delete_index_number = std::rand() % to_insert_number;
        std::swap(v[to_delete_index_number], v[to_insert_number-1]);
        v.pop_back();

        to_delete_index_number = std::rand() % to_insert_number ;
        m.erase(std::next(m.begin(), to_delete_index_number));

        to_insert_number--;
    }

    std::cout << "After deletion:" << std::endl;
    PrintVector(v);
    std::cout << std::endl;
    PrintMap(m);
    std::cout << std::endl;


    Vector_Map_Synchronization(v, m);
    std::cout << "After Synchronization:" << std::endl;
    PrintVector(v);
    std::cout << std::endl;
    PrintMap(m);
    std::cout << std::endl;


    return 0;
}

