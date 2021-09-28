Clear-Host

################ VARIABLES & FUNCTIONS #################

$tabGame = @()
$dices = 0, 0
$total = 0
$tours = 0
$NbPlayer = 0
function Game-Display {
	Write-Host "Name`t| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |`tscore "
	Write-Host "__________________________________________________"
	for($i = 0; $i -lt $NbPlayer; $i++){
		Write-Host $tabGame[$i].Name "`t|" $tabGame[$i].tab[$i] "|" $tabGame[$i].tab[1] "|" $tabGame[$i].tab[2] "|" $tabGame[$i].tab[3] "|" $tabGame[$i].tab[4] "|" $tabGame[$i].tab[5] "|" $tabGame[$i].tab[6] "|" $tabGame[$i].tab[7] "|" $tabGame[$i].tab[8] "|`t" $tabGame[$i].score
	}
}

######################### START #########################

Write-Host "Welcome to Shut the Box"

#################### INITIALISATION ####################

do{
	$NbPlayer = Read-Host "Please enter the number of players (2 - 6)"
}while (-not ($NbPlayer -ge 2 -and $NbPlayer -le 6))

for($i = 0; $i -lt $NbPlayer; $i++) {
	$name = Read-Host "Enter name of player" ($i+1)
	$tabGame += New-Object -TypeName psobject -Property @{Name=$name; tab = 0, 0, 0, 0, 0, 0, 0, 0, 0; score = 0}
}

####################      GAME      ####################

$gameEnd = 0

while (!$gameEnd){
	Clear-Host

	Game-Display

	$player = ($tours % $NbPlayer)
	Write-Host $tabGame[$player].name "a toi !"

	$dices[0] = Get-Random -Minimum 1 -Maximum 9
	$dices[1] = Get-Random -Minimum 1 -Maximum 9

	Write-Host $dices "=" ($dices[0]+$dices[1])
	do {
		$numbers = Read-Host "Which numbers do you want to play (separate with space) "
		$numbers = $numbers.Split()
		$total = 0;
		foreach ($nb in $numbers){
			$total += $nb
		}
	}while(-not ($dices[0]+$dices[1] -eq $total))
	
	foreach ($nb in $numbers){
		if($nb -gt 0 -and  ($nb-1) -lt 10){
			$tabGame[$player].tab[($nb-1)] = "\"
		}
	}
	$total = 0
	for($i = 0; $i -lt $tabGame[$player].tab.length; $i++){
		if( $nb -eq 0){
			$total += $i
		}
	}
	$tabGame[$player].score = $total

	$tours++;
}