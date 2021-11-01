// A. Бинарное дерево (вставка, поиск, обход)

// Ограничение времени               1 секунда
// Ограничение памяти                64Mb
// Ввод                              стандартный ввод или input.txt
// Вывод                             стандартный вывод или output.txt

// Напишите программу, которая будет реализовывать действия в бинарном дереве
// поиска «вставить» и «найти» (по значению). Программа должна обрабатывать
// запросы трёх видов:

// ADD n — если указанного числа еще нет в дереве, вставлять его и выводить
// слово «DONE», если уже есть — оставлять дерево как было и выводить слово
// «ALREADY».

// SEARCH — следует выводить слово «YES» (если значение найдено в дереве) или
// слово «NO» (если не найдено). Дерево при этом не меняется.

// PRINTTREE — выводить все дерево, обязательно используя алгоритм, указанный в
// формате вывода результатов.

// Формат ввода

// В каждой строке входных данных записан один из запросов ADD n или SEARCH n
// или PRINTTREE. Гарантируется, что запросы PRINTTREE будут вызываться только в
// моменты, когда дерево не пустое. Общее количество запросов не превышает 1000,
// из них не более 20 запросов PRINTTREE.

// Формат вывода

// Для каждого запроса выводите ответ на него. Для запросов ADD и SEARCH —
// соответствующее слово в отдельной строке. На запрос PRINTTREE надо выводить
// дерево, обязательно согласно такому алгоритму:

// 1) Распечатать левое поддерево
// 2) Вывести количество точек, равное глубине узла
// 3) Вывести значение ключа
// 4) Распечатать правое поддерево

// Пример
// Ввод                Вывод
// ADD 2               DONE
// ADD 3               DONE
// ADD 2               ALREADY
// SEARCH 2            YES
// ADD 5               DONE
// PRINTTREE           2
// SEARCH 7            .3
//                     ..5
//                     NO



#include <bits/stdc++.h>
#include <string>
using namespace std;

struct Node{
  int value;
  struct Node* left;
  struct Node* right;
};

struct Node* Tree = nullptr;                        //Global variable(root)

 void Add(int number){

    struct Node* ptr = new struct Node;
    ptr->value       = number;
    ptr->left             = nullptr;
    ptr->right            = nullptr;

    if(Tree == nullptr){
        Tree = ptr;
        cout << "DONE" << endl;
        return;
    }

    else{
        struct Node* tmp  = Tree;
//      struct Node* prev = Tree;
        while(true){

            if(ptr->value < tmp->value){             //Идём в левое поддерево
                if(tmp->left == nullptr){            //до тех пор, пока есть
                   tmp->left = ptr;                  //куда идти
                   cout << "DONE" << endl;
                   break;
                }
                   tmp = tmp->left;
            }

            else if(ptr->value > tmp->value){        //Идём в левое поддерево
                if(tmp->right == nullptr){           //до тех пор, пока есть куда идти
                   tmp->right = ptr;
                   cout << "DONE" << endl;
                   break;
                }
                tmp = tmp->right;

            }

            else{                                    //Если значение уже есть в дереве
                    cout << "ALREADY" << endl;
                    break;
            }
        }
    }
 }

void Search(int number){

    struct Node* tmp = Tree;

    while(tmp != nullptr){

        if(number == tmp->value){
            cout << "YES" << endl;
            return;
        }

        else if(number < tmp->value){
            tmp = tmp->left;
        }

        else if(number > tmp->value){
            tmp = tmp->right;
        }
    }

    cout << "NO" << endl;

}


void Printtree(struct Node* ptr, int depth){


  if(ptr->left != nullptr){                      //Идём до конца левого поддерева

     Printtree(ptr->left, depth+1);

  }

  for(int i=0;i<depth;++i){
        cout << '.';
    }
    cout << ptr->value << endl;


   if(ptr->right != nullptr){                     //Идём до конца левого поддерева

      Printtree(ptr->right, depth+1);

   }
};


int main(){

	string str;
	string operation_name;
	int number;

	while(getline(cin,str)){

        int pos = str.find(" ");

        if(pos == string::npos){                            // If для считывания Printtree

            Printtree(Tree,0);
        }

        else{                                               // вычленяем строку и число

            operation_name = str.substr(0,pos);
            number         = stoi(str.substr(pos+1,str.size()-pos));

            if(operation_name == "ADD"){
                Add(number);
            }

            else if(operation_name == "SEARCH"){
                Search(number);
            }
        }
	}


	return 0;
}



