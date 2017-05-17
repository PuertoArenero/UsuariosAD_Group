Import-Module ActiveDirectory
$CARPETA="c:\AD_usersgroups"
mkdir $CARPETA
$RUTA="$CARPETA\tmp.txt"
#Get-ADGroup -filter * -properties GroupCategory | ft name | Out-String > $RUTA
Get-ADGroup -Filter * | Select -ExpandProperty SamAccountName | Out-String > $RUTA
(get-content $RUTA) -notmatch "---" | out-file $RUTA
(get-content $RUTA) -notmatch "name" | out-file $RUTA
(get-content $RUTA) | where {$_ -ne ""} | out-file $RUTA
foreach ($NOMBREGRUPO in get-content $RUTA)
{
    #$NOMBREGRUPO = $NOMBREGRUPO -replace '[\W]', ''
    $NOMBREGRUPO = $NOMBREGRUPO -replace "`n|`r"
    $NOMBREGRUPO
    Get-ADGroupMember -identity $NOMBREGRUPO -recursive | select name,SamAccountName | Export-csv -path "$CARPETA\$NOMBREGRUPO.csv" -NoTypeInformation
}

#$NOMBREGRUPO = $NOMBREGRUPO -replace '[^\x30-\x39\x41-\x5A\x61-\x7A]+', ''
#$NOMBREGRUPO = $NOMBREGRUPO -replace "`n","" -replace "`r",""




