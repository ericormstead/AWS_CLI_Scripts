# PowerShell script to list S3 buckets using AWS CLI

# Check if AWS CLI is installed
if (!(Get-Command aws -ErrorAction SilentlyContinue)) {
    Write-Host "AWS CLI is not installed or not in PATH. Please install AWS CLI and try again." -ForegroundColor Red
    exit
}

Write-Host "Listing all S3 buckets:" -ForegroundColor Green

try {
    # Use AWS CLI to list buckets
    $buckets = aws s3api list-buckets --query "Buckets[].Name" --output json | ConvertFrom-Json

    if ($buckets) {
        foreach ($bucket in $buckets) {
            Write-Host "Bucket Name: $bucket" -ForegroundColor Cyan
            
            # Optionally, get and display the creation date for each bucket
            $creationDate = aws s3api list-buckets --query "Buckets[?Name=='$bucket'].CreationDate" --output text
            Write-Host "Creation Date: $creationDate" -ForegroundColor Yellow
            Write-Host "-------------------------"
        }
    } else {
        Write-Host "No S3 buckets found." -ForegroundColor Yellow
    }
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
}

Write-Host "Listing complete." -ForegroundColor Green
Read-Host -Prompt "Press Enter to exit"
