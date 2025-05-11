from matplotlib import pylab as plt
from matplotlib import colors
import numpy as np
import math
from itertools import product


def triangle_FS (U, a=None, b=None, c=None, d=None, h=1, form='equal'):
    if form in ['equal', 'greater', 'less']:
        if a is None:
            a = U.min()
        if d is None:
            d = U.max()
        if b is None:
            if c is None:
                b=(a+d)/2.
            else:
                b=c
        if c is None:
            c=b
        Mu=dict()
        if a>U.min():
            for el in U[U<=a]:
                Mu[el] = h if form=='less' else 0.
        if d<U.max():
            for el in U[U >= d]:
                r=h if form == 'greater' else 0.
                z=Mu.get(el,0)
                Mu[el] = r if r>z else z
        if a<b:
            for el in U[(U>=a)*(U<=b)]:
                r=0. if form == 'greater' else h*float(el-a)/(b-a) if form == 'equal' else h*float(b-el)/(b-a)
                z=Mu.get(el,0)
                Mu[el] = r if r>z else z
        if b<c:
            for el in U[(U >= b)*(U <= c)]:
                r = h if form == 'equal' else 0.
                z = Mu.get(el, 0)
                Mu[el] = r if r > z else z
        if c<d:
            for el in U[(U>=c)*(U<=d)]:
                r=0. if form == 'less' else h*float(el-c)/(d-c) if form == 'greater' else h*float(d-el)/(d-c)
                z=Mu.get(el,0)
                Mu[el] = r if r>z else z
        return Mu
    else:
        print('Unknown form')
        return None

def FS_plot(FS, colors=colors.cnames.keys(), labels = None, title=None, name=None):
    for idx, el in enumerate(FS):
        mas = np.array (sorted(el.items(), key=lambda x: x[0])).T
        if (labels is None):
            lab = ' '
        else:
            lab=labels[idx]
        #plt.plot(mas[0], mas[1], color=list(colors)[idx], label=lab)
        my_colors = ['purple', 'pink', 'green', 'blue', 'red', 'brown', 'black', 'magenta', 'yellow'];
        plt.plot(mas[0], mas[1], color=(my_colors[idx]), label=lab)
    if not (labels is None):
        plt.legend (loc = 'upper right')
    if not (title is None):
        plt.title (title)
    if not (name is None):
        plt.savefig(name+'.png', format='png', dpi=100)
    plt.show()

Spr = np.arange (1, 101, 1)
Pr1 = triangle_FS (Spr, a=20, b=40, c=60, d=80)
Pr2 = triangle_FS (Spr, a=20, b=40, c=60, d=80, form='less')
Pr3 = triangle_FS (Spr, a=20, b=40, c=60, d=80, form='greater')
FS_plot([Pr1, Pr2, Pr3], labels=['medium_speed', 'low_speed', 'high_speed'])

Pr4 = triangle_FS (Spr)
FS_plot([Pr4], title=u'Идеальное множество')
print (Pr1[25])

def F_And (FV, method='minmax'):
    if method=='minmax':
        return np.min(FV)
    elif method=='probability':
        return np.product(FV)
    else:
        print ('Неизвестный метод ', method)
        return None

def F_Or (FV, method='minmax'):
    if method=='minmax':
        return np.max(FV)
    elif method=='probability':
        mu=0
        for el in FV:
            mu=mu+el - mu*el
        return mu
    else:
        print ('Неизвестный метод ', method)
        return None

def F_Not (V1):
    return 1-V1

def alpha_srez (FS, alpha=0.5):
    alph=1e-10 if alpha==0. else alpha
    mas = np.array(list(FS.items())).T
    #print (FS.items())
    return set(mas[0][mas[1]>=alph])

def FS_moment (FS, centr=None):
    mas = np.array(list(FS.items())).T
    if centr is None:
        Cntr_g=np.sum(mas[0]*mas[1])/np.sum(mas[1])
    else:
        Cntr_g=centr
    return np.sum(mas[1]*np.square(mas[0]-Cntr_g))

