include console.inc

COMMENT *

 
*
extrn Gen@0: near
extrn Print@0: near
extrn  Diophant@0: near
extrn Mutacia@0: near

.data; 
	N dd ? ; ���������� Osobi
	M dd ? ; ���������� ��������
	Mode_r dd ? ; ����� ������
	X_20 dd 20
	Index_child dd ?
	tmp1 dd ?
	tmp2 dd ?
	Osobi dd 25 dup (1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4,5,5,5,5,5)
	;Osobi dd 5 dup (5 dup(0)) 1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4,5,5,5,5,5
	Children dd 20 dup (5 dup(0)); ������ ��� ����� � ���������� 2N
	Parent_1 dd 10 dup (0); Parent - ������ ������ ��� ����������� �� ������ �������
	Parent_2 dd 10 dup (0); Parent - ������ ������ ��� ����������� �� ������ �������
	Bit dd 10 dup(0) ; ������ ��� ������������� �����������
	Bit_M dd 10 dup(0) ;  ������ ��� �������
	
	All_ dd 30 dup (5 dup(0)); ������, ���������� 3N ������ (�������� + ����)
	Answers dd 30 dup(?)
	
	Probability_M dd 10 (0) ; ����������� �������

.code
Start:
;;;;;;������� ����� ������ N;;;;;;;;;;;;;;;;;;;;;;;;;	
		outstrln "Vvedite chislo"
		inintln N, "N = "
		
		cmp N, 4
		jb finish2
		cmp N, 10
		ja finish2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
;;;;;;������� ����� �������� �;;;;;;;;;;;;;;;;;;;;;;;	

outstrln "Vvedite chislo iteracii"
		inintln M, "M = "
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;������� ������;;;;;;;;;;;;;;;;;;;;;;;	

outstrln "Vvedite chislo dlia vibora rejima raboti (0-testovii, luboe drugoe - obicnii)"
		inintln Mode_r, "Mode_r = "
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;��������� ������� Osobi;;;;;;;;;;;;;;;;;;;;;;;;;			
COMMENT ^	
	mov esi, 0
	inint Osobi[esi], "Vvedite pervii element massiva Osobi = "
	
	lea ebx, Osobi
	mov eax, 5; 5 �������� (���������� �)
	mul N ; �������� 5*N ���������
	
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
;;;;;;����� ������� Osobi;;;;;;;;;;;;;;;;;;;;;;;;;	

	lea ebx, Osobi
	mov eax, N ; �������� ���������� N �����
	
	push ebx
	push eax
	
	Call Print@0
	
	pop eax
	pop ebx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
Out1:
	
BEGIN:
;;;;;;;;;;��������� 1-�� ������� ��������� �� ��������;;;;;;;;;;;;;;;;;;
	mov eax, 4 ; ������ ��� DD
	mul N
	sub eax, 4
	mov ebx, eax; ������ ��������� ������
	
	mov esi, 4  ; ������ ���������� �������
	
	mov edx, Osobi[ebx][esi] ; ��������� ����������� ������� ����� Osobi
	mov Parent_1[0], edx ; ������ ���������  ������� ����� Osobi
	lea ebx, Parent_1
	mov eax, N
	
	push ebx
	push eax 
	
	Call Gen@0
	
	pop eax
	pop ebx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;��������� 2-�� ������� ��������� �� ��������;;;;;;;;;;;;;;;;;;;
	mov eax, 4
	mul N
	sub eax, 4
	mov ebx, eax; ������ ���������� �������� Parent_2
	
	mov edx,  Parent_1[ebx] ; ��������� ������� Parent_1
	mov Parent_2[0], edx
	lea ebx, Parent_2
	mov eax, N
	
	push ebx
	push eax 
	
	Call Gen@0
	
	pop eax
	pop ebx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;����� �� ������ ������� ��������� ��� ����������� ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;� ������� ���� �������� �� ������ N;;;;;;;;;;;;;;;;;;;;;;;;;;
	
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
	div N ; ����� �������� ������ �� 0 �� N-1
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
	div N ; ����� �������� ������ �� 0 �� N-1
	mov Parent_2 [esi], edx
	
cmp Mode_r, 0
jne Out44

	outword Parent_2 [esi], , " " 
	
Out44:	
	add esi, 4
	loop L3

