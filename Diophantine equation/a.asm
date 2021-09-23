include console.inc

COMMENT *

 
*
extrn Gen@0: near
extrn Print@0: near
extrn  Diophant@0: near
extrn Mutacia@0: near

.data; 
	N dd ? ; количество Osobi
	M dd ? ; количество итераций
	Mode_r dd ? ; выбор режима
	X_20 dd 20
	Index_child dd ?
	tmp1 dd ?
	tmp2 dd ?
	Osobi dd 25 dup (1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4,5,5,5,5,5)
	;Osobi dd 5 dup (5 dup(0)) 1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4,5,5,5,5,5
	Children dd 20 dup (5 dup(0)); Массив для детей в количестве 2N
	Parent_1 dd 10 dup (0); Parent - индекс особей для скрещивания из первой корзины
	Parent_2 dd 10 dup (0); Parent - индекс особей для скрещивания из второй корзины
	Bit dd 10 dup(0) ; массив для одноточечного скрещивания
	Bit_M dd 10 dup(0) ;  массив для мутации
	
	All_ dd 30 dup (5 dup(0)); массив, включающий 3N особей (родители + дети)
	Answers dd 30 dup(?)
	
	Probability_M dd 10 (0) ; вероятность мутации

.code
Start:
;;;;;;Задание числа особей N;;;;;;;;;;;;;;;;;;;;;;;;;	
		outstrln "Vvedite chislo"
		inintln N, "N = "
		
		cmp N, 4
		jb finish2
		cmp N, 10
		ja finish2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
;;;;;;Задание числа итераций М;;;;;;;;;;;;;;;;;;;;;;;	

outstrln "Vvedite chislo iteracii"
		inintln M, "M = "
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;Задание режима;;;;;;;;;;;;;;;;;;;;;;;	

outstrln "Vvedite chislo dlia vibora rejima raboti (0-testovii, luboe drugoe - obicnii)"
		inintln Mode_r, "Mode_r = "
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;Генерация массива Osobi;;;;;;;;;;;;;;;;;;;;;;;;;			
COMMENT ^	
	mov esi, 0
	inint Osobi[esi], "Vvedite pervii element massiva Osobi = "
	
	lea ebx, Osobi
	mov eax, 5; 5 столбцов (количество Х)
	mul N ; передача 5*N элементов
	
	push ebx
	push eax
	
	outstrln "Osobi:"
	
	Call Gen@0
	
	pop eax
	pop ebx
^	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
	cmp Mode_r , 0
	jne Out1
;;;;;;Вывод массива Osobi;;;;;;;;;;;;;;;;;;;;;;;;;	

	lea ebx, Osobi
	mov eax, N ; передача количества N строк
	
	push ebx
	push eax
	
	Call Print@0
	
	pop eax
	pop ebx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
Out1:
	
BEGIN:
;;;;;;;;;;Генерация 1-го массива родителей по индексам;;;;;;;;;;;;;;;;;;
	mov eax, 4 ; потому что DD
	mul N
	sub eax, 4
	mov ebx, eax; индекс последней строки
	
	mov esi, 4  ; индекс последнего столбца
	
	mov edx, Osobi[ebx][esi] ; последний заполненный элемент среди Osobi
	mov Parent_1[0], edx ; кидаем последний  элемент среди Osobi
	lea ebx, Parent_1
	mov eax, N
	
	push ebx
	push eax 
	
	Call Gen@0
	
	pop eax
	pop ebx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;Генерация 2-го массива родителей по индексам;;;;;;;;;;;;;;;;;;;
	mov eax, 4
	mul N
	sub eax, 4
	mov ebx, eax; индекс последнего элемента Parent_2
	
	mov edx,  Parent_1[ebx] ; последний элемент Parent_1
	mov Parent_2[0], edx
	lea ebx, Parent_2
	mov eax, N
	
	push ebx
	push eax 
	
	Call Gen@0
	
	pop eax
	pop ebx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;Вывод на печать индексы родителей для скрещивания ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;в формате двух массивов по модулю N;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	newline
cmp Mode_r , 0
jne Out2

	outstr "Parent 1: "
Out2:
	mov edx, 0
	mov esi, 0
	mov ecx, N
