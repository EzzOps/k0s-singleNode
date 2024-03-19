$organization = "banquemisr-digitalfactory"
$project = "DevOpsRepo"
# $pipelineId = "260628"
$runId = "1446"

# Trigger pipeline and retrieve latest run ID

$pipelineId = (az pipelines run --project DevOpsRepo --id 1446 --parameters ImageToScan=alpine | ConvertFrom-Json).id
Write-Output $pipelineId
Write-Output "Before loop"

while ($true) {
# This code retrieves the status of the build 
$status = (az pipelines build show --id $pipelineId --project $project --output json | ConvertFrom-Json).status
Write-Output $status
if ($status -eq "completed") {
    break
  }
  Start-Sleep -Seconds 10
}

Write-Output "After loop"


# Retrieve log IDs after pipeline completion
$topLogId = (az devops invoke --area pipelines --resource logs --route-parameters project=$project pipelineId=$runId  runId=$pipelineId --api-version=7.0 | ConvertFrom-Json).Logs | Sort-Object -Property lastChangedOn -Descending | Select-Object -First 3 | Sort-Object -Property lineCount -Descending | Select-Object -First 1 | Select-Object -ExpandProperty id
# Write the top log ID for verification (optional)
Write-Output $topLogId

# Get the build log using the topLogId, filtering for errors (if Value property contains logs)
$buildLog = (az devops invoke  --area build --resource logs --route-parameters project=$project buildId=$pipelineId logId=$topLogId --api-version=7.0 --only-show-errors | ConvertFrom-Json).Value

Write-Output $buildLog







# Get the top log ID with most lines (assuming "logs" property contains lines)
# $topLogId = (az devops invoke --area pipelines --resource logs --route-parameters project=$project runId=260628 --api-version=7.0 | ConvertFrom-Json).logs | 
#     Sort-Object LastChangedOn -Descending | 
#     Select-Object -First 3 | 
#     Sort-Object -Property logs.count -Descending |  # Sort by "count" property within "logs" object
#     Select-Object -First 1 | 
#     Select-Object -ExpandProperty id