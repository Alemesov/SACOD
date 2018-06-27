type
  st = ^elem;
  elem = record
    komputer: string;
    memory: byte;
    next: st;
  end;

var
  beg,fin,p: st;
  i:integer;

procedure push(param1: string; param2: byte);
begin
  if beg <> nil then begin
    new(p);
    p^.komputer := param1;
    p^.memory:= param2;
    p^.next := nil;
    fin^.next := p;
    fin:=p;
  end else begin
    new(beg);
    beg^.komputer := param1;
    beg^.memory:= param2;
    beg^.next := nil;
    fin:=beg;
  end;
end;

procedure pop();
begin
  if beg <> nil then begin
    p := beg;
    beg := p^.next;
    dispose(p);
    if beg = nil then fin:= nil;
  end else writeln('Очередь пуста!');
end;

procedure printer();
begin
  p := beg;
  while p <> nil do 
  begin
    write(p^.komputer, ' ',p^.memory,'гб; ');
    p := p^.next;
  end;
end;

begin
  push('домашний',4);
  push('рабочий',16);
  push('учебный',8);
  push('ноутбук',4);
  pop();
  printer();
  p:=beg;
  i:=0;
  while p <> nil do begin
    i:=i+p^.memory;
    p:=p^.next;
  end;
  writeln();
  writeln(i,'гб общая память компьютеров');
end.