L2:
	mov eax, Parent_1 [esi]
	div N ; чтобы получить индекс от 0 до N-1
	mov Parent_1 [esi], edx	
	
cmp Mode_r, 0
jne Out3

	outword Parent_1 [esi], , " "
Out3:

	add esi, 4
	loop L2
	
cmp Mode_r, 0
jne Out4

newline

	outstr "Parent 2: "
Out4:
	
	mov edx, 0
	mov esi, 0
	mov ecx, N
L3:
	mov eax, Parent_2 [esi]
	div N ; чтобы получить индекс от 0 до N-1
	mov Parent_2 [esi], edx
	
cmp Mode_r, 0
jne Out44

	outword Parent_2 [esi], , " " 
	
Out44:	
	add esi, 4
	loop L3

newline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;Генерация массива битов для одноточечного скрещивания;;;;;;;;;;;;;;;;;;;
	mov eax, 4
	mul N
	sub eax, 4
	mov ebx, eax; индекс последнего элемента Parent_2
	
	mov edx,  Parent_2[ebx] ; последний элемент Parent_2
	mov Bit[0], edx
	lea ebx, Bit
	mov eax, N ; количество элементов массива Bit
	
	push ebx ; адрес массива Bit
	push eax ; 
	
	Call Gen@0
	
	pop eax
	pop ebx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;Генерация массива битов для МУТАЦИИ;;;;;;;;;;;;;;;;;;;
	mov eax, 4
	mul N
	sub eax, 4
	mov ebx, eax; индекс последнего элемента Bit
	
	mov edx, Bit [ebx] ; последний элемент Bit
	mov Bit_M[0], edx
	lea ebx, Bit_M
	mov eax, N ; количество элементов массива Bit_M
	
	push ebx ; адрес массива Bit_M
	push eax ; 
	
	Call Gen@0
	
	pop eax
	pop ebx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;Генерация вероятности для Мутации;;;;;;;;;;;;;;;;;;;;;;;;
	
	mov eax, 4
	mul N
	sub eax, 4
	mov ebx, eax; индекс последнего элемента Bit_M
	
	mov edx, Bit_M [ebx] ; последний элемент Bit_M
	mov Probability_M[0], edx
	lea ebx, Probability_M
	mov eax, N ; количество элементов массива Probability_M
	
	push ebx ; адрес массива Probability_M
	push eax ; 
	
	Call Gen@0
	
	pop eax
	pop ebx
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;Преобразование и вывод массива Bit по модулю 160;;;;;;;;;;;;;;;;;;;;;;;;
cmp Mode_r, 0
jne Out5
	
	outstr "Bit: "
Out5:
	
	mov edx, 0
	mov esi, 0
	mov ecx, N
L4:
	mov eax, Bit [esi]
	mov ebx, 160
	div ebx ; деление на 160, чтобы получить значение от 0 до 159. 160 - это количество битов в строке 5*dd
	mov Bit[esi], edx
	
cmp Mode_r, 0
jne Out6
	outword Bit[esi], , " " 
Out6:
	add esi, 4
	loop L4
newline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;Преобразование и вывод массива Bit_M по модулю 160;;;;;;;;;;;;;;;;;;;;;;;;
cmp Mode_r, 0
jne Out7	
	outstr "Bit_M: "
Out7:
	mov edx, 0
	mov esi, 0
	mov ecx, N
L44:
	mov eax, Bit_M [esi]
	mov ebx, 160
	div ebx; деление на 160, чтобы получить значение от 0 до 159. 160 - это количество битов в строке 5*dd
	mov Bit_M[esi], edx
	
cmp Mode_r, 0
jne Out8
	outword Bit_M[esi], , " " 
Out8:
	add esi, 4
	loop L44
newline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;Преобразование и вывод массива Probability_M по модулю 2;;;;;;;;;;;;;;;;;;;;;;;;

cmp Mode_r, 0
jne Out9

	outstr "Probability_M: "
Out9:

	mov edx, 0
	mov esi, 0
	mov ecx, N
L444:
	mov eax, Probability_M [esi]
	mov ebx, 2
	div ebx ; делим на 2, чтобы получить 50% вероятность мутации. Можем менять вероятность, как хотим.
	mov Probability_M [esi], edx
	
