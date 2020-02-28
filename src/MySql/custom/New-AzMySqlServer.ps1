
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------
<#
.Synopsis
Creates a new server or updates an existing server.
The update action will overwrite the existing server.
.Description
Creates a new server or updates an existing server.
The update action will overwrite the existing server.
.Example
To view examples, please use the -Online parameter with Get-Help or navigate to: https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlserver
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201Preview.IServer
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlserver
#>
function New-AzMySqlServer {
  [OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201Preview.IServer])]
  [CmdletBinding(DefaultParameterSetName='CreateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
  [Microsoft.Azure.PowerShell.Cmdlets.MySql.Profile('latest-2019-04-30')]
  param(
      [Parameter(Mandatory)]
      [Alias('ServerName')]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
      [System.String]
      # The name of the server.
      ${Name},
  
      [Parameter(Mandatory)]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
      [System.String]
      # The name of the resource group that contains the resource.
      # You can obtain this value from the Azure Resource Manager API or the portal.
      ${ResourceGroupName},
  
      [Parameter(Mandatory)]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
      [System.String]
      # The location the resource resides in.
      ${Location},

      [Parameter(Mandatory)]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
      [System.String]
      # The location the resource resides in.
      ${AdministratorLogin},

      [Parameter(Mandatory)]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
      [System.Security.SecureString]
      [ValidateNotNullOrEmpty()]
      # The location the resource resides in.
      ${AdministratorLoginPassword},
  
      [Parameter(Mandatory)]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
      [System.String]
      # The name of the sku, typically, tier + family + cores, e.g.
      # B_Gen4_1, GP_Gen5_8.
      ${SkuName},
  
      [Parameter()]
      [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SslEnforcementEnum])]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SslEnforcementEnum]
      # Enable ssl enforcement or not when connect to server.
      ${SslEnforcement},
  
      [Parameter(HelpMessage = "Backup retention days for the server. Day count is between 7 and 35.")]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
      [System.Int32]
      # Backup retention days for the server.
      # Day count is between 7 and 35.
      ${StorageProfileBackupRetentionDay},
  
      [Parameter()]
      [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.GeoRedundantBackup])]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.GeoRedundantBackup]
      # Enable Geo-redundant or not for server backup.
      ${StorageProfileGeoRedundantBackup},
  
      [Parameter()]
      [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.StorageAutogrow])]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.StorageAutogrow]
      # Enable Storage Auto Grow.
      ${StorageProfileStorageAutogrow},
  
      [Parameter()]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
      [System.Int32]
      # Max storage allowed for a server.
      ${StorageProfileStorageMb},
  
      [Parameter()]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.Info(PossibleTypes=([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201Preview.IServerForCreateTags]))]
      [System.Collections.Hashtable]
      # Application-specific metadata in the form of key-value pairs.
      ${Tag},
  
      [Parameter()]
      [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ServerVersion])]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ServerVersion]
      # Server version.
      ${Version},
  
      [Parameter()]
      [Alias('AzureRMContext', 'AzureCredential')]
      [ValidateNotNull()]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
      [System.Management.Automation.PSObject]
      # The credentials, account, tenant, and subscription used for communication with Azure.
      ${DefaultProfile},
  
      [Parameter()]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
      [System.Management.Automation.SwitchParameter]
      # Run the command as a job
      ${AsJob},
  
      [Parameter(DontShow)]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
      [System.Management.Automation.SwitchParameter]
      # Wait for .NET debugger to attach
      ${Break},
  
      [Parameter(DontShow)]
      [ValidateNotNull()]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
      # SendAsync Pipeline Steps to be appended to the front of the pipeline
      ${HttpPipelineAppend},
  
      [Parameter(DontShow)]
      [ValidateNotNull()]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
      # SendAsync Pipeline Steps to be prepended to the front of the pipeline
      ${HttpPipelinePrepend},
  
      [Parameter()]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
      [System.Management.Automation.SwitchParameter]
      # Run the command asynchronously
      ${NoWait},
  
      [Parameter(DontShow)]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
      [System.Uri]
      # The URI for the proxy server to use
      ${Proxy},
  
      [Parameter(DontShow)]
      [ValidateNotNull()]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
      [System.Management.Automation.PSCredential]
      # Credentials for a proxy server to use for the remote call
      ${ProxyCredential},
  
      [Parameter(DontShow)]
      [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
      [System.Management.Automation.SwitchParameter]
      # Use the default credentials for the proxy
      ${ProxyUseDefaultCredentials}
  )
  
  process {
      try {
        $Parameter = [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201Preview.ServerForCreate]::new()
        $Parameter.Property = [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201Preview.ServerPropertiesForDefaultCreate]::new()

        if ($PSBoundParameters.ContainsKey('Location')) {
            $Parameter.Location = $PSBoundParameters['Location']
            $PSBoundParameters.Remove('Location')
        }

        if ($PSBoundParameters.ContainsKey('Location')) {
            $Parameter.Location = $PSBoundParameters['Location']
            $PSBoundParameters.Remove('Location')
        }

        if ($PSBoundParameters.ContainsKey('SkuName')) {
            $Parameter.SkuName = $PSBoundParameters['SkuName']
            $PSBoundParameters.Remove('SkuName')
        }

        if ($PSBoundParameters.ContainsKey('SslEnforcement')) {
            $Parameter.SslEnforcement = $PSBoundParameters['SslEnforcement']
            $PSBoundParameters.Remove('SslEnforcement')
        }
        else
        {
            $Parameter.SslEnforcement = [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SslEnforcementEnum]::Enable
		}

        if ($PSBoundParameters.ContainsKey('StorageProfileBackupRetentionDay')) {
            $Parameter.StorageProfileBackupRetentionDay = $PSBoundParameters['StorageProfileBackupRetentionDay']
            $PSBoundParameters.Remove('StorageProfileBackupRetentionDay')
        }

        if ($PSBoundParameters.ContainsKey('StorageProfileGeoRedundantBackup')) {
            $Parameter.StorageProfileGeoRedundantBackup = $PSBoundParameters['StorageProfileGeoRedundantBackup']
            $PSBoundParameters.Remove('StorageProfileGeoRedundantBackup')
        }

        if ($PSBoundParameters.ContainsKey('StorageProfileStorageAutogrow')) {
            $Parameter.StorageProfileStorageAutogrow = $PSBoundParameters['StorageProfileStorageAutogrow']
            $PSBoundParameters.Remove('StorageProfileStorageAutogrow')
        }

        if ($PSBoundParameters.ContainsKey('StorageProfileStorageMb')) {
            $Parameter.StorageProfileStorageMb = $PSBoundParameters['StorageProfileStorageMb']
            $PSBoundParameters.Remove('StorageProfileStorageMb')
        }

        if ($PSBoundParameters.ContainsKey('Tag')) {
            $Parameter.Tag = $PSBoundParameters['Tag']
            $PSBoundParameters.Remove('Tag')
        }

        if ($PSBoundParameters.ContainsKey('Version')) {
            $Parameter.Version = $PSBoundParameters['Version']
            $PSBoundParameters.Remove('Version')
        }

        Write-Debug ($PSBoundParameters | Format-Table | Out-String)
        
        $Parameter.CreateMode = [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.CreateMode]::Default
           
        $Parameter.Property.AdministratorLogin = $PSBoundParameters['AdministratorLogin']
        $PSBoundParameters.Remove('AdministratorLogin')

        $Parameter.Property.AdministratorLoginPassword = [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($PSBoundParameters['AdministratorLoginPassword']))
        $PSBoundParameters.Remove('AdministratorLoginPassword')

        $PSBoundParameters.Add('Parameter', $Parameter)
        $PSBoundParameters.Add('SubscriptionId', (Get-AzContext).Subscription.Id)

        Write-Debug ($Parameter.Property | Format-Table | Out-String)
        Write-Debug ($Parameter | Format-Table | Out-String)
        Write-Debug ($PSBoundParameters | Format-Table | Out-String)

        Az.MySql.internal\New-AzMySqlServer @PSBoundParameters
      } catch {
          throw
      }
  }
  }
  
