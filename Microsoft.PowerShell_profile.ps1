#=======================================================================================================
#                                    Powershell Profile
#                               - borrowed from many sources
#=======================================================================================================
#=======================================================================================================
# CD
#=======================================================================================================
cd C:\
#=======================================================================================================
# LS.MSH 
# Colorized LS function replacement 
# /\/\o\/\/ 2006 
# http://mow001.blogspot.com 
#=======================================================================================================
function LL
{
    param ($dir = ".", $all = $false) 

    $origFg = $host.ui.rawui.foregroundColor 
    if ( $all ) { $toList = ls -force $dir }
    else { $toList = ls $dir }

    foreach ($Item in $toList)  
    { 
        Switch ($Item.Extension)  
        { 
            ".Exe" {$host.ui.rawui.foregroundColor = "Green"} 
            ".cmd" {$host.ui.rawui.foregroundColor = "Red"} 
            ".msh" {$host.ui.rawui.foregroundColor = "Red"} 
            ".vbs" {$host.ui.rawui.foregroundColor = "Red"} 
            ".Zip" {$host.ui.rawui.foregroundColor = "Red"}
            ".Png" {$host.ui.rawui.foregroundColor = "Magenta"}
            ".Jpg" {$host.ui.rawui.foregroundColor = "Magenta"}
            Default {$host.ui.rawui.foregroundColor = $origFg} 
        } 
        if ($item.Mode.StartsWith("d")) {$host.ui.rawui.foregroundColor = "Cyan"}
        $item 
    }  
    $host.ui.rawui.foregroundColor = $origFg 
}

function lla
{
    param ( $dir=".")
    ll $dir $true
}

function la { ls -force }
#=======================================================================================================
# Current time and directory location
#=======================================================================================================
function Get-Time { return $(get-date | foreach { $_.ToLongTimeString() } ) }
function prompt
{
    # Write the time 
    write-host "[" -noNewLine
    write-host $(Get-Time) -foreground yellow -noNewLine
    write-host "] " -noNewLine
    # Write the path
    write-host $($(Get-Location).Path.replace($home,"~").replace("\","/")) -foreground green -noNewLine
    write-host $(if ($nestedpromptlevel -ge 1) { '>>' }) -noNewLine
    return "> "
}
#=======================================================================================================
# Clear shell
#=======================================================================================================
clear-host
#=======================================================================================================
# Learn something... Get random command upon opening shell 
#=======================================================================================================
Get-Command | Get-Random | Get-Help -Full