cmp Mode_r, 0
jne Out10

	outword Probability_M [esi], , " " 
Out10:

	add esi, 4
	loop L444

newline

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;Скрещивание;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 	
;;;;;;;;;;;;;;;;;;;;;;;;;Скрещивание;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;Скрещивание;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 	
	mov Index_child, 0

	mov ecx, N
	mov ebx, 0
	
L5:
	mov eax, Parent_1[ebx] 
	mul X_20 ; умножаем на 20 поскольку особи (строки) стоя друг от друга на 20 байт
	mov edi, eax ;i_1-я строка Osobi
	mov eax, Parent_2 [ebx]
	mul X_20 
	mov edx, eax ;i_2-я строка Osobi
	
	mov eax, Bit[ebx] ;Запоминаем номер бита для скрещивания
	push ebx ; Запоминаем индексы рассматриваемой пары родителей 
	
	mov ebx, edi ;i_1-я строка Osobi
	mov ebp, edx ;i_2-я строка Osobi
	
	mov esi, 16 ; j_1-й столбец i_1-й строки Osobi или i_2-й строки Osobi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;Выделение целых элементов двойных слов с конца;;;;;;;;;;;;; 
L6: cmp eax, 32
	jl Change_byte ; Если < 32, то прыгаем к одноточечному скрещиванию
	mov edx, Osobi[ebx][esi] ; Запоминаем элемент из Parent_1
	push ebx ; Запоминаем номер строки Parent_1
	mov ebx, Index_child
	mov Children[ebx][esi], edx ; С конца 1-го ребенка записываем часть Parent_1 в виде двойного слова
	mov edx, Osobi[ebp][esi] ; Запоминаем элемент из Parent_2
	push ebp  ; Запоминаем номер строки Parent_2
	mov ebp, Index_child
	add ebp, 20 ; Переходим ко 2-му ребенку, т.е. перепрыгиваем через одну строку
	mov Children[ebp][esi], edx ; С конца 2-го ребенка записываем часть Parent_2 в виде двойного слова
	sub eax, 32 ; уменьшаем сгенерированный номер бита на 32
	sub esi, 4 ; переходим справа налево к следующему столбцу i-й строки в Parent_1 и Parent_2
	pop ebp
	pop ebx
	jmp L6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;Одноточечное скрещивание;;;;;;;;;;;;; 	
Change_byte:

	push ecx; запомнили ecx для циклов
	mov cl, al ; al = оставшемуся биту после цикла выделения полных двойных слов 
	mov edx, 1 
	shl edx, cl
	sub edx, 1 ; маска1 с единицами в конце путем перехода в нижние разряды с помощью вычитания одного бита
	mov edi, edx
	not edi    ; маска2 с единицами в начале
	
	;Маска1 отвечает за правую половину родителя: 000..001111 (=15)
	;Маска2 отвечает за левую половину родителя:  11...110000
	
	push eax ; Запоминаем оставшийся бит
	   
	mov  eax, Osobi[ebx][esi] ; Запоминаем элемент Parent_1 для о/с 
	mov  ecx, Osobi[ebp][esi] ; Запоминаем элемент Parent_2 для о/с 
	
	mov tmp1, eax ; Временно запоминаем элемент Parent_1 для о/с 
	and tmp1, edx ; Получаем правую часть элемента Parent_1
	mov tmp2, ecx ; Временно запоминаем элемент Parent_2 для о/с 
	and tmp2, edi ; Получаем левую часть элемента Parent_2
	mov eax, tmp1 ; Кладем правую часть элемента Parent_1
	or eax, tmp2   ; Скрещиваем правую часть элемента Parent_1 и левую часть элемента Parent_2
	
	push ebx ; Запоминаем строку Parent_1 
	mov ebx, Index_child
	mov Children[ebx][esi], eax ; Кладем скрещенный элемент в 1-го Children
	
	pop ebx
	
	mov  eax, Osobi[ebx][esi] ; Запоминаем элемент Parent_1 для о/с 
	mov  ecx, Osobi[ebp][esi]  ; Запоминаем элемент Parent_2 для о/с 
	
	mov tmp1, eax ; Временно запоминаем элемент Parent_1 для о/с 
	and tmp1, edi ; Получаем левую часть элемента Parent_1
	mov tmp2, ecx ; Временно запоминаем элемент Parent_2 для о/с 
	and tmp2, edx ; Получаем правую часть элемента Parent_2
	mov eax, tmp1 ; Кладем левую часть элемента Parent_1
	or eax, tmp2 ; Скрещиваем левую часть элемента Parent_1 и правую часть элемента Parent_2
	
	push ebx ; Запоминаем строку Parent_1 
	mov ebx, Index_child
	add ebx, 20
	mov Children[ebx][esi], eax  ; Кладем скрещенный элемент во 2-го Children
	pop ebx
	
	sub esi, 4 ; переходим к следующещму столбцу
	
	pop eax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;Выделение целых элементов двойных слов с конца после о/с, если имеет место быть;;;;;;;;;;;;; 	
