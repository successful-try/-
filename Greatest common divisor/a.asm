include console.inc

COMMENT *

  ќпределить наименьшее из чисел, дающее наибольший остаток от делени€. ƒолгов_задача_6_2
*

.data 
     
   N dw ?
   K dw ?
	
.code
Start:
	
	outstrln "Vvedite chislo K"
	inintln K, "K="
	
	cmp K, 2 ;  онтроль ввода  
	jbe metka1
	
	mov dx, K ; нельз€ сравнивать две пам€ти
	
	outstrln "Vvedite chislo N"
	inintln N, "N="
	
	cmp N, dx ;  онтроль ввода N
	jbe metka1
	
	mov bx,-1 ; ѕервоначальное значение регистра задано -1 с целью присвоени€ ему самого минимального остатка от делени€ в принципе (о)
	mov si, 2 ; ѕервое число по услови€м задачи, которым   не может €вл€тьс€
	
	.while si <= K
	
	mov ax, N
	mov dx, 0 ; необходима пара регистров DX:AX дл€ делени€ двойного слова на слово
	
	div si
	
	cmp bx, dx ; сравниваем значени€ регистров, которые хран€т остаток от делени€.
	jge L1 ; если ¬’ хранит значение равное или большее, чем dx, то сразу переходим к делителю+1
	
	mov bx, dx ; заносим в ¬’ новый наибольший остаток от делени€
	mov cx, si ; заносим в —’ наименьшее число, дающее наибольший остаток от делени€
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
   

   
   
   
   
   
   
   
   