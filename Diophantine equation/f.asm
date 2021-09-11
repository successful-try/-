include console.inc
COMMENT *

  Вызов трех процедур из отдельного модуля. Долгов_задача_10_2
*
public Gen
public Print
public Diophant
public Mutacia

.data
	a_ equ 3
	m_ equ 199
	A dd 5, 5, 5, 5, 5
	D dd 100
	
.code 

 Gen proc
	 push ebp ; запомнили ebp
	 mov  ebp, esp
	 
	 push esi; запомнили esi
	 push edi; запомнили edi
	 
	 mov esi, [ebp+12] ; esi = Osobi, перешли к ebx ////// esi = Parent, перешли к ebx //////// esi = Bit, перешли к ebx/////// esi = Bit_M, перешли к ebx
	 mov edi, [ebp+8]; edi = N,  перешли к eax 
	 
	 push ebx
	 push eax
	 push ecx
	 
	 sub edi, 1 ; минус 1, потому что первый элемент задан
	 mov ecx, edi
	 
metka3:	 
	 mov eax, [esi];[[ebp+12]], пересылаем значение регистра esi, в котором адрес массива Osobi/Parent/Bit/Bit_M
	 mov ebx, a_
	 mul ebx
	 mov ebx, m_
	 div ebx
	 
	 add esi, 4
	 mov [esi], edx ; Переносим в следующее двойное слово
	 loop metka3
	
	 pop ecx
	 pop eax
	 pop ebx
	 pop edi
	 pop esi
	 pop ebp
	 
	ret
  Gen endp 
  
  Print proc
  
     push ebp ; запомнили ebp
	 mov  ebp, esp
	 
	 push esi; запомнили esi
	 push edi; запомнили edi
	 push ebx
	 push ecx
	 push edx
	 
	 mov ebx, [ebp+12] ; esi = Osobi/Children и тд перешли к ebx 
	 mov edi, [ebp+8]; edi = N или 2N, если Children перешли к eax 
  
    mov ecx, edi
	
L: 
	mov edx,ecx ; сохраняем ecx
	mov ecx,5 ; 5 - количество столбцов, заданных по условиям
	mov esi,0
	
L1: 
	outword [ebx][esi], ," " ; Печать особи
	add esi, 4
	loop L1
	
	newline
	
	mov ecx,edx ; возвращаем ecx
	add ebx, 20; 5 элементов (Xi) умноженных на 4 байта, т.к. Аi dd 
	sub ecx, 1
	cmp ecx, 0
	jne L
  
  pop edx
  pop ecx
  pop ebx
  pop edi
  pop esi
  pop ebp
  
  ret
  Print endp
  
 Diophant proc
  
  push ebp
  mov ebp, esp
  
  push esi
  push ecx
  push ebx
  
  mov esi, [ebp+8]; берем адрес начала массива All_
  mov ecx, 5 ; число столбцов
  mov ebx, 0
  mov edi, 0
  
 L8:
	mov eax, [esi];  кладем значение из ячейки с адресом из esi
	mul A[edi] ; умножаем на коэффициент из массива А
	add ebx, eax ; суммирование произвидения 
	add esi, 4 ; следующий элемент из esi
	add edi, 4 ; следующий элемент из массива А
    loop L8
	
	sub ebx, D ; ищем насколько особь близка к D
	cmp ebx, 0
	jge L9
	neg ebx
 L9: 
	mov eax, ebx ; Кладем результат элемента массива All_, взятый по модулю
  
    pop ebx
    pop ecx
    pop esi
    pop ebp
  
  ret
  Diophant endp
  
  
  	Mutacia proc
	
	push ebp
	mov ebp, esp
	
	push edx
	push ecx
	push ebx
	
	mov ecx, [ebp+8] ; Номер бита из eаx
	mov ebx, [ebp+12] ; Cам элемент из Osobi
	
	mov edx, 1
	shl edx, cl

	xor ebx, edx ; заменяем мутировавший бит на противоположное значение 
	mov eax, ebx

	pop ebx
	pop ecx
	pop edx
	pop ebp 
	
	ret
    Mutacia endp
  
   end
   
   