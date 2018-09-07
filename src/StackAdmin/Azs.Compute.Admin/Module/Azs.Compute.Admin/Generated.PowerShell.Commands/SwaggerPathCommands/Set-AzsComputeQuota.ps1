<#
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the MIT License. See License.txt in the project root for license information.

Code generated by Microsoft (R) PSSwagger
Changes may cause incorrect behavior and will be lost if the code is regenerated.
#>

<#
.SYNOPSIS
    Update an existing compute quota using the provided parameters.

.DESCRIPTION
    Update an existing compute quota.

.PARAMETER Name
    The name of the quota.

.PARAMETER Location
    Location of the resource.

.PARAMETER AvailabilitySetCount
    Number of availability sets allowed.

.PARAMETER CoresCount
    Number of cores allowed.

.PARAMETER VmScaleSetCount
    Number of scale sets allowed.

.PARAMETER VirtualMachineCount
    Number of virtual machines allowed.

.PARAMETER StandardManagedDiskAndSnapshotSize
    Size for standard managed disks and snapshots allowed.

.PARAMETER PremiumManagedDiskAndSnapshotSize
    Size for standard managed disks and snapshots allowed.

.PARAMETER ResourceId
    The ARM compute quota id.

.PARAMETER InputObject
    Possibly modified compute quota returned form Get-AzsComputeQuota.

.EXAMPLE

    PS C:\> Set-AzsComputeQuota -Name Quota1 -VmScaleSetCount 20

    Update a compute quota.

#>
function Set-AzsComputeQuota {
    [OutputType([ComputeQuotaObject])]
    [CmdletBinding(DefaultParameterSetName = 'Update', SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Update')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $Name,

        [Parameter(Mandatory = $false)]
        [int32]
        $AvailabilitySetCount,

        [Alias("CoresLimit")]
        [Parameter(Mandatory = $false)]
        [int32]
        $CoresCount,

        [Parameter(Mandatory = $false)]
        [int32]
        $VmScaleSetCount,

        [Parameter(Mandatory = $false)]
        [int32]
        $VirtualMachineCount,

        [Parameter(Mandatory = $false)]
        [int32]
        $StandardManagedDiskAndSnapshotSize,

        [Parameter(Mandatory = $false)]
        [int32]
        $PremiumManagedDiskAndSnapshotSize,

        [Parameter(Mandatory = $false)]
        [System.String]
        $Location,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ResourceId')]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $ResourceId,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'InputObject')]
        [ValidateNotNullOrEmpty()]
        [ComputeQuotaObject]
        $InputObject
    )

    Begin {
        Initialize-PSSwaggerDependencies -Azure
        $tracerObject = $null
        if (('continue' -eq $DebugPreference) -or ('inquire' -eq $DebugPreference)) {
            $oldDebugPreference = $global:DebugPreference
            $global:DebugPreference = "continue"
            $tracerObject = New-PSSwaggerClientTracing
            Register-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }

    Process {
        # Breaking changes message
        if ($PSBoundParameters.ContainsKey('CoresCount')) {
            if ( $MyInvocation.Line -match "\s-CoresLimit\s") {
                Write-Warning -Message "The parameter alias CoresLimit will be deprecated in future release. Please use the parameter CoresCount instead"
            }
        }
        [ComputeQuotaObject]$QuotaObject = $null

        if ('InputObject' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {
            $GetArmResourceIdParameterValue_params = @{
                IdTemplate = '/subscriptions/{subscriptionId}/providers/Microsoft.Compute.Admin/locations/{location}/quotas/{quotaName}'
            }

            if ('ResourceId' -eq $PsCmdlet.ParameterSetName) {
                $GetArmResourceIdParameterValue_params['Id'] = $ResourceId
            } else {
                $GetArmResourceIdParameterValue_params['Id'] = $InputObject.Id
                $QuotaObject = $InputObject
            }
            $ArmResourceIdParameterValues = Get-ArmResourceIdParameterValue @GetArmResourceIdParameterValue_params

            $Location = $ArmResourceIdParameterValues['location']
            $Name = $ArmResourceIdParameterValues['quotaName']
        } else {
            $Name = Get-ResourceNameSuffix -ResourceName $Name
        }

        if ($PSCmdlet.ShouldProcess("$Name" , "Update compute quota")) {

            $NewServiceClient_params = @{
                FullClientTypeName = 'Microsoft.AzureStack.Management.Compute.Admin.ComputeAdminClient'
            }

            $GlobalParameterHashtable = @{}
            $NewServiceClient_params['GlobalParameterHashtable'] = $GlobalParameterHashtable

            $GlobalParameterHashtable['SubscriptionId'] = $null
            if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
                $GlobalParameterHashtable['SubscriptionId'] = $PSBoundParameters['SubscriptionId']
            }

            $ComputeAdminClient = New-ServiceClient @NewServiceClient_params

            if ([System.String]::IsNullOrEmpty($Location)) {
                $Location = (Get-AzureRMLocation).Location
            }

            if ('Update' -eq $PsCmdlet.ParameterSetName -or 'InputObject' -eq $PsCmdlet.ParameterSetName -or 'ResourceId' -eq $PsCmdlet.ParameterSetName) {

                if ($null -eq $QuotaObject) {
                    $QuotaObject = Get-AzsComputeQuota -Location $Location -Name $Name
                }

                # Update the Quota object from anything passed in
                $flattenedParameters = @('AvailabilitySetCount', 'CoresCount', 'VmScaleSetCount', 'VirtualMachineCount', 'StandardManagedDiskAndSnapshotSize', 'PremiumManagedDiskAndSnapshotSize' )
                $flattenedParameters | ForEach-Object {
                    if ($PSBoundParameters.ContainsKey($_)) {
                        $NewValue = $PSBoundParameters[$_]
                        if ($null -ne $NewValue) {
                            if($_ -eq 'CoresCount') {
                                $_ = 'CoresLimit'
                            }
                            $QuotaObject.$_ = $NewValue
                        }
                    }
                }
                $sdkObject = ConvertTo-SdkQuota -CustomQuota $QuotaObject

                Write-Verbose -Message 'Performing operation update on $ComputeAdminClient.'
                $TaskResult = $ComputeAdminClient.Quotas.CreateOrUpdateWithHttpMessagesAsync($Location, $Name, $sdkObject)
            } else {
                Write-Verbose -Message 'Failed to map parameter set to operation method.'
                throw 'Module failed to find operation to execute.'
            }

            if ($TaskResult) {
                $GetTaskResult_params = @{
                    TaskResult = $TaskResult
                }
                ConvertTo-ComputeQuota -Quota (Get-TaskResult @GetTaskResult_params)
            }
        }
    }

    End {
        if ($tracerObject) {
            $global:DebugPreference = $oldDebugPreference
            Unregister-PSSwaggerClientTracing -TracerObject $tracerObject
        }
    }
}

