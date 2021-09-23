#include <iostream>
using namespace std;



int main()
{
    int N, beg_station, end_station, result;
    cin >> N >> beg_station >> end_station;


	if(end_station < beg_station)                    // Меняем местами начальную и конечную станции,
	{                                                // если индекс начальной больше конечной.
		int tmp = beg_station;
		beg_station = end_station;
		end_station = tmp;
	}

	int right_direction  = end_station - beg_station;
	int left_direction   = N - right_direction;


	if(right_direction <= left_direction){           //Определяем в какую сторону быстрее двигаться:
				result = right_direction -1;         //влево или вправо
	}
	else if( right_direction > left_direction){
				result = left_direction -1;
	}



    cout << result << endl;

    return 0;
}
