﻿// ----------------------------------------------------------------------------------
//
// Copyright Microsoft Corporation
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ----------------------------------------------------------------------------------

using Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters;
using Microsoft.Azure.Commands.StorageSync.Common;
using Microsoft.Azure.Commands.StorageSync.Common.ArgumentCompleters;
using Microsoft.Azure.Commands.StorageSync.Common.Extensions;
using Microsoft.Azure.Commands.StorageSync.Models;
using Microsoft.Azure.Management.Internal.Resources.Utilities.Models;
using Microsoft.Azure.Management.StorageSync;
using System.Management.Automation;

namespace Microsoft.Azure.Commands.StorageSync.CloudEndpoint
{
    [Cmdlet(VerbsCommon.Get, StorageSyncNouns.NounAzureRmStorageSyncCloudEndpoint, DefaultParameterSetName = StorageSyncParameterSets.StringParameterSet), OutputType(typeof(PSCloudEndpoint))]
    public class GetCloudEndpointCommand : StorageSyncClientCmdletBase
    {
        [Parameter(
           Position = 0,
            ParameterSetName = StorageSyncParameterSets.StringParameterSet,
           Mandatory = true,
           ValueFromPipelineByPropertyName = true,
           HelpMessage = HelpMessages.ResourceGroupNameParameter)]
        [ResourceGroupCompleter]
        [ValidateNotNullOrEmpty]
        public string ResourceGroupName { get; set; }

        [Parameter(
             Position = 1,
             ParameterSetName = StorageSyncParameterSets.StringParameterSet,
             Mandatory = true,
             ValueFromPipelineByPropertyName = true,
             HelpMessage = HelpMessages.StorageSyncServiceNameParameter)]
        [StorageSyncServiceCompleter]
        [ValidateNotNullOrEmpty]
        [Alias(StorageSyncAliases.ParentNameAlias)]
        public string StorageSyncServiceName { get; set; }

        [Parameter(
            Position = 2,
            ParameterSetName = StorageSyncParameterSets.StringParameterSet,
            Mandatory = true,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = HelpMessages.SyncGroupNameParameter)]
        [ValidateNotNullOrEmpty]
        public string SyncGroupName { get; set; }


        [Parameter(
           Position = 0,
           ParameterSetName = StorageSyncParameterSets.ObjectParameterSet,
           Mandatory = true,
           ValueFromPipeline = true,
           HelpMessage = HelpMessages.StorageSyncServiceObjectParameter)]
        [ValidateNotNullOrEmpty]
        [Alias(StorageSyncAliases.SyncGroupAlias)]
        public PSSyncGroup ParentObject { get; set; }

        [Parameter(
          Position = 0,
          ParameterSetName = StorageSyncParameterSets.ParentStringParameterSet,
          Mandatory = true,
          ValueFromPipelineByPropertyName = true,
          HelpMessage = HelpMessages.StorageSyncServiceObjectParameter)]
        [ValidateNotNullOrEmpty]
        [Alias(StorageSyncAliases.SyncGroupIdAlias)]
        public string ParentResourceId { get; set; }

        [Parameter(Mandatory = false,
            ValueFromPipelineByPropertyName = true,
            HelpMessage = HelpMessages.CloudEndpointNameParameter)]
        [ValidateNotNullOrEmpty]
        [Alias(StorageSyncAliases.CloudEndpointNameAlias)]
        public string Name { get; set; }

        public override void ExecuteCmdlet()
        {
            base.ExecuteCmdlet();

            ExecuteClientAction(() =>
            {
                var parentResourceIdentifier = default(ResourceIdentifier);

                if (!string.IsNullOrEmpty(ParentResourceId))
                {
                    parentResourceIdentifier = new ResourceIdentifier(ParentResourceId);

                    if (!string.Equals(StorageSyncConstants.SyncGroupType, parentResourceIdentifier.ResourceType, System.StringComparison.OrdinalIgnoreCase))
                    {
                        throw new PSArgumentException(nameof(ParentResourceId));
                    }
                }

                string resourceGroupName = ResourceGroupName ?? ParentObject?.ResourceGroupName ?? parentResourceIdentifier.ResourceGroupName;
                string storageSyncServiceName = StorageSyncServiceName ?? ParentObject?.StorageSyncServiceName ?? parentResourceIdentifier.GetParentResourceName(StorageSyncConstants.StorageSyncServiceTypeName, 0);
                string parentResourceName = SyncGroupName ?? ParentObject?.SyncGroupName ?? parentResourceIdentifier.ResourceName;

                if (string.IsNullOrEmpty(resourceGroupName))
                {
                    throw new PSArgumentException(nameof(ResourceGroupName));
                }
                if (string.IsNullOrEmpty(parentResourceName))
                {
                    throw new PSArgumentException(nameof(SyncGroupName));
                }

                if (string.IsNullOrEmpty(storageSyncServiceName))
                {
                    throw new PSArgumentException(nameof(StorageSyncServiceName));
                }

                if (string.IsNullOrEmpty(Name))
                {
                    WriteObject(StorageSyncClientWrapper.StorageSyncManagementClient.CloudEndpoints.ListBySyncGroup(resourceGroupName, storageSyncServiceName, parentResourceName));
                }
                else
                {
                    WriteObject(StorageSyncClientWrapper.StorageSyncManagementClient.CloudEndpoints.Get(resourceGroupName, storageSyncServiceName, parentResourceName, Name));
                }
            });
        }
    }
}