def FS_describe(FS, method='minmax', verbose='True'):
    mas=np.array(list(FS.items())).T
    h=np.max(mas[1])
    N = np.sum(mas[1]>0)
    Min_el = np.min(mas[0][mas[1] > 0])
    Max_el = np.max(mas[0][mas[1] > 0])
    Fst_max = np.min(mas[0][mas[1]==h])
    Lst_max = np.max(mas[0][mas[1]==h])
    Cntr_max = mas[0][mas[1] == h].mean()
    Cntr_grav = np.sum(mas[0]*mas[1])/np.sum(mas[1])
    Mmnt_in=FS_moment(FS)
    R1=-np.sum([0 if x==0 else x*np.log2(x) for x in mas[1]])
    R1n = (2.*R1)/len(mas[1])
    R2 = 2./len(mas[1])*np.sum([F_And([x, F_Not(x)], method=method) for x in mas[1]])
    R3 = 2./np.sqrt(len(mas[1]))*np.sqrt(np.sum([F_And([x, F_Not(x)], method=method)**2 for x in mas[1]]))
    if verbose:
        print ('Высота= ', h)
        print('Мощность= ', N)
        print('Диапазон значений: ', (Min_el, Max_el))
        print(':Максимумы ', (Fst_max, Cntr_max, Lst_max))
        print('Центр тяжести= ', Cntr_grav)
        print('Момент инерции= ', Mmnt_in)
        print('Размытость: ')
        print('Энтропийная мера= ', (R1, R1n))
        print('Альтернатива 1 (линейная)= ', R2)
        print('Альтернатива 2 (квадратичная)= ', R3)
    return (h, N, (Min_el, Max_el), (Fst_max, Cntr_max, Lst_max), Cntr_grav, Mmnt_in, ((R1, R1n), R2, R3))

#print (alpha_srez (Pr1, alpha=0.5))
r = FS_describe(Pr1)

#print (FS_moment (Pr1, r[3][0]))
#print (FS_moment (Pr1, r[3][1]))
#print (FS_moment (Pr1, r[3][2]))

'''
D_pr1 = triangle_FS(Spr, b=0, c=100, h=0.5)
FS_plot([D_pr1], title = u'Максимально размытое множество', name='p6')
r=FS_describe(D_pr1)

D_pr2 = dict()
for el in Spr:
    D_pr2[el] = np.random.randint(2)
FS_plot([D_pr2], title = u'Случайное строгое множество', name='p6')
r=FS_describe(D_pr2)
'''

def FS_quantificator(FS, quantificators=[u'очень']):
    mas=np.array(list(FS.items())).T
    for el in np.flip(quantificators, axis=0):
        if el==u'очень':
            mas[1]=np.square(mas[1])
        elif el==u'наверное':
            mas[1] = np.sqrt(mas[1])
        elif el == u'не':
            mas[1] = 1-mas[1]
        else:
            print('Неизвестный квантификатор ', el, '. Должно быть очень, наверное или не')
    return dict(mas.T)

'''
quants=[[u'не'], [u'очень'], [u'наверное']]
labels=[u'не', u'очень', u'наверное']
FS_plot([FS_quantificator(Pr1, quantificators=x) for x in quants], labels=labels)

quants=[[u'не', u'очень'], [u'очень', u'не'], [u'наверное', u'не', u'очень']]
labels=[u'не очень', u'очень не', u'наверное не очень']
FS_plot([FS_quantificator(Pr1, quantificators=x) for x in quants], labels=labels)
'''

def FS_union (FSs, Ps=None, method='minmax'):
    U=set()
    for FS in FSs:
        U=set.union(U, FS.keys())
    res=dict()
    for el in U:
        s_mu=[]
        for idx, FS in enumerate (FSs):
            p= 1 if Ps is None else Ps[idx]
            s_mu.append(F_And([p, FS.get(el, 0)], method=method))
        res[el] = F_Or(s_mu, method=method)
    return res

def FS_intersection (FSs, Ps=None, method='minmax'):
    U=set()
    for FS in FSs:
        U=set.union(U, FS.keys())
    res=dict()
    for el in U:
        s_mu=[]
        for idx, FS in enumerate (FSs):
            p= 1 if Ps is None else Ps[idx]
            s_mu.append(F_And([p, FS.get(el, 0)], method=method))
        res[el] = F_And(s_mu, method=method)
    return res

