include console.inc

COMMENT *
    Конвертация секунд в часы:минуты:секунды
*

.data
   T   dd ?
   H db ?
   M db ?
   S db ?
   H_0 dw 3600
   M_0 db 60
   
.code
Start:

	inint T, "Vvedite chislo ot 0 do 86399, T="
	
	
	mov dx, word ptr T+2
	mov ax, word ptr T
	div H_0
	
	mov H, al
	mov ax, dx
	
	div M_0
	
	mov M, al
	mov S, ah

	outintln H,, "Kolichestvo chasov H="
	outwordln M,, "Kolichestvo minut M="
	outwordln S,, "Kolichestvo sekund S="
	

   exit
   end Start