include console.inc

COMMENT *

  ���������� ���������� �� �����, ������ ���������� ������� �� �������. ������_������_6_2
*

.data 
     
   N dw ?
   K dw ?
	
.code
Start:
	
	outstrln "Vvedite chislo K"
	inintln K, "K="
	
	cmp K, 2 ; �������� ����� �
	jbe metka1
	
	mov dx, K ; ������ ���������� ��� ������
	
	outstrln "Vvedite chislo N"
	inintln N, "N="
	
	cmp N, dx ; �������� ����� N
	jbe metka1
	
	mov bx,-1 ; �������������� �������� �������� ������ -1 � ����� ���������� ��� ������ ������������ ������� �� ������� � �������� (�)
	mov si, 2 ; ������ ����� �� �������� ������, ������� � �� ����� ��������
	
	.while si <= K
	
	mov ax, N
	mov dx, 0 ; ���������� ���� ��������� DX:AX ��� ������� �������� ����� �� �����
	
	div si
	
	cmp bx, dx ; ���������� �������� ���������, ������� ������ ������� �� �������.
	jge L1 ; ���� �� ������ �������� ������ ��� �������, ��� dx, �� ����� ��������� � ��������+1
	
	mov bx, dx ; ������� � �� ����� ���������� ������� �� �������
	mov cx, si ; ������� � �� ���������� �����, ������ ���������� ������� �� �������
L1:	
	add si, 1
	
	.endw
	
	ja metka2
	
metka2:
		outintln bx,, "Naibolshii ostatok="
		outintln cx,, "Naimenshee chislo, kotoroe daet naibolshii ostatok="
		jmp finish
metka1: 
		outstrln "Programma zavershena"
		jmp finish
finish:
   exit
   end Start
   

   
   
   
   
   
   
   
   