'''
FS_plot([Pr1, Pr2], labels=[u'Equal', u'Less'], title=u'Исходные множества')
FS_plot([FS_intersection([Pr1,Pr2], Ps=[1,1], method='minmax'), FS_union([Pr1,Pr2], Ps=[1,1], method='minmax')], labels=[u'Пересечение', u'Объединение'], title=u'Минимаксный подход')
FS_plot([FS_intersection([Pr1,Pr2], Ps=[1,1], method='probability'), FS_union([Pr1,Pr2], Ps=[1,1], method='probability')], labels=[u'Пересечение', u'Объединение'], title=u'Вероятностный подход')
'''

'''
p=0.4
otv1=FS_union([Pr1,Pr2], Ps=[p,1-p], method='minmax')
otv2=FS_union([Pr1,Pr2], Ps=[p,1-p], method='probability')
FS_plot([otv1, otv2], labels=[u'минимаксный', u'вероятностный'], title=u'Первая задача, p='+str(p))
'''


def FS_arifm_operation_Num(FS, num, Func= lambda x,y: x+y):
    mas1=np.array(list(FS.items())).T
    mas1[0]=Func(mas1[0], num)
    return dict(mas1.T)

Giri=np.array([8., 12., 16., 24., 32., 48., 64., 72., 128.])
l_Giri=triangle_FS(Giri, b=8., d=64., h=1, form='equal')
h_Giri=triangle_FS(Giri, b=16., d=64., h=1, form='greater')
#FS_plot([l_Giri, h_Giri], title=u'Легкая и тяжелая гири')

l2_Giri=FS_arifm_operation_Num(l_Giri, 2, Func= lambda x,y: x*y)
#FS_plot([l_Giri, l2_Giri], labels=[u'легкая', u'2*легкая'], title=u'2 легкие гири')


def FS_arifm_operation_Set(FS1, FS2, Func= lambda x,y: x+y, method='minmax', clearing=False):
    res=dict()
    for p1,p2 in list(product(FS1.keys(), FS2.keys())):
        res[Func(p1, p2)]=F_Or([F_And([FS1[p1], FS2[p2]], method=method), res.get(Func(p1, p2),0)], method=method)
    if clearing:
        res1=dict()
        res2=dict()
        mas_T=sorted(res.items(), reverse=True, key=lambda x: x[0])
        mu=-1
        for el in mas_T:
            if el[1]>=mu:
                res1[el[0]]=el[1]
                mu=el[1]
        mas_T=sorted(res.items(), reverse=False, key=lambda x: x[0])
        mu=-1
        for el in mas_T:
            if el[1]>=mu:
                res2[el[0]]=el[1]
                mu=el[1]
        #print ('res1= ' + str(res1))
        #print ('res2= ' + str(res2))
        return FS_union([res1, res2])
    else:
        return res
'''
l21_Giri=FS_arifm_operation_Set(l_Giri, l_Giri, clearing=True)
FS_plot([l2_Giri, l21_Giri], labels=[u'2*легкая', u'легкая+легкая'], title=u'2 лекгие гири')

lh_Giri=FS_arifm_operation_Set(l_Giri, h_Giri)
FS_plot([lh_Giri], title=u'тяжелая + легкая гири(без очистки)')

lhc_Giri=FS_arifm_operation_Set(l_Giri, h_Giri, clearing=True)
FS_plot([lhc_Giri], title=u'тяжелая + легкая гири(с очисткой)')
'''


'''
Нечеткий вывод
'''

Stemp = np.arange(1, 41, 0.25)
Teplo=triangle_FS(Stemp, a=10, b=20, d=30)
Holodno=triangle_FS(Stemp, a=10, b=20, d=30, form='less')
Zharko=triangle_FS(Stemp, a=10, b=20, d=30, form='greater')
#FS_plot([Teplo, Holodno, Zharko], labels=[u'Тепло', u'Холодно', u'Жарко'] )

def FS_func(FSx, Uy, Func=lambda x,Ux,Uy: np.array([1]*len(Uy)), method='minmax'):
    masx=list(FSx.items())
    Ux=np.array(masx).T[0]
    masmu=np.array([0]*len(Uy))
    if method=='minmax':
        for el in Ux:
            masmu=np.max([masmu, np.min([Func(el, Ux, Uy), [FSx[el]] * len(Uy)], axis=0)], axis=0)
    elif method == 'probability':
         for el in Ux:
            mm=Func(el, masx, Uy) * FSx[el]
            masmu = masmu+mm-masmu*mm
    else:
        print ('Неизвестный метод', method)
    return dict (np.array([Uy, masmu]).T)

