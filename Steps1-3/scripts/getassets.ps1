param([String]$type)

if ($ENV:debug_log) {
    Start-Transcript -Path "./getassets.$type.log"
}

# Terraform provider sends in current state
# as a json object to stdin
$stdin = $input

# Vars
# 
# Databricks workspace endpoint
$assetsURL = @( "https://terraformlabcanadastats.blob.core.windows.net/notebooks/attach-ADLS.ipynb", "https://terraformlabcanadastats.blob.core.windows.net/notebooks/Check Secret Scopes.ipynb", "https://terraformlabcanadastats.blob.core.windows.net/notebooks/Check Secret Scopes.py") # $env:assets_url

function create {
    Write-Host  "Starting create"
    
    foreach($item in $assetsURL)
    {
        $file = "assets/" + (Split-Path -leaf $item)
        $response = Invoke-WebRequest $item -OutFile $file

        test-response 
    }

    Write-Host "Done"
}

function read {
    Write-Host  "Starting read"
    delete
    create
}

function update {
    Write-Host  "Starting update (calls delete then create)"
    delete
    create
}

function delete {
    Write-Host  "Starting delete"

    Write-Host  "Nothing to do here."
}

function test-response() {
    $file = "assets/" + (Split-Path -leaf $assetsURL[0])
    if ((Test-path $file) -eq $false)
    {
        Write-Error "Download failed."
        exit 1
    }
}


Switch ($type) {
    "create" { create }
    "read" { read }
    "update" { update }
    "delete" { delete }
}