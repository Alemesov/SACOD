uses
  crt;

type
  list = ^elem;
  elem = record
    key: word;
    next: list;
  end;

var
  p, q, head1, tail1, head2, tail2, head3, tail3: list;
  x, y, z: integer;
  zna4: word;

procedure printer(head: list);//вывод списка
begin
  q := head;
  if q <> nil then begin
    writeln('Текущий список:');
    while q <> nil do
    begin
      write(q^.key, ' ');
      q := q^.next;
    end;
    writeln();
  end
  else writeln('Список не существует!');
end;

procedure ListInit(var head, tail: list);//создание списка с барьерным элементом
begin
  if (head = nil) or (head^.next <> nil) then
  begin
    new(head);
    head^.next := tail;
    writeln('Список создан!');
    printer(head1);
  end
  else writeln('Список уже существует!');
end;

procedure listupload(var head, tail: list);//добавление элементов в список  
var
  i, kolvo: integer;
begin
  writeln('Введите число элементов:');
  Readln(kolvo);
  for i := 1 to kolvo do
  begin
    new(p);
    p^.next := head^.next;
    p^.key := random(5, 300);
    head^.next := p;
  end; 
  writeln('Внесено ', i, ' элементов!');
  printer(head);
end;

procedure push(x: word; j: integer; head: list);//добавление элемента непосредственно за i-тым
var
  i: integer;
begin
  if head <> nil then begin
    q := head;
    for i := 1 to j - 1 do 
    begin
      if (q <> nil) and (q^.next <> nil) then q := q^.next else begin
        writeln('i-тый элемент не существует');
        exit;
      end;
    end;
    new(p);
    if q^.next <> nil then begin
      p^.key := x;
      p^.next := q^.next;
      q^.next := p; 
      writeln('Элемент вставлен!');
    end
    else begin
      p^.key := x;
      q^.next := p;
      writeln('Элемент вставлен!');
    end;
  end
  else writeln('Элемент не существует!');
end;

procedure del(j: integer; head: list);//удаление элемента следующего за i-тым
var
  i: integer;
begin
  if head <> nil then begin
    q := head^.next;
    for i := 1 to j - 3 do 
    begin
      if (q <> nil) and (q^.next <> nil) then q := q^.next else begin
        writeln('i-тый элемент не существует');
        exit;
      end;
    end;
    new(p);
    if q^.next <> nil then begin
      p := q^.next^.next;
      dispose(q^.next);
      q^.next := p;
      writeln('Элемент удален!');
    end
    else begin
    end;
  end
  else writeln('Элемент не существует!');
end;

procedure searchmin(head: list);//поиск минимального значения в списке
var
  min: real;
begin
  q := head;
  if q <> nil then begin
    min := q^.key;
    while q <> nil do
    begin
      if q^.key < min then min := q^.key;
      q := q^.next;
    end;
    writeln('Минимальный элемент: ', min);
  end
  else writeln('Список пуст!');
end;

function range(head: list): integer;//определение длины списка
var
  i: integer;
begin
  q := head;
  i := 1;
  if q <> nil then begin
    while q <> nil do 
    begin
      i := i + 1;
      q := q^.next;
    end;
    range := i - 1;
  end else range := 0;
end;

procedure delall(var head, tail: list);//удаление всех элементов списка
begin
  if head <> nil then begin
    while head^.next <> nil do
    begin
      p := head^.next;
      if p <> nil then
      begin
        head^.next := p^.next;
        dispose(p);
      end;
    end;
    dispose(head);
    tail := nil;
    head := nil;
    writeln('Все элементы списка удалены!');
  end
  else writeln('Список не существует!');
end;

procedure copy(var head1, tail1, head2, tail2: list);//копирование списка
var
  z: list;
begin
  if head1 <> nil then begin
    delall(head2, tail2);
    q := head1^.next;
    new(head2);
    p := head2;
    while q <> nil do
    begin
      new(z);
      p^.next := z;
      z^.key := q^.key;
      q := q^.next;
      p := z;
    end;
  end 
  else writeln('Список пуст!');
