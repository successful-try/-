#include <iostream>
using namespace std;

int main()
{
    int end_code, inter_ver, checker_ver, result;
   // cout << "Enter the numbers: " << endl;
    cin >> end_code >> inter_ver >> checker_ver;

    if((inter_ver == 0) && (end_code != 0)){
        result = 3;
    }
    else if((inter_ver == 0) && (end_code == 0)){
        result = checker_ver;
    }
    else if (inter_ver == 1){
        result = checker_ver;
    }
    else if ((inter_ver == 4) && (end_code != 0)){
        result = 3;
    }
    else if ((inter_ver == 4) && (end_code == 0)){
        result = 4;
    }
    else if (inter_ver == 6){
        result = 0;
    }
    else if (inter_ver == 7){
        result = 1;
    }
    else{
        result = inter_ver;
    }


    cout << result << endl;

    return 0;
}