L7: cmp esi, 0
	jl FIN
	
	mov edx, Osobi[ebx][esi] ; Запоминаем следующий после о/с элемент Parent_1
	push ebx ; Запоминаем номер строки Parent_1
	mov ebx, Index_child
	add ebx, 20 ; Переходим ко 2-му ребенку, т.е. перепрыгиваем через одну строку
	mov Children[ebx][esi], edx  ; Записываем во 2-го ребенка записываем следующее после о/с двойное слово Parent_1 
	mov edx, Osobi[ebp][esi] ; Запоминаем следующий после о/с элемент Parent_2
	push ebp ; Запоминаем номер строки Parent_2
	mov ebp, Index_child ; первый ребенок
	
	mov Children[ebp][esi], edx ; Записываем во 1-го ребенка записываем следующее после о/с двойное слово Parent_2
	sub esi, 4 ; Переходим к след. столбцу
	pop ebp
	pop ebx
	jmp L7	
	
FIN:	
	pop ecx
	add Index_child, 40 ; пропускаем 2-х Children, чтобы перейти к детям следующей пары
	pop ebx ; Выводим из стека индекс пары родителей
	add ebx, 4 ; переходим к следующей паре  Parent'ов
	sub ecx, 1
	cmp ecx, 0
	jle FF
	jmp L5 ; Повторяем процесс скрещивания для следующей пары родителей
	
FF:

newline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;Печать массива Children;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp Mode_r, 0
jne Out11

outstrln "Children:"

	lea ebx, Children
	mov eax, N ; передача количества N строк
	add eax, N ; 2 N детей
	
	push ebx ; Запоминаем адрес массива Children
	push eax  ; Запоминаем количество строк
	
	Call Print@0
	
	pop eax
	pop ebx
	
	newline
	newline
	
Out11:	
;;;;;;;;;;;;;;;;;;;Создание большого массива All_ с целью объединения массивов;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; объединения массивов Osobi и Children;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov eax, 5 ; 5 столбцов
	mul N
	mov ecx, eax
	mov ebx, 0
L10:
	mov eax, Osobi[ebx]
	mov All_[ebx], eax
	add ebx, 4
	loop L10
	
	mov eax, 10 ; Потому что Children = 2N
	mul N
	mov ecx, eax
	mov ebp, 0
L11:
	mov eax, Children[ebp]
	mov All_[ebx], eax
	add ebp, 4
	add ebx, 4
	loop L11
	
cmp Mode_r, 0
jne Out12	

	lea ebx, All_
	mov eax, 3
	mul N 
	
	push ebx ; Запоминаем адрес массива All_
	push eax  ; Запоминаем количество строк	
	outstrln "Crossing_(All_: Osobi + Children): "
	call Print@0
	
	pop eax
	pop ebx
	newline
Out12:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;;;;Расчёт уравнения по всем особям, включая детей;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	mov eax, 3 ; Потому что 3N особей
	mul N 
	mov ecx, eax
	mov ebp,0
	mov esi, 0
L12:
	lea ebx, All_[ebp]
	push ebx
    
	Call Diophant@0
	
	mov Answers [esi], eax
	add ebp, 20
	add esi, 4
	loop L12
	
	pop ebx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;;;;;;;;;Печать результатов расчёта уравнения;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp Mode_r, 0
jne Out13

	mov ebx, 0
	push ecx
	mov eax, 3
	mul N
	mov ecx, eax
	outstrln "Answer: "