def FS_f(x, Ux, Uy):
    minx = np.min(Ux)
    miny = np.min(Uy)
    maxy = np.max(Uy)
    k= float(x-minx)/float(Ux.max()-minx)
    gran=k*(maxy-miny)+miny

    arr1 = np.array([], 'float64')
    for y in Uy:
        if (y == gran):
            arr1 = np.append(arr1, 1.)
        elif y < gran:
            arr1 = np.append(arr1, float(y - miny) / (gran - miny))
        else:
            arr1 = np.append(arr1, float(maxy - y) / (maxy - gran))
    return arr1

Oboroti = np.arange(100, 2001, 10)
#FS_plot([FS_func(Holodno, Oboroti, Func=FS_f), FS_func(Teplo, Oboroti, Func=FS_f), FS_func(Zharko, Oboroti, Func=FS_f)], labels=[u'Холодно', u'Тепло', u'Жарко'], title=u'Обороты вентилятора при')

quants = [[u'не'],[u'очень'],[u'наверное']]
#FS_plot( [FS_quantificator(Teplo, quantificators=x) for x in quants], labels=[u'не',u'очень',u'наверное'], title=u'тепло')
#FS_plot( [FS_func(FS_quantificator(Teplo, quantificators=x), Oboroti, Func=FS_f) for x in quants], labels=[u'не',u'очень',u'наверное'], title=u'обороты вентилятора при тепло')



S_T=np.arange(0., 151., 1.)
T_high=triangle_FS(S_T, b=50., d=100., h=1, form='greater')
T_middle=triangle_FS(S_T, b=50., c=100., h=1, form='equal')
T_low=triangle_FS(S_T, a=50., b=100., h=1, form='less')
#FS_plot([T_high, T_middle, T_low], labels=[u'Высокая', u'Средняя', u'Низкая'], title=u'Показатель температуры')


S_T=np.arange(0., 101., 1.)
P_high=triangle_FS(S_T, b=0., h=1, form='greater')
P_middle=triangle_FS(S_T, b=50., h=1, form='equal')
P_low=triangle_FS(S_T, b=100., h=1, form='less')
#FS_plot([P_high, P_middle, P_low], labels=[u'Высокое', u'Среднее', u'Низкое'], title=u'Показатель давления')


S_R=np.arange(0., 8.1, 0.1)
R_high=triangle_FS(S_R, a=4., b=6., d=8., h=1, form='equal')
R_middle=triangle_FS(S_R, a=2., b=4., d=6., h=1, form='equal')
R_low=triangle_FS(S_R, a=0., b=2., d=4., h=1, form='equal')
#FS_plot([R_high, R_middle, R_low], labels=[u'Высокий', u'Средний', u'Низкий'], title=u'Показатель расхода')


T=85 #Пусть температура
R=3.5 #Пусть расход топлива
pp1=F_And([T_low[T], R_low[R]])
pp2=T_middle[T]
pp3=F_Or([T_high[T], R_high[R]])
print (pp1, pp2, pp3)
res_minmax=FS_union([P_low, P_middle, P_high], Ps=[pp1, pp2, pp3])
#FS_plot([res_minmax])
r=FS_describe(res_minmax)


Sob=np.arange(0, 2000., 10.)
Niskie=triangle_FS(Sob, a=600, b=800, d=1000, h=1, form='less')
Visokie=triangle_FS(Sob, a=600, b=800, d=1000, h=1, form='greater')
Srednie=triangle_FS(Sob, a=600, b=800, d=1000, h=1, form='equal')
#FS_plot([Niskie, Srednie, Visokie], labels=[u'Низкие', u'Средние', u'Высокие'], title=u'Обороты вентилятора')

T=23
pp1=Holodno[T]
pp2=Teplo[T]
pp3=Zharko[T]
res1 = FS_union([Niskie, Srednie, Visokie], Ps=[pp1, pp2, pp3], method='minmax')
res2 = FS_union([Niskie, Srednie, Visokie], Ps=[pp1, pp2, pp3], method='probability')
#FS_plot([res1, res2], labels=['minmax', 'probability'], title=u'Обороты вентилятора')

print ('На основе минимаксного подхода')
r=FS_describe(res1)

print ('На основе вероятностного подхода')
r=FS_describe(res2)

