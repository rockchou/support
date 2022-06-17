# Python中的运算符
"""
1.算术运算符
    1.1 标准算术运算符
    1.2 取余运算符
    1.3 冥运算符
2.赋值运算符
3.比较运算符
4.布尔运算符
5.位运算符
"""

print(1+1)      # 加法运算
print(1-1)      # 减法运算
print(2*4)      # 乘法运算
print(1/2)      # 除法运算
print(11/2)     # 除法运算
print(11//2)    # 5 整除运算
print(11%2)     # 1 取余运算
print(2**2)     # 表示2的2次方
print(2**3)     # 表示2的3次方


print(9//4)     # 2
print(-9//-4)   # 2

print(9//-4)    # -3
print(-9//4)    # -3
# 一正一负的整数公式，向下取整。
# 如上，（9除以-4）和（-9除以4），正常计算结果-2.25，向下取整结果就是-3

print(9%-4)     # -3
print(-9%4)     # 3
# 余数=被除数-除数*商
# 9-(-4)*(-3) --> 9-12  --> -3
# (-9)-4*(-3) --> -9-(-12)  --> 3