newline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;��������� ������� ����� ��� ������������� �����������;;;;;;;;;;;;;;;;;;;
	mov eax, 4
	mul N
	sub eax, 4
	mov ebx, eax; ������ ���������� �������� Parent_2
	
	mov edx,  Parent_2[ebx] ; ��������� ������� Parent_2
	mov Bit[0], edx
	lea ebx, Bit
	mov eax, N ; ���������� ��������� ������� Bit
	
	push ebx ; ����� ������� Bit
	push eax ; 
	
	Call Gen@0
	
	pop eax
	pop ebx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;��������� ������� ����� ��� �������;;;;;;;;;;;;;;;;;;;
	mov eax, 4
	mul N
	sub eax, 4
	mov ebx, eax; ������ ���������� �������� Bit
	
	mov edx, Bit [ebx] ; ��������� ������� Bit
	mov Bit_M[0], edx
	lea ebx, Bit_M
	mov eax, N ; ���������� ��������� ������� Bit_M
	
	push ebx ; ����� ������� Bit_M
	push eax ; 
	
	Call Gen@0
	
	pop eax
	pop ebx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;��������� ����������� ��� �������;;;;;;;;;;;;;;;;;;;;;;;;
	
	mov eax, 4
	mul N
	sub eax, 4
	mov ebx, eax; ������ ���������� �������� Bit_M
	
	mov edx, Bit_M [ebx] ; ��������� ������� Bit_M
	mov Probability_M[0], edx
	lea ebx, Probability_M
	mov eax, N ; ���������� ��������� ������� Probability_M
	
	push ebx ; ����� ������� Probability_M
	push eax ; 
	
	Call Gen@0
	
	pop eax
	pop ebx
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;�������������� � ����� ������� Bit �� ������ 160;;;;;;;;;;;;;;;;;;;;;;;;
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
	div ebx ; ������� �� 160, ����� �������� �������� �� 0 �� 159. 160 - ��� ���������� ����� � ������ 5*dd
	mov Bit[esi], edx
	
cmp Mode_r, 0
jne Out6
	outword Bit[esi], , " " 
Out6:
	add esi, 4
	loop L4
newline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;�������������� � ����� ������� Bit_M �� ������ 160;;;;;;;;;;;;;;;;;;;;;;;;
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
	div ebx; ������� �� 160, ����� �������� �������� �� 0 �� 159. 160 - ��� ���������� ����� � ������ 5*dd
	mov Bit_M[esi], edx
	
cmp Mode_r, 0
jne Out8
	outword Bit_M[esi], , " " 
Out8:
	add esi, 4
	loop L44
newline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;�������������� � ����� ������� Probability_M �� ������ 2;;;;;;;;;;;;;;;;;;;;;;;;

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
	div ebx ; ����� �� 2, ����� �������� 50% ����������� �������. ����� ������ �����������, ��� �����.
	mov Probability_M [esi], edx
	
cmp Mode_r, 0
jne Out10

	outword Probability_M [esi], , " " 
Out10:

	add esi, 4
	loop L444

newline

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;�����������;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 	
;;;;;;;;;;;;;;;;;;;;;;;;;�����������;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;�����������;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 	
	mov Index_child, 0

	mov ecx, N
	mov ebx, 0
	
L5:
	mov eax, Parent_1[ebx] 
	mul X_20 ; �������� �� 20 ��������� ����� (������) ���� ���� �� ����� �� 20 ����
	mov edi, eax ;i_1-� ������ Osobi
	mov eax, Parent_2 [ebx]
	mul X_20 
	mov edx, eax ;i_2-� ������ Osobi
	
	mov eax, Bit[ebx] ;���������� ����� ���� ��� �����������
	push ebx ; ���������� ������� ��������������� ���� ��������� 
	
	mov ebx, edi ;i_1-� ������ Osobi
	mov ebp, edx ;i_2-� ������ Osobi
	
	mov esi, 16 ; j_1-� ������� i_1-� ������ Osobi ��� i_2-� ������ Osobi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;��������� ����� ��������� ������� ���� � �����;;;;;;;;;;;;; 
