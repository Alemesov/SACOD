type
  st = ^elem;
  elem = record
    key: string;
    next: st;
  end;

var
  top,p: st;
  i:integer;

procedure push(x: string);
begin
  if top <> nil then begin
    new(p);
    p^.key := x;
    p^.next := top;
    top:=p;
  end else begin
    new(top);
    top^.key := x;
    top^.next := nil;
  end;
end;

procedure pop();
begin
  if top <> nil then begin
    p := top;
    top := top^.next;
    dispose(p);
  end else writeln('Стек пуст!');
end;

procedure printer();
begin
  p := top;
  while p <> nil do 
  begin
    write(p^.key,' ');
    p := p^.next;
  end;
end;

begin
  push('abc');
  push('fx');
  push('glc');
  push('hi');
  push('gogo');
  pop();
  push('the end');
  printer();
  p:=top;
  i:=0;
  while p <> nil do begin
    if Length(p^.key) = 2 then inc(i);
    p:=p^.next;
  end;
  writeln();
  writeln(i,' элементов из двух элементов');
end.