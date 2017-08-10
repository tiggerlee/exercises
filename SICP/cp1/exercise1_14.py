'''
程序运行结果count_change方法的调用趋近于O(a^n)
空间增长同计算斐波那契数列一样，O(a)
'''

coins_denomination = (20, 10, 5, 2, 1)
count = 0

def count_change(amount, kinds_of_coins):
    global count
    count += 1
    if amount == 0:
        return 1
    elif amount < 0 or kinds_of_coins == 0:
        return 0
    else:
        return count_change(amount, kinds_of_coins-1) + count_change(amount-coins_denomination[kinds_of_coins-1], kinds_of_coins)

def main():
    global count
    result = []
    amount = 10
    for x in range(1, 7):
        count = 0
        amount *= 2
        count_change(amount, 5)
        result.append(count)
        if x > 1:
            print(f"radio: {result[x-1]/result[x-2]}", end='\n')

main()