L6: cmp eax, 32
	jl Change_byte ; ���� < 32, �� ������� � ������������� �����������
	mov edx, Osobi[ebx][esi] ; ���������� ������� �� Parent_1
	push ebx ; ���������� ����� ������ Parent_1
	mov ebx, Index_child
	mov Children[ebx][esi], edx ; � ����� 1-�� ������� ���������� ����� Parent_1 � ���� �������� �����
	mov edx, Osobi[ebp][esi] ; ���������� ������� �� Parent_2
	push ebp  ; ���������� ����� ������ Parent_2
	mov ebp, Index_child
	add ebp, 20 ; ��������� �� 2-�� �������, �.�. ������������� ����� ���� ������
	mov Children[ebp][esi], edx ; � ����� 2-�� ������� ���������� ����� Parent_2 � ���� �������� �����
	sub eax, 32 ; ��������� ��������������� ����� ���� �� 32
	sub esi, 4 ; ��������� ������ ������ � ���������� ������� i-� ������ � Parent_1 � Parent_2
	pop ebp
	pop ebx
	jmp L6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;������������ �����������;;;;;;;;;;;;; 	
Change_byte:

	push ecx; ��������� ecx ��� ������
	mov cl, al ; al = ����������� ���� ����� ����� ��������� ������ ������� ���� 
	mov edx, 1 
	shl edx, cl
	sub edx, 1 ; �����1 � ��������� � ����� ����� �������� � ������ ������� � ������� ��������� ������ ����
	mov edi, edx
	not edi    ; �����2 � ��������� � ������
	
	;�����1 �������� �� ������ �������� ��������: 000..001111 (=15)
	;�����2 �������� �� ����� �������� ��������:  11...110000
	
	push eax ; ���������� ���������� ���
	   
	mov  eax, Osobi[ebx][esi] ; ���������� ������� Parent_1 ��� �/� 
	mov  ecx, Osobi[ebp][esi] ; ���������� ������� Parent_2 ��� �/� 
	
	mov tmp1, eax ; �������� ���������� ������� Parent_1 ��� �/� 
	and tmp1, edx ; �������� ������ ����� �������� Parent_1
	mov tmp2, ecx ; �������� ���������� ������� Parent_2 ��� �/� 
	and tmp2, edi ; �������� ����� ����� �������� Parent_2
	mov eax, tmp1 ; ������ ������ ����� �������� Parent_1
	or eax, tmp2   ; ���������� ������ ����� �������� Parent_1 � ����� ����� �������� Parent_2
	
	push ebx ; ���������� ������ Parent_1 
	mov ebx, Index_child
	mov Children[ebx][esi], eax ; ������ ���������� ������� � 1-�� Children
	
	pop ebx
	
	mov  eax, Osobi[ebx][esi] ; ���������� ������� Parent_1 ��� �/� 
	mov  ecx, Osobi[ebp][esi]  ; ���������� ������� Parent_2 ��� �/� 
	
	mov tmp1, eax ; �������� ���������� ������� Parent_1 ��� �/� 
	and tmp1, edi ; �������� ����� ����� �������� Parent_1
	mov tmp2, ecx ; �������� ���������� ������� Parent_2 ��� �/� 
	and tmp2, edx ; �������� ������ ����� �������� Parent_2
	mov eax, tmp1 ; ������ ����� ����� �������� Parent_1
	or eax, tmp2 ; ���������� ����� ����� �������� Parent_1 � ������ ����� �������� Parent_2
	
	push ebx ; ���������� ������ Parent_1 
	mov ebx, Index_child
	add ebx, 20
	mov Children[ebx][esi], eax  ; ������ ���������� ������� �� 2-�� Children
	pop ebx
	
	sub esi, 4 ; ��������� � ����������� �������
	
	pop eax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;��������� ����� ��������� ������� ���� � ����� ����� �/�, ���� ����� ����� ����;;;;;;;;;;;;; 	
L7: cmp esi, 0
	jl FIN
	
	mov edx, Osobi[ebx][esi] ; ���������� ��������� ����� �/� ������� Parent_1
	push ebx ; ���������� ����� ������ Parent_1
	mov ebx, Index_child
	add ebx, 20 ; ��������� �� 2-�� �������, �.�. ������������� ����� ���� ������
	mov Children[ebx][esi], edx  ; ���������� �� 2-�� ������� ���������� ��������� ����� �/� ������� ����� Parent_1 
	mov edx, Osobi[ebp][esi] ; ���������� ��������� ����� �/� ������� Parent_2
	push ebp ; ���������� ����� ������ Parent_2
	mov ebp, Index_child ; ������ �������
	
	mov Children[ebp][esi], edx ; ���������� �� 1-�� ������� ���������� ��������� ����� �/� ������� ����� Parent_2
	sub esi, 4 ; ��������� � ����. �������
	pop ebp
	pop ebx
	jmp L7	
	
