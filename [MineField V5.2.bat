

::MineField V4.9 crée par Luca De Santos (SpeedCookie)
::Contact  Desantos_luca@yahoo.com
                                          
Rem ---------------------- Copyright ----------------------------------


:: MineField Copyright (c) by SpeedCookie, ne pas copier, modifier, distribuer ce code sans mon autorisation
:: commandes externes utilisés :
:: -Batbox; By DarkBatcher 

::Merci aux personnes du forum http://batch.xoo.it/ pour leur aide et leurs conseils 

Rem ---------------------- Copyright ----------------------------------

@echo off
set lvl=0
IF NOT EXIST BatBox.exe CALL :make_bb
if not exist Records.save call :new_record
if not exist Boom.vbs call :make_boom
if not exist beep.vbs call :make_beep
if not exist LevelUp.vbs call :make_levelup
if not exist Fantome.vbs call :make_Fantome
if not exist Ralenti.vbs call :make_Ralenti
setlocal enabledelayedexpansion

goto :initialisation

:initialisation
for /f "tokens=1 delims=/" %%a in (Records.save) do set record=%%a
mode con cols=40 lines=15
title MineField V4.9
color 0f
set Ralenti=off
set col=5
set tpsPU=0
set ligne=5
set niveau=normal
set col_PU=0
set PU2=aucun
set Fantome2=off
set couleurlvl=0x03
set PU3=inactif
set ligne_PU=0
set act1=jouer
set tpsPU2=0
set lvl=1
set tpsPU=0
set BAR=
set PU=0
set dir=nope
set /a randPU=%random%%%200
set temps=150
set z=6
if %lvl% geq %record% set /a record=%lvl%+1 & call :new_record
goto :Choix_sons



:Choix_sons
cls
  
echo.
echo.
echo      Voulez-vous activer les sons?    
echo                  [O/N]  
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo    (Si le jeu ne marche pas avec les 
echo          sons desactivez les )



batbox /g 4 6 /c 0x0f /d "-Windows 8(.1)  " /c 0x0a /d V
batbox /g 4 7 /c 0x0f /d "-Windows 7      " /c 0x0a /d V
batbox /g 4 8 /c 0x0f /d "-Windows Vista  " /c 0x0c /d X
batbox /g 4 9 /c 0x0f /d "-Windows XP     " /c 0x0c /d X /c 0x0f
batbox /k

if %errorlevel%==111 cls & goto :sons_actives
	
if %errorlevel%==110 cls & goto :sons_desactives
goto :Choix_sons


:sons_actives
set sons2=actives
set couleursons=0x0f
set son1=start %CD%\sons\beep.vbs
set son2=start %CD%\sons\levelUp.vbs
set son3=start %CD%\sons\Boom.vbs
set son4=start %CD%\sons\Ralenti.vbs
set son5=start %CD%\sons\Fantome.vbs
batbox /g 22 8 /c 0x00 /d %sons2%000 /c 0x0f
batbox /g 13 10 /c 0x00 /d 00 /c 0x0f
goto :menu


:sons_desactives
set couleursons=0x08
set sons2=desactives
set son1=
set son2=
set son3=
batbox /g 22 8 /c 0x00 /d %sons2%000 /c 0x0f
batbox /g 13 10 /c 0x00 /d 00 /c 0x0f
goto :menu




:menu
if %act1%==reprendre set niveau=Partie & set couleurlvl=0x00

batbox /g 18 2 /d "MENU "
batbox /g 4 4 /d "[1]  %act1% "
batbox /g 4 6 /d "[2]  Difficulte:  " /c %couleurlvl% /d %niveau% /c 0x0f 
batbox /g 4 8 /d "[3]  Sons:        " /c %couleursons% /d %sons2% /c 0x0f
batbox /g 4 10 /d "[4]  Aide"

batbox /k


if %errorlevel%==52 goto :aide 
if %errorlevel%==51 (
	if %sons2%==actives goto :sons_desactives
	if %sons2%==desactives start %CD%\sons\beep & goto :sons_actives
)
if %errorlevel%==50 (
	if %niveau%==normal set niveau=expert & set couleurlvl=0x0c
	if %niveau%==expert set niveau=debutant & set couleurlvl=0x0a
	if %niveau%==debutant set niveau=normal & set couleurlvl=0x03
	if %niveau%==Partie goto :o2
)
if %errorlevel%==49 (
	if %act1%==jouer goto :%niveau%
	if %act1%==reprendre goto :cadre 
)

:o2

batbox /g 22 6 /c 0x00 /d 00000000000 /c 0x0f 
goto :menu

:aide 
cls

batbox /g 18 1 /d "AIDE "
echo.
echo.
echo        Appuyez sur les touches 
echo    directionnelles pour vous deplacer
echo.
echo.
echo.
echo.
echo.
echo  -Power-Up's
batbox /g 1 6 /c 0x0e /d  /c 0x0f /d "=Vous" 
batbox /g 1 7 /c 0x0c /d  /c 0x0f /d "=Point" 
batbox /g 1 8 /c 0x08 /d X /c 0x0f /d "=MINE!!"        
batbox /g 1 11 /c 0x03 /a 174 /c 0x0f /d "=Ralenti (Reduis la vitesse du jeu)"
batbox /g 1 12 /c 0x03 /a 64 /c 0x0f /d "=Fantome (passez a travers les mines)"

pause>nul
cls
goto :menu


:debutant 
set temps=200 
set z=4 
goto :new_terrain


:normal 
set temps=150 
set z=6 
goto :new_terrain

:expert 
set temps=100 
set z=10 
goto :new_terrain 



:b 
%son1%
set BAR=%BAR%
if %points% geq 5 goto :levelup

goto :a 

:levelup
set /a lvl=%lvl%+1
if %lvl% geq %record% set /a record=%lvl%+1 & call :new_record

%son2%

for /l %%$ in (3,1,%z%) do if not %Fantome2%==on batbox /g !col%%$! !ligne%%$! /c 0x08 /d X /c 0x0f
batbox /g 26 5 /c 0x0c /d "%BAR%" /c 0x0f

set /a z=%z%+1
goto :new_terrain



:new_record
set record=%lvl%
echo.%record%>Records.save

goto :eof

:new_terrain
set BAR=
set dir=nope
for /l %%$ in (3,1,%z%) do call :set %%$
for /l %%$ in (3,1,%z%) do ( 
	if !col%%$! lss 2 goto :new_terrain
	if !ligne%%$! lss 2 goto :new_terrain
	if !col%%$!!ligne%%$!==%col%%ligne% goto :new_terrain
) 

set points=0
goto :a 

:set 
set /a col%1= %random%%%21
set /a ligne%1= %random%%%11
goto :eof

:a 


set /a col2=%random%%%21
set /a ligne2=%random%%%11
if %col2% lss 2 goto :a 
if %ligne2% lss 2 goto :a 
for /l %%$ in (3,1,%z%) do if %col2%%ligne2% equ !col%%$!!ligne%%$! goto :a 

goto :cadre


:cadre
set act1=reprendre
if %lvl% geq %record% set /a record=%lvl%+1 & call :new_record




cls
echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»              
echo º                    º  
echo º                    º   Niveau %lvl% 
echo º                    º  
echo º                    º  Ú       ¿
echo º                    º    
echo º                    º  À       Ù
echo º                    º   
echo º                    º   
echo º                    º   Menu [M]
echo º                    º   
echo ÈÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍ¼  
echo     º            º   
echo     ÈÍÍÍÍÍÍÍÍÍÍÍÍ¼



batbox /g 26 5 /c 0x0c /d "%BAR%" /c 0x0f 
for /l %%$ in (3,1,%z%) do if not %Fantome2%==on batbox /g !col%%$! !ligne%%$! /c 0x08 /d X /c 0x0f
for /l %%$ in (3,1,%z%) do if %Fantome2%==on batbox /g !col%%$! !ligne%%$! /c 0x06 /d X /c 0x0f
batbox /g 6 12 /d "Record:%record%"

:cadre1
if not %PU3%==actif set /a tpsPU=%tpsPU%+1
if %PU3%==actif set /a tpsPU2=%tpsPU2%-1

if %PU3%==actif (
	if %tpsPU2%==0 call :stop%PU2%
)


if %PU% neq 1 (if %tpsPU%==%randPU% call :Power_up)


:k2
if %tpsPU2%==9 batbox /g 25 13 /c 0x00 /d  "%PU2%! 00" /c 0x0f
if %PU3%==actif batbox /g 25 13 /d  "%PU2%! %tpsPU2%" /c 0x0f 

if %PU%==1 (
	if %col_PU%%ligne_PU%==%col%%ligne% call :%PU2%
)
if %col%%ligne% equ %col2%%ligne2% set /a points=%points%+1 & goto :b 
if %PU%==1 (
	if not %PU3%==actif batbox /g %col_PU% %ligne_PU% /c 0x03 /a %graph_PU% /c 0x0f
)
batbox /g %col% %ligne% /c 0x0e /d  /c 0x0f /w %temps%
batbox /g %col2% %ligne2% /c 0x0c /d  /c 0x0f
for /l %%$ in (3,1,%z%) do (if not %Fantome2%==on ( 
	if %col%%ligne% equ !col%%$!!ligne%%$! goto :mort)
)

batbox /k_

if %errorlevel%==109 cls & goto :menu

if %errorlevel%==327 set dir=haut

if %errorlevel%==330 set dir=gauche

if %errorlevel%==335 set dir=bas

if %errorlevel%==332 set dir=droite

if not %dir%==nope goto :%dir%


goto :cadre1



:Power_up
set PU=1
set tpsPU=0 
set /a randPU2=%random%%%2
set /a randPU=%random%%%200
if %randPU2%==1 call :set_PU_Fantome
if %randPU2%==0 call :set_PU_Ralenti
goto :eof



:set_PU_Ralenti
set PU=1 
set PU2=Ralenti
set graph_PU=174
set /a col_PU=%random%%%20
set /a ligne_PU=%random%%%10

for /l %%a in (3,1,%z%) do if %col_PU%%ligne_PU%==!col%%a!!ligne%%a! goto :set_PU_Ralenti

if %col_PU% lss 1 goto :set_PU_Ralenti
if %ligne_PU% lss 1 goto :set_PU_Ralenti

goto :k2 

:Ralenti 
%son4%
set tpsPU=0 
set tpsPU2=40
set /a randPU=%random%%%200 
set PU=0 
set Ralenti=on 
set /a temps=%temps%+100 
set PU3=actif

goto :cadre 



:set_PU_Fantome
set PU=1
set PU2=Fantome
set graph_PU=64
set /a col_PU=%random%%%20
set /a ligne_PU=%random%%%10

for /l %%a in (3,1,%z%) do if %col_PU%%ligne_PU%==!col%%a!!ligne%%a! goto :set_PU_Fantome

if %col_PU% lss 1 goto :set_PU_Fantome 
if %ligne_PU% lss 1 goto :set_PU_Fantome 

goto :k2



:Fantome 
%son5%
set tpsPU=0 
set tpsPU2=40
set /a randPU=%random%%%200
set PU=0
set Fantome2=on
set PU3=actif

goto :cadre


:stopFantome
set PU=0 
set Fantome2=off
set tpsPU=0 
set tpsPU2=40
set PU3=inactif
goto :cadre

:stopRalenti
set /a temps=%temps%-100
set PU=0 
set Ralenti=off 
set PU3=inactif
set tpsPU=0 
set tpsPU2=40
goto :cadre

:haut
batbox /g %col% %ligne% /c 0x00 /d  /c 0x0f
if %ligne% gtr 1 set /a ligne=%ligne%-1
goto :cadre1

:bas
batbox /g %col% %ligne% /c 0x00 /d  /c 0x0f
if %ligne% lss 10 set /a ligne=%ligne%+1
goto :cadre1

:gauche
batbox /g %col% %ligne% /c 0x00 /d  /c 0x0f
if %col% gtr 1 set /a col=%col%-1
goto :cadre1

:droite
batbox /g %col% %ligne% /c 0x00 /d  /c 0x0f
if %col% lss 20 set /a col=%col%+1
goto :cadre1






:mort 
set act1=jouer 
if %lvl% geq %record% set /a record=%lvl%+1 & call :new_record
cls
echo ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»              
echo º                    º  
echo º                    º   Niveau %lvl%
echo º                    º  
echo º                    º  Ú       ¿
echo º                    º    
echo º                    º  À       Ù
echo º                    º   
echo º                    º    
echo º                    º   Menu [M]
echo º                    º
echo ÈÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍ¼  
echo     º            º
echo     ÈÍÍÍÍÍÍÍÍÍÍÍÍ¼
batbox /g 26 5 /c 0x0c /d %BAR% 
%son3%
batbox /g %col% %ligne% /c 0x0c /d X /c 0x0f 
batbox /g 6 12 /d "Record:%record%"
for /l %%a in (0,1,11) do (
	for /l %%b in (0,1,21) do batbox /g %%b %%a /a 178
	%son3%
	)

batbox /w 400
goto :mort1
:mort1
cls
echo ²²²²²²²²²²²²²²²²²²²²²²              
echo ²²²²²²²²²²²²²²²²²²²²²²  
echo ²²²²²²²²²²²²²²²²²²²²²²   Niveau %lvl%
echo ²²²²²²²²²²²²²²²²²²²²²²  
echo ²²²²²²²²²²²²²²²²²²²²²²  Ú       ¿
echo ²²²²²²²²²²²²²²²²²²²²²²    
echo ²²²²²²²²²²²²²²²²²²²²²²  À       Ù
echo ²²²²²²²²²²²²²²²²²²²²²²   
echo ²²²²²²²²²²²²²²²²²²²²²²  Recommencer? 
echo ²²²²²²²²²²²²²²²²²²²²²²     [O/N]
echo ²²²²²²²²²²²²²²²²²²²²²²
echo ²²²²²²²²²²²²²²²²²²²²²²  
echo     º            º
echo     ÈÍÍÍÍÍÍÍÍÍÍÍÍ¼
batbox /g 6 12 /d "Record:%record%"
batbox /g 2 5 /c 0xf0 /d "Vous etes mort..." /c 0x0f
batbox /g 26 5 /c 0x0c /d "%BAR%" /c 0x0f
batbox /k

if %errorlevel%==110 exit 
if %errorlevel%==111 set lvl=0 & cls & goto :menu
goto :mort1

:make_boom

( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%CD%\sons\Boom.wav"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >%CD%\sons\Boom.vbs

goto :eof

:make_levelup

( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%CD%\sons\levelUp.wav"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >%CD%\sons\LevelUp.vbs

goto :eof

:make_beep

( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%CD%\sons\beep.mp3"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >%CD%\sons\beep.vbs

goto :eof

:make_Fantome 

( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%CD%\sons\Fantome.wav"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >%CD%\sons\Fantome.vbs

goto :eof

:make_Ralenti

( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
  echo Sound.URL = "%CD%\sons\Ralenti.wav"
  echo Sound.Controls.play
  echo do while Sound.currentmedia.duration = 0
  echo wscript.sleep 100
  echo loop
  echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >%CD%\sons\Ralenti.vbs

goto :eof

:make_bb

for %%b in (

4d534346000000004f030000000000002c0000000000000003010100010000000000000047000000010001000006000000000000

0000a440c6b82000626174626f782e657865008699d03300030006434bb55441481461147ea36b90a6b3ac6e85118d90c7342b2f

b50b2bbb4b456b2eae5874b17177d69975776699fdb70c3a183b826950870e1eba88751582a2253a28061925d82108ebe0a1420b

128224249cde9b595d37043bd4db7dff7bef7befffdff7fff3cfb45f1a040e001ce004d304f05180e2839d6510b5e6d0d31a78b4

7bae21cf85e61aba642523a475ad4f1753425454558d09bd92a06755415185404744486931a9a9baf2f0c61ae1204088e3807bf8

b663035b049eabe2b82092024b499c5b94d8912d0328d0dd2c03c1c67b7e0194537a730eb7c9dbb9650f3e17c024f7179bfdc7d2

144f8a0c6dbda340c861f3de2a97e928feb3c8ebb53e48d846fe4ec3371c4cf72d827f98eebccb07136b14ac1682550c9616f0c8

064f35f3439fd0f1b74c8d94ef113cfdeca2a78f374670594f941df188bc31437e9c373e908df1c64fb229ded885d33c5779e30a

dae5711c96867148e02f62bac7b043d86c5db3884c61cfafb7133d88df4360688ad598eebb96c71bcc44710f63e4a593ca56d941

854937cb74df21aacda50b4f94d521585f0a4e2f3ab90a4a98adf668f77e8ebd979dd862e90b94b293bd2e2a30d05f5e59c78297

a50589e206e669915754f3006b22724b71e6634413fbcdd655abf01926ecc7c1c9bb2c16363e8b78ce4b09606fe2392fe5cab22f

72d57bc9c9792d937d32eaad44e7e6faf48af3c6677a95c76b302eafa074f842b77ca2d8d74b6cf6fdb125d3fd9a9836602e5741

37c1317a90cce881a1f78c9b49807d9e8d19688c9db4fed01885586df12e5dc777c9c078cc55c486d1cfbbb6bf7bed916e7f6757

532014023817ec3c1f0c1d3f664700ef70ce12ea1a6a1dae791435801a2af4db290f705a6211163b23aab1a4447144627e4dcd68

49a91dbf41a5489734c0da18d395de2c934a32feac9ed1f4b0965198a2a934ab53126385e459359d656d549f94a474c9bc809249

27c56b56abfbc86912358f3a8b3a8fba80fab1c075a73c405a57541627afa74f6251d9f2c84d898a2aea7d198ca5018559787faf

6c7b19a6332d59f0a2b2bedd57ee37

) Do>>t.dat (Echo.For b=1 To len^("%%b"^) Step 2

Echo WScript.StdOut.Write Chr^(Clng^("&H"^&Mid^("%%b",b,2^)^)^) : Next)

Cscript /b /e:vbs t.dat>batbox.ex_

Del /f /q /a t.dat>nul 2>&1

Expand -r batbox.ex_>nul 2>&1

Del /f /q /a batbox.ex_>nul 2>&1
