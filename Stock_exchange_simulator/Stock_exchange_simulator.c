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
///////Добавляем заявку в список Покупателей///////
    if(Buyer){
        if(*dest == NULL){                       // Добавляем первую заявку Покупателя
            *dest = ptr;
        }
        else{
            if((*dest)->Price < ptr->Price){     // Добавляем последующие заявки Покупателей
                ptr->next = *dest;               // и сортируем по убыванию и Id
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
    ///////Добавляем заявку в список Продавцов///////
    else{
        if(*dest == NULL){                       // Добавляем первую заявку Продавца
        *dest = ptr;
        }
        else{
            if((*dest)->Price > ptr->Price){     // Добавляем последующие заявки Продавцов
                ptr->next = *dest;               // и сортируем по возрастанию и Id
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

    if(*Buyer != NULL && ((*Buyer)->ID == id)){                   //Удаляем первую заявку в списке
        *Buyer = (*Buyer)->next;
        free(prev);
        printf("X,%d\n",id);
    }

    else{
        while(tmp != NULL && tmp->ID != id){  //Удаляем последующие заявки
            prev = tmp;                       //в списке
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

        int trade_volume = (*Buyer)->Qty > (*Seller)->Qty ? (*Seller)->Qty : (*Buyer)->Qty;   //Указываем наименьший объём для сделки
        float trade_price = (*Buyer)->ID > (*Seller)->ID ? (*Seller)->Price : (*Buyer)->Price;//Указывам цену для сделки

         if((*Buyer)->ID > (*Seller)->ID ){                                                   //Формируем сделку в зависимости от
             printf("T,%d,S,%d,%d,%d,%.2f\n", ++trade_id, (*Seller)->ID,                         //ID участников
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


        if((*Buyer)->Qty == 0){                                                               //Удаляем голову из списка Покупателей,
            struct Order  *tmp  = (*Buyer);                                                   //если кол-во кг сделки больше, чем в
            *Buyer = (*Buyer)->next;                                                          //определенной заявке Покупателя
            free(tmp);
        }

        if((*Seller)->Qty == 0){                                                             //Удаляем голову из списка Продавцов,
            struct Order  *tmp  = (*Seller);                                                 //если кол-во кг сделки больше, чем в
            *Seller = (*Seller)->next;                                                       //определенной заявке Продавца
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

/////////Заполняем структуру данными/////////
        if(ch == 'O'){
           getchar();                            //пропускаем 1-ю запятую

           struct Order* order = Make_order_structure();

           scanf("%d",&order->ID);
           getchar();                              //пропускаем 2-ю запятую
           tmp_for_Side = getchar();
           getchar();                              //пропускаем 3-ю запятую
           scanf("%d",&order->Qty);
           getchar();                              //пропускаем 4-ю запятую
           scanf("%f",&order->Price);
           order->next = NULL;

           if(tmp_for_Side == 'B'){                // Выбираем список Продавцов или Покупателей
                Buyer = true;
                Add_in_list(order, &Buy_list, Buyer);
           }
           else{
                Buyer = false;
                Add_in_list(order, &Sell_list, Buyer);
           }


/////////Проводим сделку////////////
           Trade(&Buy_list, &Sell_list);


        }
/////////////Удаляем заявку////////////
        else if(ch == 'C'){
            getchar();                              //пропускаем 1-ю запятую
            scanf("%d",&Id_to_cancel);
            Cancel_order(Id_to_cancel, &Buy_list);  //Ищем заявку для удаления
            Cancel_order(Id_to_cancel, &Sell_list); //в обоих списках

        }

 }

    return 0;
}
