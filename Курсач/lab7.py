def search(lst, item):
    pos = 0
    while pos < len(lst):
        if lst[pos][0] == item:
            return pos
        else:
            pos = pos+1
    return None
spisok = [[16487,'Вирская И.Е','директор',2008],[46736,'Смирнова В.Л','секретарь',2010],[53287,'Егорова Р.Е','уборщик',2013],[63921,'Тюрин Я.Т','охрана',2007],[71863,'Щербаков В.А','зам.директора',2008],[14234,'Назарова А.С','бухгалтер',2005],[52142,'Гаврилов Т.А','менеджер',2016]]
spisok.sort()
for i in range(len(spisok)):
    print(spisok[i][0])
x=0
while x != 99999:
    x=int(input('Введите номер табельного номера: '))
    result=search(spisok,x)
    if result != None:
        print(spisok[result])
    else:
        print('Ничего не найдено!')
