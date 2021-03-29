$myMessage = "My message"
function Display-Message1($message){
    Write-Host $message
}
Display-Message1($myMessage)

function Display-Message2(){
    [String]$value1 = $args[0]
    [string]$value2 = $args[1]
    Write-Host $value1 $value2
}
Display-Message2 "Value1", "Value 2"
Display-Message2 "Value1"


function Display-Message3() {
    param (
        [Parameter(Mandatory=$true)]
        [String]$Text
    )
    Write-Host $Text
}
Display-Message3

function Display-Message4() {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("Lexus", "Porsche", "Toyota")]
        [String]$Text
    )
    Write-Host "I like to drive a " $Text
}
Display-Message4
Display-Message4 -Text Porsche

$a = 1
$b = 2
if($a -eq $b){ $message1 = "True" }
else { $message1 = "False"}

if($a -lt $b){ $message2 = "True" }
else { $message2 = "False"}

if($a -gt $b){ $message3 = "True" }
else { $message3 = "False"}

$message1
$message2
$message3

$messageObject = [PSCustomObject]@{
    "message1" = $message1 
    "message2" = $message2 
    "message3" = $message3
}
$messageObject.message2

# Ternary operators
$a = 3
$b = 2
$messageObject = [PSCustomObject]@{
    "message1" = (($a -lt $b) ? "True" : "False")
    "message2" = (($a -gt $b) ? "True" : "False")
    "message3" = (($a -eq $b) ? "True" : "False")
}
$messageObject
$messageObject.message1

# Switch statement
$input = Read-Host "Enter you brand new car: "
switch ($input) {
    Brand1 { "You typed: " + $input  }
    Brand2 { "You typed: " + $input }
    Default { "You did not type a brand" }
}

# Define custom help
function addThreeNumber() {
    param (
        # specify the number
        [Int32]$first,
        [Int32]$second,
        [Int32]$third
    )

    # calculate the result
    $result = $first + $second + $third

    # send result to the console
    Write-Host $first " + " $second " + " $third " = " $result
}
addThreeNumber -first 2 -second 3 -third 4
