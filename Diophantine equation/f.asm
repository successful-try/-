include console.inc
COMMENT *

  ����� ���� �������� �� ���������� ������. ������_������_10_2
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
	 push ebp ; ��������� ebp
	 mov  ebp, esp
	 
	 push esi; ��������� esi
	 push edi; ��������� edi
	 
	 mov esi, [ebp+12] ; esi = Osobi, ������� � ebx ////// esi = Parent, ������� � ebx //////// esi = Bit, ������� � ebx/////// esi = Bit_M, ������� � ebx
	 mov edi, [ebp+8]; edi = N,  ������� � eax 
	 
	 push ebx
	 push eax
	 push ecx
	 
	 sub edi, 1 ; ����� 1, ������ ��� ������ ������� �����
	 mov ecx, edi
	 
metka3:	 
	 mov eax, [esi];[[ebp+12]], ���������� �������� �������� esi, � ������� ����� ������� Osobi/Parent/Bit/Bit_M
	 mov ebx, a_
	 mul ebx
	 mov ebx, m_
	 div ebx
	 
	 add esi, 4
	 mov [esi], edx ; ��������� � ��������� ������� �����
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
  
     push ebp ; ��������� ebp
	 mov  ebp, esp
	 
	 push esi; ��������� esi
	 push edi; ��������� edi
	 push ebx
	 push ecx
	 push edx
	 
	 mov ebx, [ebp+12] ; esi = Osobi/Children � �� ������� � ebx 
	 mov edi, [ebp+8]; edi = N ��� 2N, ���� Children ������� � eax 
  
    mov ecx, edi
	
L: 
	mov edx,ecx ; ��������� ecx
	mov ecx,5 ; 5 - ���������� ��������, �������� �� ��������
	mov esi,0
	
L1: 
	outword [ebx][esi], ," " ; ������ �����
	add esi, 4
	loop L1
	
	newline
	
	mov ecx,edx ; ���������� ecx
	add ebx, 20; 5 ��������� (Xi) ���������� �� 4 �����, �.�. �i dd 
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
  
  mov esi, [ebp+8]; ����� ����� ������ ������� All_
  mov ecx, 5 ; ����� ��������
  mov ebx, 0
  mov edi, 0
  
 L8:
	mov eax, [esi];  ������ �������� �� ������ � ������� �� esi
	mul A[edi] ; �������� �� ����������� �� ������� �
	add ebx, eax ; ������������ ������������ 
	add esi, 4 ; ��������� ������� �� esi
	add edi, 4 ; ��������� ������� �� ������� �
    loop L8
	
	sub ebx, D ; ���� ��������� ����� ������ � D
	cmp ebx, 0
	jge L9
	neg ebx
 L9: 
	mov eax, ebx ; ������ ��������� �������� ������� All_, ������ �� ������
  
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
	
	mov ecx, [ebp+8] ; ����� ���� �� e�x
	mov ebx, [ebp+12] ; C�� ������� �� Osobi
	
	mov edx, 1
	shl edx, cl

	xor ebx, edx ; �������� ������������ ��� �� ��������������� �������� 
	mov eax, ebx

	pop ebx
	pop ecx
	pop edx
	pop ebp 
	
	ret
    Mutacia endp
  
   end
   
   