FIN:	
	pop ecx
	add Index_child, 40 ; ���������� 2-� Children, ����� ������� � ����� ��������� ����
	pop ebx ; ������� �� ����� ������ ���� ���������
	add ebx, 4 ; ��������� � ��������� ����  Parent'��
	sub ecx, 1
	cmp ecx, 0
	jle FF
	jmp L5 ; ��������� ������� ����������� ��� ��������� ���� ���������
	
FF:

newline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;������ ������� Children;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp Mode_r, 0
jne Out11

outstrln "Children:"

	lea ebx, Children
	mov eax, N ; �������� ���������� N �����
	add eax, N ; 2 N �����
	
	push ebx ; ���������� ����� ������� Children
	push eax  ; ���������� ���������� �����
	
	Call Print@0
	
	pop eax
	pop ebx
	
	newline
	newline
	
Out11:	
;;;;;;;;;;;;;;;;;;;�������� �������� ������� All_ � ����� ����������� ��������;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; ����������� �������� Osobi � Children;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov eax, 5 ; 5 ��������
	mul N
	mov ecx, eax
	mov ebx, 0
L10:
	mov eax, Osobi[ebx]
	mov All_[ebx], eax
	add ebx, 4
	loop L10
	
	mov eax, 10 ; ������ ��� Children = 2N
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
	
	push ebx ; ���������� ����� ������� All_
	push eax  ; ���������� ���������� �����	
	outstrln "Crossing_(All_: Osobi + Children): "
	call Print@0
	
	pop eax
	pop ebx
	newline
Out12:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;;;;������ ��������� �� ���� ������, ������� �����;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	mov eax, 3 ; ������ ��� 3N ������
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
	
;;;;;;;;;;;;;;;;;;;;;;;;������ ����������� ������� ���������;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;;;;;;��������� ������� Osobi;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
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


	 mov esi, 0 ;������ ������ �� Osobi , ������� ����� ���������
	 mov ecx, N ; ���������� ����������� ������ ����� ������� ���������

;;;;;;;;;;;;;;;;;;;;;;;;;;��������;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
N_min_str:
	 ;;;;;;;;;;;;;;;;;;;;;Find Minimun & index of min elem;;;;;;;;;;;;;;
	 mov ebx, 0
	 
	 mov eax, 3 ; 3N ������
	 mul N
	 sub eax, 1
	 
	 push ecx  ; ��������� ecx ��� �������� ����� ���������� ������� Osobi 
	 mov ecx, eax
	 mov ebp, 0
	
	 mov eax, Answers [ebx] ; eax ������ ����� ��������
	 add ebx, 4
L14:
	 cmp eax, Answers [ebx] ; ���������� ������� ������� �� ��������� ���������
	 jbe L15
	 mov eax, Answers [ebx] ; ����������� eax ����� �������� �������
	 mov ebp, ebx ; ��������� ���������� ����� ��������
	 
L15:
	 add  ebx, 4
	 loop L14

	newline

	;ebp - �������� ������ �������� � Answers
	;ebp/4, ����� ������ � All_
	;ebp/4 * 20 = ebp * 5 - ����� ����� � All_
	
	cmp Answers [ebp], 0 ; ����� ������
	je finish3
	
	mov Answers [ebp], -1 ; Answers[index_min] := Max_integer
	                      ; ������������� ��������� �������, �����
	                      ; ��������� ��� �� ���������� ������
						  
	;;;;;;;;;;;;;;;;;;;;;;;;Osobi[k] := All_[index_min];;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;���������� ��������� ������ ������������;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;�������� � ������ Osobi;;;;;;;;;;;;;;;;;;;;;
	mov eax, 5
	mul ebp
	
	mov ebp, eax ; ����� ������ ������������ �������� � All_
	mov edi, 0
	mov ecx, 5 ; ���������� ��������
L16: 	
	mov eax, All_ [ebp][edi] ; ���������� 1-� �������� ����������� �������
	mov All_ [ebp][edi], 0 ; ��������� ������ ������� All_
	mov Osobi [esi], eax ; ���������� 1-� �������� ����������� ������� � ������ Osobi
	add esi, 4
	add edi, 4
	loop L16
	
	pop ecx ; ����������  ecx ��� �������� ����� ���������� ������� Osobi 
	sub ecx,1 ; 
	cmp ecx, 0
	jle AA
	jmp N_min_str

AA:

cmp Mode_r, 0
jne Out14
	
	lea ebx, Osobi
	mov eax, N ; �������� ���������� N �����
	
	push ebx
	push eax
	
	outstrln "After Selection: "
	Call Print@0
	
	pop eax
	pop ebx
	
	newline
Out14:	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;����� ������� �������� ����� ��� ������� ����;;;;;;;;;;;;;;;;; 		

	mov ebx, 0
	mov edi, 0
	mov ecx, N
L18:
	;cmp Probability_M[edi], 1 ; ����������� ����� �� ������� ��� ���. 1 - ������ �����
	;jne L19
	
	mov eax, Bit_M [edi] ; ������ ������� Bit_M 
	
	push ecx ; ��������� ecx
	mov esi, 16 ; 4-� ������� ������. ��� ����� � ����� ������.
	mov ecx, 5 ; ����� ��������
L17:
	cmp eax, 32
	jl Mut 
	sub eax, 32
	
	;mov eax, Osobi [ebx][esi]
	sub esi, 4 ; ��������� �������
	jmp L17
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;;;;;;;�������;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 	

Mut:

	;eax - ����� ����, ������� ���� �������� � �����-�� �� 5-�� ���������
	mov edx, 0
	mov ebp, 8 ; ����� ���������� � �������� ����� (���������� ������� 8 ��� � ������-�� ������� �� ������)
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
	add ebx, 20 ; ��������� ������
	add edi, 4
	sub ecx, 1
	cmp ecx, 0
	jle KK  
	jmp L18
	
KK:

	
	lea ebx, Osobi
	mov eax, N ; �������� ���������� N �����
	
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
    mov ebp, 5 ; �������� � ������������ ������� �������� Answers � All_
	mul ebp
	mov ebp, eax
	
	mov eax, 1 ; ����� �������� ���� ������
	
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
  
  
  ;;;;;;;;;;;;;;��������;;;;;;;;;;;
	;N children
	
	;N pairs
	
	;2 ��������������� ������� ��� ���������
	;��������� ���������� �������
	;�� ����� �� ������ N, ����� �� ����� �� ������� ���������� ���������
	;������� ���������� ��������� 
	
	;1 4 2 7 1 4
	;3 5 1 10 2 3
   
   
   ;COMMENT ^
	;� = 100 ���
	;���������� 1 � 3 �����
	;1: 3 9 27 81 44
	;3: 132 197 193 181 145
	
	;����� ������� � ������
	;����� 160 ���
	;100-32>=0
	;��������� ���� ������ � �������, #4
	;100-32=68
	;68-32>=0
	;������������� ���� � �������, #3
	;68-32=36
	;36-32>=0
	;�����������������, #2
	;36-32=4
	
	;0<4< 32, stop, ���� #1
	;�.�. ���������� ��������� 9 � 197
	;�����1 �������� �� ������ �������� 1 ��������: 000..001111 (=15)
	;�����2 �������� �� ����� �������� 2 ��������:  11...110000
	
	;�������� ������� �� ��������� ������
	;(1 << 4) - 1: 
	;00000001
	;00010000 (=16)
	;00001111
	
	;�������� ��������� 4 ���� � 9:
	;a = 9 and 00001111
	;�������� ������ 28 ��� � 9:
	;b = 9 and (not 00001111)
	
	;�������� ��������� 4 ���� � 197:
	;c = 197 and 00001111
	;�������� ������ 28 ��� � 197:
	;d = 197 and (not 00001111)
	
	;������� �� ���� ������� ����� �����: d_a, b_c
	;d_a: d or a
	;b_c: b or c
	
	;������� � ������
	
	;�������� ���������� ��������:
	;32 - 4 = 28
	;160-100 = 60
	;60 - 28 = 32
	
	;����� ����, ���������� ���������� ����� ��������� � �����
	;����� 32 ����
	;32-32>=0
	;������ ���� ������� � �������
	;32-32=0
	;0-32 >=0?, stop
	;^  
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	;;;;;��������� ��� �������� ����� (��� 0-�) � ������ All_ 
	;;;;;������� Diophant ��� ������ ����� � ������ ��������� � Answers
	; �������� Osobi
	; ����� N ����������� ������ �� ������������ �� Answers 
	; � �������� �� � Osobi, ��� ������� ����� ���������
;;;;;;;;;;;;;;;;;������� ��������� Osobi � Children � ��������� ������ All_;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