end;


procedure check(head1, head2: list);//проверка на равенство
begin
  p := head1;
  q := head2;
  if (head1 <> nil) or (head2 <> nil) then begin
    while (p <> nil) or (q <> nil) do
    begin
      if p^.key = q^.key then
      begin
        p := p^.next;
        q := q^.next;
      end
      else begin
        writeln('Списки не равны!'); exit;
      end;
    end;
    writeln('Списки равны!');
  end
  else writeln('Список не существует');
end;

procedure divide(var head1, head2, head3: list);//разбиение списка
var
  i, x: integer;
  thead1, thead2: list;
begin
  x := range(head1);
  q := head1;
  if head1 <> nil then begin
    for i := 1 to x do
    begin
      if i <= x div 2 then
      begin
        new(p);
        p^.key := q^.key;
        p^.next := head2^.next;
        head2^.next := p;
      end
        else
      begin
        new(p);
        p^.key := q^.key;
        p^.next := head3^.next;
        head3^.next := p;
      end;
      q := q^.next;
    end;
    head2 := head2^.next;
    head3 := head3^.next;
    q := head2;
    new(thead1); 
    thead1^.next := nil;
    while q <> nil do
    begin
      new(p);
      p^.key := q^.key;
      p^.next := thead1^.next;
      thead1^.next := p;
      q := q^.next;
    end;
    head2 := thead1^.next;
    q := head3;
    new(thead2); 
    thead2^.next := nil;
    while q <> nil do
    begin
      new(p);
      p^.key := q^.key;
      p^.next := thead2^.next;
      thead2^.next := p;
      q := q^.next;
    end;
    head3 := thead2^.next;
  end
  else writeln('Список не существует!');
end;

procedure integrate(var head1, head2: list);//слияние списков
begin
  if (head1 <> nil) or (head2 <> nil) then begin
    q := head1;
    while q^.next <> nil do q := q^.next;
    q^.next := head2;
  end
  else writeln('Список не существует!');
end;

procedure indiv2(var head: list);
begin
  if head <> nil then begin
    if head^.next^.key < 100 then begin
      q := head^.next;
      head^.next := q^.next;
      dispose(q);
      exit;
    end;
    p := head^.next;
    while (p <> nil) or (p^.next <> nil) do
    begin
      if p^.next^.key < 100 then begin
        q := p^.next;
        p^.next := q^.next;
        dispose(q);
        exit;
      end;
      p:=p^.next;
    end;
  end
  else writeln('Список не существует!');
end;

