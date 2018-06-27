uses crt;
type
        peremen = ^ukaz;
        ukaz = record
                       FIO: string; 
                       Position: string;
                       Year:integer;  
                       next: peremen; 
                       pred: peremen; 
                   end;

//процедура "Меню"
procedure vibor(var my_vibor: integer);
begin
    writeln();
    writeln(' Ваши действия:');
    writeln('1. Заполнить список сотрудников (добавить несколько элементов)');
    writeln('2. Показать информацию о сотрудниках предприятия');
    writeln('3. Принять на работу человека');
    writeln('4. Уволить сотрудника'); 
    writeln('5. Поиск сотрудника');                                                                              
    writeln('6. Длина списка сотрудников ');
    writeln('7. Проверка предприятия на существование');
    writeln('8. Уволнение всех сотрудников'); 
    writeln('9. Изменение должности сотрудника');
    writeln('10. Поиск года поступления последнего сотрудника');
    writeln('11. Сортировка по году поступления');
    writeln('12. Деление списка на 2');
    writeln('0. Завершить программу ');
    writeln;
    write('Ваш выбор: ');
    readln(my_vibor);
end;

//процедура "Заполнить список сотрудников рандомно (или добавляем)"
procedure create(var head, tail: peremen);
var  q: peremen;
        mas1: array[1..9] of string;
        mas2: array[1..4] of string;
        n: integer;
begin
    n:=9;
    while n > 0 do
    begin
       mas1[1]:='Рысак М.В.';
       mas1[2]:='Бурлаковский Ю.В.';
       mas1[3]:='Макаревич А.В.';
       mas1[4]:='Завьялов А.В.';
       mas1[5]:='Бледный А.А.';
       mas1[6]:='Картошка Л.К.';
       mas1[7]:='Хабенский К.Р.';
       mas1[8]:='Солодовник Б.К.';
       mas1[9]:='Сулейманов И.Р.';

       mas2[1]:='Секретарь';
       mas2[2]:='Программист';
       mas2[3]:='Вебдизайнер';
       mas2[4]:='Сисадмин';
       
       //работаем уже с указателем
        New(q);
        q^.next := nil;
        q^.pred := nil;
        q^.Year:=random(19)+2000;
        q^.FIO :=mas1[random(9)+1];
        q^.Position :=mas2[random(4)+1];
        if head = nil then 
            begin
                head := q;
                tail := q;
            end
        else 
            begin
                tail^.next := q;
                tail^.next^.pred := tail;
                tail := q;
            end;
        n := n - 1;
    end;
end;

//процедура "Показать информацию о сотрудниках предприятия"
procedure Print(head: peremen);
var
    R: peremen;
    i: integer;
begin
    if head <> nil then 
          begin
             i := 1;
             R := head;
             while R <> nil do
                  begin
                      Writeln(i:2, '.     ',
                      R^.FIO:18, '      ',
                      R^.Position:11,'     ',
                      R^.Year:4);
                      R := R^.next;
                      Inc(i);
                  end;
          end
     else
          writeln('Список пуст');
end;

{ Процедура уволнения }
Procedure DelElem(var spis1,spis2:peremen;tmp:peremen);{удаления элемента в двунаправленном списке}
var   tmpi:peremen;
begin
  if (spis1=nil) or (tmp=nil) then
    exit;
  if tmp=spis1 then begin{если удаляемый элемент первый в списке, то}
        spis1:=tmp^.next; {указатель на первый элемент переставляем на следующий элемент списка}
        if spis1<>nil then {если список оказался не из одного элемента, то}
             spis1^.pred:=nil {"зануляем" указатель}
        else {в случае, если элемент был один, то}
             spis2:=nil; {"зануляем" указатель конца списка, а указатель начала уже "занулён"}
        dispose(tmp);
        end
  else
    if tmp=spis2 then begin{если удаляемый элемент оказался последним элементом списка}
          spis2:=spis2^.pred; {указатель конца списка переставляем на предыдущий элемент}
          if spis2<>nil then {если предыдущий элемент существует,то}
               spis2^.next:=nil {"зануляем" указатель}
          else {в случае, если элемент был один в списке, то}
              spis1:=nil; {"зануляем" указатель на начало списка}
          dispose(tmp);
          end
    else begin{если же удаляется список не из начали и не из конца, то}
          tmpi:=spis1;
          while tmpi^.next<>tmp do {ставим указатель tmpi на элемент перед удаляемым}
               tmpi:=tmpi^.next;
          tmpi^.next:=tmp^.next; {меняем связи}
          if tmp^.next<>nil then
              tmp^.next^.pred:=tmpi; {у элемента до удаляемого и после него}
          dispose(tmp);
          end;
end;
Procedure DelElemPos(var spis1,spis2:peremen; posi:integer);
var i:integer;
       tmp:peremen;
begin
     i:=1;
     tmp:=spis1;
     while (tmp<>nil) and (i<>posi) do 
         begin
             tmp:=tmp^.next;
             inc(i)
         end;
    DelElem(spis1,spis2,tmp);
