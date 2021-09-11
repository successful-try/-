Program Sortirovki_Puzirek_i_Porstaya_Sortirovka;
type
   Stud =    record 
             Name:string;
             Surname:string;
             Group_No:string;
             Date_of_birth:string;
             end;
             
    stud_arr = array [1..100] of Stud;
    
var 
    Students, Students1:stud_arr; 
    n,mode, Compare_Count, Swap_Count_Puzirek, Swap_Count_Prostoe_Sliyanie:integer;    
    
function Compare(s1, s2: Stud) : boolean; // funkciya Sravnenie
   var d1, d2: string;
begin
  Compare_Count:=Compare_Count+1;

  d1 := s1.Date_of_birth;
  d2 := s2.Date_of_birth;
  
  d1 := Copy (d1,7,4) + '.' + Copy(d1,4,2) + '.' + Copy(d1,1,2);
  d2 := Copy (d2,7,4) + '.' + Copy(d2,4,2) + '.' + Copy(d2,1,2);
  
  Compare := d1 > d2;
end;

procedure Swap (var Students: stud_arr; i, j:integer); // procedura Perestanovki
    var Students_service:Stud;
begin
    Swap_Count_Puzirek:=Swap_Count_Puzirek+1;

    Students_service := Students [i];
    Students[i] := Students [j];
    Students[j] := Students_service;
end;

procedure Puzirek (var Students: stud_arr; n:integer); // procedura sortirovki "Puzirek"
  var i,j,m:integer;
begin    
  for i := 1 to n - 1 do 
    for j:= i + 1 to n do
    begin
      if Compare(Students[i], Students[j]) then
        Swap(Students, i, j);
      if mode=1 then
         for m:=1 to n do
            write (Students[m].Date_of_birth, ' ');
         writeln;
    end;
end;

function Prostoe_Sliyanie (Students: stud_arr; start, finish:integer) : stud_arr; // procedura sortirovki "Prostoe_Sliyanie"
   var i,j, mid:integer;
   S1, S2, S: stud_arr;
begin 
   if (start = finish) then 
   begin
     Students[1]:= Students[start];
     Prostoe_Sliyanie := Students;
     exit;
   end;
   
   mid := (finish + start) div 2;
   S1 := Prostoe_Sliyanie(Students, start, mid);
   S1[mid - start + 2].Date_of_birth := '99.99.9999';
   
   S2 := Prostoe_Sliyanie(Students, mid + 1, finish);
   S2[finish - (mid + 1) + 2].Date_of_birth := '99.99.9999';
   
   
   
   if mode = 1 then
   begin
    for i:= 1 to mid - start + 1 do
      write (S1[i].Date_of_birth, ' ');
    write('       ');
    for i:= 1 to finish - mid do
      write (S2[i].Date_of_birth, ' ');
    writeln;
   end;
   
   
   i := 1;
   j := 1;
   while ((i <= mid - start + 1) or (j <= finish - mid)) do
   begin
      if(Compare(S1[i], S2[j])) then
      begin
         Swap_Count_Prostoe_Sliyanie := Swap_Count_Prostoe_Sliyanie + 1;
         S[i + j - 1] := S2[j];
         j:= j + 1;
      end
      else
      begin 
        Swap_Count_Prostoe_Sliyanie := Swap_Count_Prostoe_Sliyanie + 1;
        S[i + j - 1] := S1[i];
        i:= i + 1; 
      end;
   end;
   
   if mode = 1 then
   begin
    for i:= 1 to finish - start + 1 do
      write (S[i].Date_of_birth, ' ');
    writeln;
    writeln;
   end;
   Prostoe_Sliyanie := S;
end;

procedure Vvod_iz_faila (name: string; var Students:stud_arr; var n: integer);
var f : text;
i : integer;
str : string;
begin
  assign(f, name);
  reset (f);
  
  readln(f, str);
  n := strtoint(str);
  readln(f, str);
  
  for i:=1 to n do
    begin
      readln (f, Students[i].Name);
      readln (f, Students[i].Surname);
      readln (f, Students[i].Group_No);
      readln (f, Students[i].Date_of_birth);
      readln (f, str);
    end;
 close (f);
end;

procedure Vivoda_iz_faila (name: string; var Students:stud_arr; n  : integer);
var f : text;
i:integer;
begin
   assign (f, name);
   rewrite (f);
  
  writeln(f, n);
  writeln(f);
  
  for i:=1 to n do
    begin
      writeln (f, Students[i].Name);
      writeln (f, Students[i].Surname);
      writeln (f, Students[i].Group_No);
      writeln (f, Students[i].Date_of_birth);
      writeln (f);
    end;
  close (f);
   
end;

{procedure Enter (var Students:stud_arr; i:integer); // Vvod odnogo studenta 
begin
    {write('    Enter Name: ');
    //readln (Students[i].Name); 
    write('    Enter Surname: ');
    readln (Students[i].Surname);
    write('    Enter Group_No: ');
    readln (Students[i].Group_No);
    write('    Enter Date_of_birth: ');
    readln (Students[i].Date_of_birth); 
end;

procedure Enter_vse (var Students:stud_arr; n:integer); // Vvod vsex studentov 
    var i:integer;
begin
    for i:= 1 to n do
    begin
      writeln('Enter ', i, ' student');
      Enter (Students,i);
    end;
end;
    
procedure Print (var Students:stud_arr; i:integer); // Pechat' odnogo studenta
begin
    write('    Name: ');
    writeln (Students[i].Name); 
    write('    Surname: ');
    writeln (Students[i].Surname);
    write('    Group_No: ');
    writeln (Students[i].Group_No); 
    write('    Date_of_birth: ');
    writeln (Students[i].Date_of_birth); 
end;   

procedure Print_vse (var Students:stud_arr; n:integer); // Pechat' vsex studentov 
var i:integer;
begin
    for i:= 1 to n do
    begin
      writeln('Print ', i, ' student');
      Print (Students,i);
    end;
end;}
  
begin 
 //    writeln ((abs(786+546)mod 5)+1); // Puzirek      
  //   writeln ((abs(786+212)mod 4)+6); // Prostoe_Sliyanie
  //   writeln ((abs(867+123)mod 11)+1); // Vxodnie dannie №1
     
     //writeln ('Vvedite chislo studentov');
     //readln (n);
     
     //Enter_vse(Students, n);
     
     
     Vvod_iz_faila ('Spisok5.txt', Students, n);
     Students1 := Students;
     
     
     writeln ('Vvedite rezhim (0 - obichnii, 1 - demonstracionnii)');
     readln (mode);
     writeln;
     
     writeln ('Statistika_Puzirek:');
     Puzirek(Students, n);
     writeln;
     
     Vivoda_iz_faila ('Vivod0.txt', Students, n);

     //Print_vse(Students, n);

     
     writeln ('Compare_Count = ',Compare_Count);
     writeln;
     writeln ('Swap_Count_Puzirek = ',Swap_Count_Puzirek);
     
     Compare_Count:= 0;
     writeln;
     
     writeln ('Statistika_Prostoe_Sliyanie:');
     
     Students1 := Prostoe_Sliyanie(Students1, 1, n);
   
     
     writeln;
     
      Vivoda_iz_faila ('Vivod01.txt',  Students1, n);
     //Print_vse(Students1, n);
     writeln;
     
     writeln ('Compare_Count = ',Compare_Count);
     writeln;
     writeln ('Swap_Count_Prostoe_Sliyanie = ',Swap_Count_Prostoe_Sliyanie);
     
end. 