L20:
 
	outword Answers[ebx], , " "
	add ebx, 4
	loop L20
	
newline
Out13:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;Зануление массива Osobi;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	mov eax, 5
	mul N
	mov ecx, eax
	mov ebx, 0 
L13:
	mov Osobi[ebx], 0
	add ebx, 4
	Loop L13
	
newline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	 mov esi, 0 ;индекс строки из Osobi , который будем заполнять
	 mov ecx, N ; Количество минимальных особей после расчёта уравнения

;;;;;;;;;;;;;;;;;;;;;;;;;;Селекция;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
N_min_str:
	 ;;;;;;;;;;;;;;;;;;;;;Find Minimun & index of min elem;;;;;;;;;;;;;;
	 mov ebx, 0
	 
	 mov eax, 3 ; 3N особей
	 mul N
	 sub eax, 1
	 
	 push ecx  ; сохраняем ecx для внешнего цикла заполнения массива Osobi 
	 mov ecx, eax
	 mov ebp, 0
	
	 mov eax, Answers [ebx] ; eax хранит число минимума
	 add ebx, 4
L14:
	 cmp eax, Answers [ebx] ; сравниваем текущий минимум со следующим элементом
	 jbe L15
	 mov eax, Answers [ebx] ; присваиваем eax новый числовой минимум
	 mov ebp, ebx ; сохраняем индексовый номер минимума
	 
L15:
	 add  ebx, 4
	 loop L14

	newline

	;ebp - байтовый индекс элемента в Answers
	;ebp/4, номер строки в All_
	;ebp/4 * 20 = ebp * 5 - номер байта в All_
	
	cmp Answers [ebp], 0 ; Ответ найден
	je finish3
	
	mov Answers [ebp], -1 ; Answers[index_min] := Max_integer
	                      ; Максимизируем найденный минимум, чтобы
	                      ; ислкючить его из дальнейших циклов
						  
	;;;;;;;;;;;;;;;;;;;;;;;;Osobi[k] := All_[index_min];;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;Записываем найденный индекс минимального;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;элемента в массив Osobi;;;;;;;;;;;;;;;;;;;;;
	mov eax, 5
	mul ebp
	
	mov ebp, eax ; номер строки минимального элемента в All_
	mov edi, 0
	mov ecx, 5 ; количество столбцов
L16: 	
	mov eax, All_ [ebp][edi] ; записываем 1-е значение минимальной строчки
	mov All_ [ebp][edi], 0 ; обнуление строки массива All_
	mov Osobi [esi], eax ; записываем 1-е значение минимальной строчки в массив Osobi
	add esi, 4
	add edi, 4
	loop L16
	
	pop ecx ; Возвращаем  ecx для внешнего цикла заполнения массива Osobi 
	sub ecx,1 ; 
	cmp ecx, 0
	jle AA
	jmp N_min_str

AA:

cmp Mode_r, 0
jne Out14
	
	lea ebx, Osobi
	mov eax, N ; передача количества N строк
	
	push ebx
	push eax
	
	outstrln "After Selection: "
	Call Print@0
	
	pop eax
	pop ebx
	
	newline
Out14:	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;Поиск нужного двойного слова для мутации бита;;;;;;;;;;;;;;;;; 		

	mov ebx, 0
	mov edi, 0
	mov ecx, N
L18:
	;cmp Probability_M[edi], 1 ; Анализируем будет ли мутация или нет. 1 - значит будет
	;jne L19
	
	mov eax, Bit_M [edi] ; первый элемент Bit_M 
	
	push ecx ; запомнили ecx
	mov esi, 16 ; 4-й столбец строки. Идёт осчёт с конца строки.
	mov ecx, 5 ; число столбцов
L17:
	cmp eax, 32
	jl Mut 
	sub eax, 32
	
	;mov eax, Osobi [ebx][esi]
	sub esi, 4 ; следующий столбец
	jmp L17
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;;;;;;;Мутация;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 	

Mut:

	;eax - номер бита, который надо изменить в каком-то из 5-ти элементов
	mov edx, 0
	mov ebp, 8 ; чтобы оставаться в пределах байта (мутировать младшие 8 бит у какого-то столбца из строки)
	div ebp
	
	mov ebp, Osobi[ebx][esi]
	
	push ebp
	push edx
	
	call Mutacia@0
	
	pop edx
	pop ebp
	
	;outwordln  eax, , "eax="
	
	mov Osobi[ebx][esi], eax
	
	pop ecx 
	
