#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

struct Order{
     int ID;
     int Qty;
     float Price;
     struct Order *next;
};

struct Order *Make_order_structure(void){
    struct Order *new_node;

    new_node = (struct Order*)malloc(sizeof(struct Order));
    if(new_node == NULL){
        puts("Error function malloc");
        exit (1);
    }

    return new_node;
};


void Add_in_list(struct Order *ptr, struct Order** dest, bool Buyer){
///////��������� ������ � ������ �����������///////
    if(Buyer){
        if(*dest == NULL){                       // ��������� ������ ������ ����������
            *dest = ptr;
        }
        else{
            if((*dest)->Price < ptr->Price){     // ��������� ����������� ������ �����������
                ptr->next = *dest;               // � ��������� �� �������� � Id
                *dest = ptr;
            }
            else{
                struct Order  *tmp  = (*dest)->next;
                struct Order *prev = *dest;
                while(tmp != NULL && ptr->Price  <= tmp->Price){
                        prev = tmp;
                        tmp  = tmp->next;
                }
                prev->next = ptr;
                ptr->next  = tmp;
            }
        }
    }
    ///////��������� ������ � ������ ���������///////
    else{
        if(*dest == NULL){                       // ��������� ������ ������ ��������
        *dest = ptr;
        }
        else{
            if((*dest)->Price > ptr->Price){     // ��������� ����������� ������ ���������
                ptr->next = *dest;               // � ��������� �� ����������� � Id
                *dest = ptr;
            }
             else{
                struct Order *tmp  = (*dest)->next;
                struct Order *prev = *dest;
                while(tmp != NULL && ptr->Price  >= tmp->Price){
                        prev = tmp;
                        tmp  = tmp->next;
                }
                prev->next = ptr;
                ptr->next  = tmp;
            }
        }
    }
}

void Cancel_order(int id, struct Order** Buyer){

    struct Order  *tmp  = *Buyer;
    struct Order *prev  = *Buyer;

    if(*Buyer != NULL && ((*Buyer)->ID == id)){                   //������� ������ ������ � ������
        *Buyer = (*Buyer)->next;
        free(prev);
        printf("X,%d\n",id);
    }

    else{
        while(tmp != NULL && tmp->ID != id){  //������� ����������� ������
            prev = tmp;                       //� ������
            tmp  = tmp->next;
        }
        if(tmp != NULL){
            prev->next = tmp->next;
            free(tmp);
            printf("X,%d\n",id);
        }
      }
}

void Trade(struct Order** Buyer, struct Order** Seller){

     static int trade_id = 0;

     while((*Buyer) != NULL  &&  (*Seller) != NULL  &&  (*Buyer)->Price >= (*Seller)->Price){

        int trade_volume = (*Buyer)->Qty > (*Seller)->Qty ? (*Seller)->Qty : (*Buyer)->Qty;   //��������� ���������� ����� ��� ������
        float trade_price = (*Buyer)->ID > (*Seller)->ID ? (*Seller)->Price : (*Buyer)->Price;//�������� ���� ��� ������

         if((*Buyer)->ID > (*Seller)->ID ){                                                   //��������� ������ � ����������� ��
             printf("T,%d,S,%d,%d,%d,%.2f\n", ++trade_id, (*Seller)->ID,                         //ID ����������
                                          (*Buyer)->ID, trade_volume,
                                           trade_price);
        }

        else{
             printf("T,%d,B,%d,%d,%d,%.2f\n", ++trade_id, (*Buyer)->ID,
                                          (*Seller)->ID, trade_volume,
                                          trade_price);
        }


        (*Buyer)->Qty  -= trade_volume;
        (*Seller)->Qty -= trade_volume;


        if((*Buyer)->Qty == 0){                                                               //������� ������ �� ������ �����������,
            struct Order  *tmp  = (*Buyer);                                                   //���� ���-�� �� ������ ������, ��� �
            *Buyer = (*Buyer)->next;                                                          //������������ ������ ����������
            free(tmp);
        }

        if((*Seller)->Qty == 0){                                                             //������� ������ �� ������ ���������,
            struct Order  *tmp  = (*Seller);                                                 //���� ���-�� �� ������ ������, ��� �
            *Seller = (*Seller)->next;                                                       //������������ ������ ��������
            free(tmp);
        }
     }
}

int main(){

    struct Order *Buy_list  = NULL;
    struct Order *Sell_list = NULL;

    char ch;
    char tmp_for_Side;
    bool Buyer;
    int Id_to_cancel;

    while((ch = getchar()) != EOF){

/////////��������� ��������� �������/////////
        if(ch == 'O'){
           getchar();                            //���������� 1-� �������

           struct Order* order = Make_order_structure();

           scanf("%d",&order->ID);
           getchar();                              //���������� 2-� �������
           tmp_for_Side = getchar();
           getchar();                              //���������� 3-� �������
           scanf("%d",&order->Qty);
           getchar();                              //���������� 4-� �������
           scanf("%f",&order->Price);
           order->next = NULL;

           if(tmp_for_Side == 'B'){                // �������� ������ ��������� ��� �����������
                Buyer = true;
                Add_in_list(order, &Buy_list, Buyer);
           }
           else{
                Buyer = false;
                Add_in_list(order, &Sell_list, Buyer);
           }


/////////�������� ������////////////
           Trade(&Buy_list, &Sell_list);


        }
/////////////������� ������////////////
        else if(ch == 'C'){
            getchar();                              //���������� 1-� �������
            scanf("%d",&Id_to_cancel);
            Cancel_order(Id_to_cancel, &Buy_list);  //���� ������ ��� ��������
            Cancel_order(Id_to_cancel, &Sell_list); //� ����� �������

        }

 }

    return 0;
}
