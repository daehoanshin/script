@ECHO OFF
set argc=0
for %%x in (%*) do Set /A argc+=1
if %argc% == 0 (
        echo no param
)
if %argc% == 1 (
    echo param count = 1 "param=%1"
)
if %argc% == 2 (
    echo param count = 2, "param=%1 %2"
) else (
    echo param count = %argc%, "param=%*"
)


if "%1"=="apple" (
    echo "param1 is apple"
    goto end
) else (
   echo "param1 is not apple"
   goto end
)