end;

{ Процедура "Принять на работу человека" }
procedure AddWorker(var perv,konec:peremen);
begin
    if perv=nil then  
        begin
            new(perv); {создаём элемент, указатель nach уже будет иметь адрес}
            perv^.next:=nil;
            perv^.pred:=nil;
            konec:=perv; {изменяем указатель конца списка}
            write('Введите ФИО: '); readln(konec^.FIO);
            write('Введите должность: '); readln(konec^.Position);
            writeln('Введите год поступления: ',konec^.Year);
        end
    else 
        begin
            new(konec^.next); {создаём новый элемент}
            konec^.next^.pred:=konec; {связь нового элемента с последним элементом списка}
            konec:=konec^.next;{конец списка изменился и мы указатель "переставляем"}
            konec^.next:=nil; {не забываем "занулять" указатели}
            write('Введите ФИО: '); readln(konec^.FIO);
            write('Введите должность: '); readln(konec^.Position);
            writeln('Введите год поступления: '); readln(konec^.Year);
        end;
end;

//процедура "длина списка сотрудников"
procedure dlina_sp(head: peremen; var dlina_spiska: integer);
var k: integer;
    R: peremen;
begin
    R := head;
    k := 0;
    while R <> nil do 
        begin
            R := R^.next;
            k := k + 1;
        end;
    dlina_spiska := k;
end;

//процедура "Уволнение сотрудника"
procedure minus_worker(head,tail: peremen);
var
     i,j: integer;
     R: peremen;
begin
    if head <> nil then 
        begin
            write('Введите номер сотрудника в списке: ');readln(i);
            R := head;
            j:=1;
            While (j<>i) and (R^.next<>nil) do  
                begin
                      R:=R^.next;
                      inc(j);
                end;       
            If j<>i  then 
                writeln('К сожалению сотрудника с таким номером нет')  
            else 
                begin
                     writeln('Этот сотрудник уволен');
                     DelElemPos(head,tail, j);
                     Print(head);
                end;
         end
    else
        writeln('Фирмы не существует');
end;

//процедура Проверка предприятия на существование
procedure proverka_spiska_na_pustotu(head: peremen);
begin
    if head = nil then
        writeln('Список пуст')
    else
        writeln('Такая фирма существует');
end;

//процедура Уволнение всех сотрудников
procedure udalenie_vsego(var head,tail:peremen);
var q:peremen;
begin
    while head<>nil do  
        begin
            q:=head;
            head:=head^.next;
            if head<>nil then
                dispose(q)
            else 
                begin
                    tail:=nil;
                    dispose(q);
                end;
        end;
    writeln('Список очищен!' );
end;

//процедура "Изменение должности сотрудника"
procedure izmenenie_elementa(dlina_spiska:integer;head:peremen);
var i,j:integer;
       s: string;
       R:peremen;
begin
    R:=head;
	if R<>nil then 
	    begin
            write('Введите номер сотрудника, которому вы хотите изменить должность: ');
            readln(i);
	        if (i>=0) and (i<=dlina_spiska) then 
	            begin
	  	           j:=1;
		           while j<>i do 
		               begin
		                   R:=R^.next;
		                   j:=j+1;
		               end;
		           write('Введите новую должность сотрудника: ');
		           readln(s);
		           R^.Position:=s;
		       end
	       else 
	           begin
	               writeln('ваш номер выходит за пределы списка, введите другой номер ');
	               izmenenie_elementa(dlina_spiska,head);
	           end;
        end
    else
        writeln('Список пуст');
end;

//процедура "Поиск года поступления последнего сотрудника"
procedure max_el_spiska (var head: peremen);
var
     R:peremen;
     max,i,j:integer;
Begin
    if head<>nil then
        begin
            R:=head;
            max:=R^.Year;
            i:=1;
            R:=R^.next;
            While R<>nil do
                begin
                     i:=i+1;
                     if max<R^.Year then 
                         begin 
                             max:=R^.Year;j:=i;
                         end;
                     R:=R^.next;
                end;
            writeln('Год поступления последнего сотрудника:  ',max);
            writeln('Сотрудник под номером: ', j);
        end
     else
          writeln('Список пуст');
end;

{ Поиск сотрудников по ФИО }
procedure poisk_el_s_zad_name(head: peremen);
var
    R: peremen;
    j: integer;
     s: string;
    name: string;
begin
    s := '';
    j := 1;
    R := head;
    if R <> nil then 
        begin
            write('Введите ФИО сотрудника:');readln(name);
            while R <> nil do
                begin
                    if (R^.FIO = name) then 
                        begin
                            s:=s+'1';
                            writeln(j,'. ',R^.Position);
                            j := j + 1;
                            R := R^.next;
                        end
                    else 
                        begin
                            R := R^.next;
                                j := j + 1;
                        end;
               end;
           delete(s, length(s) - 1, 1);
           if s='' then    
               writeln('нет таких сотрудников');
        end
    else
        writeln('Список пуст');
