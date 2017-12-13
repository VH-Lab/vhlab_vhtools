set mypath=%cd%
for /D %%i in (*) do (cd %mypath% && cd %%i && echo %%i && git pull && cd ..)
