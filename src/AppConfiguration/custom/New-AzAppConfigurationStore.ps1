
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
Creates a configuration store with the specified parameters.
.Description
Creates a configuration store with the specified parameters.
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Models.Api20200601.IConfigurationStore
.Link
https://docs.microsoft.com/powershell/module/az.appconfiguration/new-azappconfigurationstore
.LINK
[New-AzUserAssignedIdentity](https://docs.microsoft.com/powershell/module/az.managedserviceidentity/new-azuserassignedidentity?view=azps-4.4.0)
#>
function New-AzAppConfigurationStore {
    [OutputType([Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Models.Api20200601.IConfigurationStore])]
    [CmdletBinding(DefaultParameterSetName = 'CreateExpanded', PositionalBinding = $false, SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Path')]
        [System.String]
        # The name of the configuration store.
        ${Name},

        [Parameter(Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Path')]
        [System.String]
        # The name of the resource group to which the container registry belongs.
        ${ResourceGroupName},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
        [System.String]
        # The Microsoft Azure subscription ID.
        ${SubscriptionId},

        [Parameter(Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Body')]
        [System.String]
        # The location of the resource.
        # This cannot be changed after the resource is created.
        ${Location},

        [Parameter(Mandatory)]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Body')]
        [System.String]
        # The SKU name of the configuration store.
        ${Sku},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Runtime.CompleterInfo(Script = "'None', 'SystemAssigned', 'UserAssigned', 'SystemAssignedAndUserAssigned'")]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Support.IdentityType]
        # The type of managed identity used.
        # The type 'SystemAssignedAndUserAssigned' includes both an implicitly created identity and a set of user-assigned identities.
        # The type 'None' will remove any identities.
        ${IdentityType},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Body')]
        [System.String]
        # The URI of the key vault key used to encrypt data.
        ${EncryptionKeyIdentifier},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Body')]
        [System.String]
        # The client id of the identity which will be used to access key vault.
        ${KeyVaultIdentityClientId},

        [Parameter()]
        [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Support.PublicNetworkAccess])]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Support.PublicNetworkAccess]
        # Control permission for data plane traffic coming from public networks while private endpoint is enabled.
        ${PublicNetworkAccess},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Body')]
        [System.String[]]
        # The list of user-assigned identities associated with the resource.
        # The user-assigned identity dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
        ${UserAssignedIdentity},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Runtime.Info(PossibleTypes=([Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Models.Api20200601.IResourceTags]))]
        [System.Collections.Hashtable]
        # The tags of the resource.
        ${Tag},

        [Parameter()]
        [Alias('AzureRMContext', 'AzureCredential')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Azure')]
        [System.Management.Automation.PSObject]
        # The credentials, account, tenant, and subscription used for communication with Azure.
        ${DefaultProfile},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Run the command as a job
        ${AsJob},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Wait for .NET debugger to attach
        ${Break},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be appended to the front of the pipeline
        ${HttpPipelineAppend},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be prepended to the front of the pipeline
        ${HttpPipelinePrepend},

        [Parameter()]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Run the command asynchronously
        ${NoWait},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Runtime')]
        [System.Uri]
        # The URI for the proxy server to use
        ${Proxy},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Runtime')]
        [System.Management.Automation.PSCredential]
        # Credentials for a proxy server to use for the remote call
        ${ProxyCredential},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.AppConfiguration.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Use the default credentials for the proxy
        ${ProxyUseDefaultCredentials}
    )

    process {
        # If user pass UserAssignedIdentity, transform it to a hashtable
        if ($PSBoundParameters.Remove('UserAssignedIdentity')) {
            $identityInHashtable = @{}
            foreach ($identity in $UserAssignedIdentity) {
                $identityInHashtable[$identity] = @{}
            }
            $PSBoundParameters.Add('UserAssignedIdentity', $identityInHashtable)
        }

        # IdentityType is an enum. But one of the options contains an "," causing PowerShell fail to parse it
        # So I changed the interface to use a non-comma version, but transform it back when passing to internal cmdlets
        if ($IdentityType -eq "SystemAssignedAndUserAssigned") {
            $PSBoundParameters['IdentityType'] = 'SystemAssigned, UserAssigned'
        }

        Az.AppConfiguration.internal\New-AzAppConfigurationStore @PSBoundParameters
    }
}