L19:
	add ebx, 20 ; следующая строка
	add edi, 4
	sub ecx, 1
	cmp ecx, 0
	jle KK  
	jmp L18
	
KK:

	
	lea ebx, Osobi
	mov eax, N ; передача количества N строк
	
	push ebx
	push eax
	
cmp Mode_r, 0
jne Out15	

	outstrln "After Mutation: "
	Call Print@0
	
Out15:

	pop eax
	pop ebx
	
	newline
	
	sub M, 1
	cmp M, 0
    ja BEGIN
	outstr "Otvet ne naiden!"
	jmp finish1
	
finish3:
	
	mov eax, ebp
    mov ebp, 5 ; приводим в соответствие индексы массивов Answers и All_
	mul ebp
	mov ebp, eax
	
	mov eax, 1 ; будем выводить одну строку
	
	lea ebx, All_[ebp]
	
	push ebx
	push eax
	
	outstr  "Pravilnii otvet = "
	
	call Print@0
	
	pop eax
	pop ebx
	jmp finish1

finish2: 
	outstr "Vvedeno nepravel'noe N"
finish1:
	exit
   end Start
   
  
   ; N=5, elem = 2, M=1            a = 1,1,1,1,1    d = 317
    ; N=5, elem = 5, M=2            a = 1,1,1,1,1    d = 317
   ; N=5, elem = 5, M=5            a = 1,1,1,1,1    d = 300
  
  
  ;;;;;;;;;;;;;;Селекция;;;;;;;;;;;
	;N children
	
	;N pairs
	
	;2 вспомогательных массива для родителей
	;Заполняем рандомными числами
	;Их делим по модулю N, чтобы не выйти за границу количества родителей
	;Попарно скрещиваем родителей 
	
	;1 4 2 7 1 4
	;3 5 1 10 2 3
   
   
   ;COMMENT ^
	;х = 100 бит
	;скрещиваем 1 и 3 особь
	;1: 3 9 27 81 44
	;3: 132 197 193 181 145
	
	;Нужна матрица с детьми
	;Всего 160 бит
	;100-32>=0
	;последний байт кладем в ребенка, #4
	;100-32=68
	;68-32>=0
	;предпоследний идет в ребенка, #3
	;68-32=36
	;36-32>=0
	;предпредпоследний, #2
	;36-32=4
	
	;0<4< 32, stop, байт #1
	;Т.е. обмениваем половинки 9 и 197
	;Маска1 отвечает за правую половину 1 родителя: 000..001111 (=15)
	;Маска2 отвечает за левую половину 2 родителя:  11...110000
	
	;Получить единицы на последних местах
	;(1 << 4) - 1: 
	;00000001
	;00010000 (=16)
	;00001111
	
	;Получить последние 4 бита у 9:
	;a = 9 and 00001111
	;Получить первые 28 бит у 9:
	;b = 9 and (not 00001111)
	
	;Получить последние 4 бита у 197:
	;c = 197 and 00001111
	;Получить первые 28 бит у 197:
	;d = 197 and (not 00001111)
	
	;Собрать из двух половин новые числа: d_a, b_c
	;d_a: d or a
	;b_c: b or c
	
	;Положим в массив
	
	;Получить оставшиеся элементы:
	;32 - 4 = 28
	;160-100 = 60
	;60 - 28 = 32
	
	;Некий цикл, записывать оставшиеся байты родителей в детей
	;Всего 32 бита
	;32-32>=0
	;Кладем этот элемент в ребенка
	;32-32=0
	;0-32 >=0?, stop
	;^  
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	;;;;;Сохранить все значимые особи (без 0-х) в массив All_ 
	;;;;;Считаем Diophant для каждой особи и кладем результат в Answers
	; Обнулить Osobi
	; Найти N минимальных особей по коэффициенту из Answers 
	; и положить их в Osobi, так получим новое поколение
;;;;;;;;;;;;;;;;;Перенос элементов Osobi и Children в отдельный массив All_;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
