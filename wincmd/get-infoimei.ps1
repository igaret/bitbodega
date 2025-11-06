param (
    [string]$IMEI
)

# Prompt for IMEI if not provided
if (-not $IMEI) {
    $IMEI = Read-Host "Enter the IMEI number"
}

# Basic IMEI format check
if ($IMEI -notmatch '^\d{15}$') {
    Write-Error "Invalid IMEI format. Must be exactly 15 digits."
    exit 1
}

# API key and host
$apiKey = "c262b18e58mshd2cd04ceabbd3ecp1d139ejsn8b225628eb3a"
$apiHost = "kelpom-imei-checker1.p.rapidapi.com"

# Common headers
$headers = @{
    "x-rapidapi-key" = $apiKey
    "x-rapidapi-host" = $apiHost
}

# Services to query
$services = @("model", "blacklist", "carrier")

foreach ($service in $services) {
    Write-Host "`n--- $service Check ---`n" -ForegroundColor Cyan

    $url = "https://$apiHost/api?service=$service&imei=$IMEI"

    try {
        $response = Invoke-WebRequest -Uri $url -Method GET -Headers $headers -ErrorAction Stop
        $json = $response.Content | ConvertFrom-Json
        $json | Format-List
    }
    catch {
        Write-Warning "Failed to retrieve $service info: $_"
    }
}