begin
  head1 := nil;tail1 := nil;head2 := nil;tail2 := nil;head3 := nil;tail3 := nil;
  x := 100;
  writeln('1)Создать список' + chr(10) + '2)Заполнить список' + chr(10) + '3)Распечатать список' + chr(10) +
    '4)Найти длину списока' + chr(10) + '5)Вставить новый элемент после i позиции' + chr(10) + '6)Удалить i элемент' + chr(10) +
    '7)Разбить список на два' + chr(10) + '8)Соединить два списка' + chr(10) + '9)Создать копию списка' + chr(10) + '10)Проверить первые два списка на равенство' + chr(10) +
    '11)Удалить все элементы списка' + chr(10) + '12)Найти минимальный элемент списка' + chr(10) + '13)Удалить первый элемент меньший 100' + chr(10));
  while x <> 0 do
  begin
    Readln(x);
    if x = 1 then 
    begin
      writeln('Введите номер создаваемого списка 1, 2 или 3:');
      Readln(y);
      if y = 1 then ListInit(head1, tail1);
      if y = 2 then ListInit(head2, tail2);
      if y = 3 then ListInit(head3, tail3);
    end;
    if x = 2 then 
    begin
      writeln('Введите номер заполняемого списка 1, 2 или 3:');
      Readln(y);
      if y = 1 then listupload(head1, tail1);
      if y = 2 then listupload(head2, tail2);
      if y = 3 then listupload(head3, tail3);
    end;
    if x = 3 then 
    begin
      writeln('Введите номер печатаемого списка 1, 2 или 3:');
      Readln(y);
      if y = 1 then printer(head1);
      if y = 2 then printer(head2);
      if y = 3 then printer(head3);
    end;
    if x = 4 then 
    begin
      writeln('Введите номер списка 1, 2 или 3:');
      Readln(y);
      if y = 1 then writeln(range(head1) + ' элементов в списке');
      if y = 2 then writeln(range(head2) + ' элементов в списке');
      if y = 3 then writeln(range(head3) + ' элементов в списке');
    end;
    if x = 5 then 
    begin
      writeln('Введите номер списка 1, 2 или 3:');
      Readln(y);
      writeln('Введите индекс элемента');
      Readln(z);
      writeln('Введите значение элемента');
      Readln(zna4);
      if y = 1 then push(zna4, z, head1);
      if y = 2 then push(zna4, z, head2);
      if y = 3 then push(zna4, z, head3);
    end;
    if x = 6 then 
    begin
      writeln('Введите номер списка 1, 2 или 3:');
      Readln(y);
      writeln('Введите индекс элемента');
      Readln(z);
      if y = 1 then del(z, head1);
      if y = 2 then del(z, head2);
      if y = 3 then del(z, head3);
    end; 
    if x = 7 then 
    begin
      writeln('1 чтобы разбить первый список на второй и третий, 2 чтобы разбить второй на первый и третий');
      Readln(y);
      if y = 1 then divide(head1, head2, head3);
      if y = 2 then divide(head2, head1, head3);
    end;
    if x = 8 then 
    begin
      writeln('1 чтобы соединить первый список со вторым, 2 чтобы соединить второй список с первым');
      Readln(y);
      if y = 1 then integrate(head1, head2);
      if y = 2 then integrate(head2, head1);
    end;
    if x = 9 then 
    begin
      writeln('1 чтобы создать копию первого списка во второй, 2 копия второго списка в первый:');
      Readln(y);
      if y = 1 then copy(head1, tail1, head2, tail2);
      if y = 2 then copy(head2, tail2, head1, tail1);
    end;
    if x = 10 then check(head1, head2);
    if x = 11 then 
    begin
      writeln('Введите номер удаляемого списка 1, 2 или 3:');
      Readln(y);
      if y = 1 then delall(head1, tail1);
      if y = 2 then delall(head2, tail2);
      if y = 3 then delall(head3, tail3);
    end; 
    if x = 12 then 
    begin
      writeln('Введите номер списка 1, 2 или 3:');
      Readln(y);
      if y = 1 then searchmin(head1);
      if y = 2 then searchmin(head2);
      if y = 3 then searchmin(head3);
    end;
    if x = 13 then 
    begin
      writeln('Введите номер списка 1, 2 или 3:');
      Readln(y);
      if y = 1 then indiv2(head1);
      if y = 2 then indiv2(head2);
      if y = 3 then indiv2(head3);
    end; 
    if x = 14 then begin
      ClrScr;
      writeln('1)Создать список' + chr(10) + '2)Заполнить список' + chr(10) + '3)Распечатать список' + chr(10) +
          '4)Найти длину списока' + chr(10) + '5)Вставить новый элемент после i позиции' + chr(10) + '6)Удалить i элемент' + chr(10) +
          '7)Разбить список на два' + chr(10) + '8)Соединить два списка' + chr(10) + '9)Создать копию списка' + chr(10) + '10)Проверить первые два списка на равенство' + chr(10) +
          '11)Удалить все элементы списка' + chr(10) + '12)Найти минимальный элемент списка' + chr(10) + '13)Удалить первый элемент меньший 100' + chr(10));
    end;
  end;
end.