end;

//Процедура "дополнение для Сортировки"
procedure perestanovl(var head, head1, head2: peremen);   {перестановка элементов между собой}
var R:peremen;
begin
    R:= head1^.next;    
    if head2 = nil then {Вставка перед первым элементом.}
        begin
             head1^.next := R^.next;
             R^.next := head;
             head := R;
        end
     else  {Вставка между элементами.}
         begin              
             head1^.next := R^.next;
             R^.next := head2^.next;
             head2^.next := R;
         end;
end;

//процедура "Сортировка по году поступления"
procedure sort_po_cene(var head:peremen);  
var  R, p :peremen;
begin
    if head<>nil then 
        begin
            writeln('До сортировки');
            Print(head);
            writeln;
            R := head; 
            while R^.next <> nil do 
                begin
                    if not (R^.Year <= R^.next^.Year) then 
                        begin
                            if not (head^.Year <= R^.next^.Year) then 
                            p := nil
                            else 
                                begin
                                    p := head;
                                    while p^.next^.Year <= R^.next^.Year do
                                        p := p^.next;
                                end;
                            perestanovl(head,R,p); 
                        end
                    else
                        R := R^.next; 
                end;
            writeln('После сортировки');Print(head);
        end 
    else 
        writeln('Список пуст');
end;

//
procedure delenie_na_2_spiska(var head,tail,head1,tail1:peremen);
var
    q,i,dlina_spiska:integer;
    R:peremen;
begin
    R:=head;
    dlina_sp(R,dlina_spiska);
    if head<>nil then
        begin
               q:=dlina_spiska div 2;
                i:=0;
                while i<>q do
                       begin
                           R:=R^.next;
                           i:=i+1;
                       end;
                tail1:=R;
                R:=R^.next;
                head1:=R;
                tail1^.next:=nil;
                head1^.pred:=nil;
         end
    else
          writeln('Список пуст, надо заполнить!!!');
end;

//
procedure vibor1(var choose1:integer);
begin
    writeln();
    writeln('Что вы хотите сделать?:');
    writeln('1. Показать 2 списка');
    writeln('2. Проверка 2ух списков на равенство');
    writeln('3. Соединение 2ух списков в один (основные действия только с одним списком)');
    writeln();
    write('Ваш выбор: ');
    readln(choose1);
end;

//
procedure connect(tail1,head1:peremen);
begin
    tail1^.next:=head1;
    head1^.pred:=tail1;
end;

//
procedure proverka(head,head1:peremen);
var
    p:integer;
    R,R1:peremen;
    namefile:string;
begin
    R:=head;
    R1:=head1;
    p:=1;
    while (R^.next<>nil) and (p=1) do
          begin
             if (R^.FIO<>R1^.FIO)  then
                  begin
                       p:=0;
                  end
               else
                     begin
                       R:=R^.next;
                       R1:=R1^.next;
                     end;
          end;
     if p=1 then writeln('Списки одинаковы')
     else  writeln('Списки не одинаковы');
end;



//начало основной программы
var
    my_vibor, dlina_spiska,choose1: integer;
    head, tail ,head1,tail1:peremen;

begin
    vibor(my_vibor);
    writeln();

//цикл меню-действий (если нажать цифру 0-программа завершится)
    while my_vibor <> 0 do
    begin
        case my_vibor of
            1: create(head, tail);
            2: begin
                    writeln('                 ФИО              Должность     Год');
                    Print(head);
                end;
            3: AddWorker(head,tail);
            4: minus_worker(head,tail);
            5: poisk_el_s_zad_name(head);
            6: begin
                     dlina_sp(head,dlina_spiska);
                     writeln('Длина списка: ',dlina_spiska);
                 end;
             7: proverka_spiska_na_pustotu(head);       
             8: udalenie_vsego(head,tail);
             9: begin
                          dlina_sp(head,dlina_spiska);
                          izmenenie_elementa(dlina_spiska,head);
                  end;
             10: max_el_spiska (head);
             11: sort_po_cene(head);
             12: begin
                 dlina_sp(head,dlina_spiska);
                 if dlina_spiska>=2 then 
                     begin
                         delenie_na_2_spiska(head,tail,head1,tail1);
                         writeln('1ый список');
                         Print(head);
                         writeln('2ой список');
                         Print(head1);
                         vibor1(choose1);
                         writeln();
                         while choose1<>3 do 
                             begin
                                 case choose1 of
                                     1: begin
                                             writeln('1ый список');
                                             Print(head);
                                             writeln();
                                             writeln('2ой список');
                                             Print(head1);
                                         end;
                                    2: proverka(head,head1);
                                end;
                                vibor1(choose1);
                            end;
                        connect(tail1,head1);
                    end
                else
                    writeln('Невозможно сделать это действие');
              end;
           end;
        vibor(my_vibor);
    end; 
    udalenie_vsego(head,tail);  
end. 
