


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

# API endpoint
$apiUrl = "https://kelpom-imei-checker1.p.rapidapi.com/api?service=model&imei=$IMEI"

# Headers
$headers = @{}
$headers.Add("x-rapidapi-key", "c262b18e58mshd2cd04ceabbd3ecp1d139ejsn8b225628eb3a")
$headers.Add("x-rapidapi-host", "kelpom-imei-checker1.p.rapidapi.com")

try {
    # Send the HTTP GET request
    $response = Invoke-WebRequest -Uri $apiUrl -Method GET -Headers $headers -ErrorAction Stop

    # Parse and display the JSON response
    $json = $response.Content | ConvertFrom-Json
    Write-Host "`nPhone Information for IMEI ${IMEI}:`n"
    $json | Format-List
}
catch {
    Write-Error "Failed to retrieve IMEI info: $_"
}
