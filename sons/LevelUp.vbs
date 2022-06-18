Set Sound = CreateObject("WMPlayer.OCX.7")
Sound.URL = "G:\batch\projets_termines\MineField\Minefield_[Updates]\sons\levelUp.wav"
Sound.Controls.play
do while Sound.currentmedia.duration = 0
wscript.sleep 100
loop
wscript.sleep (int(Sound.currentmedia.duration)+1)*1000
