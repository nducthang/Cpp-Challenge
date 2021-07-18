@echo off

echo running test 1....
copy inp.01 %2 >null
bb -B -T %4 -M %5 %1 2>time.01
copy %3 out.01 >null

echo running test 2...
copy inp.02 %2 >null
bb -B -T %4 -M %5 %1 2>time.02
copy %3 out.02 >null

echo running test 3...
copy inp.03 %2 >null
bb -B -T %4 -M %5 %1 2>time.03
copy %3 out.03 >null

echo running test 4...
copy inp.04 %2 >null
bb -B -T %4 -M %5 %1 2>time.04
copy %3 out.04 >null

echo running test 5...
copy inp.05 %2 >null
bb -B -T %4 -M %5 %1 2>time.05
copy %3 out.05 >null

echo running test 6...
copy inp.06 %2 >null
bb -B -T %4 -M %5 %1 2>time.06
copy %3 out.06 >null

echo running test 7...
copy inp.07 %2 >null
bb -B -T %4 -M %5 %1 2>time.07
copy %3 out.07 >null

echo running test 8...
copy inp.08 %2 >null
bb -B -T %4 -M %5 %1 2>time.08
copy %3 out.08 >null

echo running test 9...
copy inp.09 %2 >null
bb -B -T %4 -M %5 %1 2>time.09
copy %3 out.09 >null

echo running test 10...
copy inp.10 %2 >null
bb -B -T %4 -M %5 %1 2>time.10
copy %3 out.10 >null

del null.*
del %2
del %3

Ptich

