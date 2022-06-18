@echo off


for /l %%a in (0,1,300) do batbox /g 2 %%a /d "%%a " /a %%a 


pause