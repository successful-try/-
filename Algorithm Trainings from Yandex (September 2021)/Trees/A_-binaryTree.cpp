// A. �������� ������ (�������, �����, �����)

// ����������� �������               1 �������
// ����������� ������                64Mb
// ����                              ����������� ���� ��� input.txt
// �����                             ����������� ����� ��� output.txt

// �������� ���������, ������� ����� ������������� �������� � �������� ������
// ������ ���������� � ������ (�� ��������). ��������� ������ ������������
// ������� ��� �����:

// ADD n � ���� ���������� ����� ��� ��� � ������, ��������� ��� � ��������
// ����� �DONE�, ���� ��� ���� � ��������� ������ ��� ���� � �������� �����
// �ALREADY�.

// SEARCH � ������� �������� ����� �YES� (���� �������� ������� � ������) ���
// ����� �NO� (���� �� �������). ������ ��� ���� �� ��������.

// PRINTTREE � �������� ��� ������, ����������� ��������� ��������, ��������� �
// ������� ������ �����������.

// ������ �����

// � ������ ������ ������� ������ ������� ���� �� �������� ADD n ��� SEARCH n
// ��� PRINTTREE. �������������, ��� ������� PRINTTREE ����� ���������� ������ �
// �������, ����� ������ �� ������. ����� ���������� �������� �� ��������� 1000,
// �� ��� �� ����� 20 �������� PRINTTREE.

// ������ ������

// ��� ������� ������� �������� ����� �� ����. ��� �������� ADD � SEARCH �
// ��������������� ����� � ��������� ������. �� ������ PRINTTREE ���� ��������
// ������, ����������� �������� ������ ���������:

// 1) ����������� ����� ���������
// 2) ������� ���������� �����, ������ ������� ����
// 3) ������� �������� �����
// 4) ����������� ������ ���������

// ������
// ����                �����
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

            if(ptr->value < tmp->value){             //��� � ����� ���������
                if(tmp->left == nullptr){            //�� ��� ���, ���� ����
                   tmp->left = ptr;                  //���� ����
                   cout << "DONE" << endl;
                   break;
                }
                   tmp = tmp->left;
            }

            else if(ptr->value > tmp->value){        //��� � ����� ���������
                if(tmp->right == nullptr){           //�� ��� ���, ���� ���� ���� ����
                   tmp->right = ptr;
                   cout << "DONE" << endl;
                   break;
                }
                tmp = tmp->right;

            }

            else{                                    //���� �������� ��� ���� � ������
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


  if(ptr->left != nullptr){                      //��� �� ����� ������ ���������

     Printtree(ptr->left, depth+1);

  }

  for(int i=0;i<depth;++i){
        cout << '.';
    }
    cout << ptr->value << endl;


   if(ptr->right != nullptr){                     //��� �� ����� ������ ���������

      Printtree(ptr->right, depth+1);

   }
};


int main(){

	string str;
	string operation_name;
	int number;

	while(getline(cin,str)){

        int pos = str.find(" ");

        if(pos == string::npos){                            // If ��� ���������� Printtree

            Printtree(Tree,0);
        }

        else{                                               // ��������� ������ � �����

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



