'''
sine(12.15)
p(sine(12.15/3.0))
p(sine(4.05))
p(p(sine(4.05/3.0)))
p(p(sine(1.349999999)))
p(p(p(1.349999999/3.0)))
p(p(p(sine(1.349999999/3.0))))
p(p(p(sine(0.449999999))))
p(p(p(p(sine(0.449999999/3.0)))))
p(p(p(p(sine(0.149999999)))))
p(p(p(p(p(sine(0.149999999/3.0))))))
p(p(p(p(p(sine(0.049999999))))))
根据上面的替换模型，可以看出求sine(12.15)过程中调用了5次p函数。

由于a每次都是以除以3的速度减少，所以空间和时间的复杂度是O(Log a)，a每增长3倍，调用和空间增加1
'''

count = 0
a = 12.15
def cube(x):
    return x * x * x

def p(x):
    global count
    count += 1
    return 3*x - 4*cube(x)

def sine(angle):
    if not abs(angle) > 0.1:
        return angle
    else:
        return p(sine(angle/3.0))

def main():
    global count
    global a
    print(f"sine 12.15 is: {sine(12.15)} and called p {count} times", end='\n')
    for i in range(1, 4):
        count = 0
        a *= 3
        print(f"sine {a} is: {sine(a)} and called p {count} times", end='\n')

main()