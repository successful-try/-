include console.inc

COMMENT *

 Генератор случайных чисел.
*

.data 
 
	a_ equ 48271
	m_ equ 2147483647
	N equ 15
	M dw ?
	X dd N DUP (0)

   ;  X(i) = a * X(i-1) mod m 
.code

  Gen proc
	
	
	 push ebp ; запомнили ebp
	 mov  ebp, esp
	 
	 push esi; запомнили esi
	 push edi; запомнили edi
	 
	 mov esi, [ebp+12] ; esi = X, перешли к ebx 
	 mov edi, [ebp+8]; edi = M,  перешли к eax 
	 
	 sub edi, 1
	 mov ecx, edi
	 
metka3:	 
	 mov eax, [esi];[[ebp+12]]
	 mov ebx, a_
	 mul ebx
	 ;outwordln edx
	 ;outwordln eax
	 mov ebx, m_
	 div ebx
	 
	 add esi, 4
	 mov [esi], edx
	 ;outwordln edx, , "Mod = "
	 loop metka3
	
	 pop edi
	 pop esi
	 pop ebp
	 
	ret
  Gen endp

Start:
	
	 inint M, "Vvedite M="
	 
	 movzx eax, M
	 cmp eax, N
	 ja metka1
	 
	 lea ebx, X ; [X] = X
	 
	 mov esi, 0
	 inint X[esi], "Vvedite pervii element massiva X="
	
	 push ebx	  
	 push eax
	
	call Gen
	
     pop eax
	 pop ebx
   
    mov esi, 0
	movzx ecx, M
	
metka2:
	outword X [esi], ," "
	add esi, 4
	loop metka2
	
   jmp finish 
   
metka1: outstr "Vvedeno nepravilnoe znachenie"	
	 newline 
	 
finish:
   exit
   end Start
   

   
   
   
   
   
   
   
   