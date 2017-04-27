// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
// 
// Code generated by Microsoft (R) AutoRest Code Generator 0.16.0.0
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.

namespace Microsoft.Azure.Internal.Subscriptions.Models
{
    using System;
    using System.Linq;
    using System.Collections.Generic;
    using Newtonsoft.Json;
    using Microsoft.Rest;
    using Microsoft.Rest.Serialization;
    using Microsoft.Rest.Azure;

    /// <summary>
    /// Subscription information.
    /// </summary>
    public partial class Subscription
    {
        /// <summary>
        /// Initializes a new instance of the Subscription class.
        /// </summary>
        public Subscription() { }

        /// <summary>
        /// Initializes a new instance of the Subscription class.
        /// </summary>
        public Subscription(string id = default(string), string subscriptionId = default(string), string tenantId = default(string), string displayName = default(string), SubscriptionState? state = default(SubscriptionState?), SubscriptionPolicies subscriptionPolicies = default(SubscriptionPolicies), string authorizationSource = default(string))
        {
            Id = id;
            SubscriptionId = subscriptionId;
            TenantId = tenantId;
            DisplayName = displayName;
            State = state;
            SubscriptionPolicies = subscriptionPolicies;
            AuthorizationSource = authorizationSource;
        }

        /// <summary>
        /// The fully qualified ID for the subscription. For example,
        /// /subscriptions/00000000-0000-0000-0000-000000000000.
        /// </summary>
        [JsonProperty(PropertyName = "id")]
        public string Id { get; private set; }

        /// <summary>
        /// The subscription ID.
        /// </summary>
        [JsonProperty(PropertyName = "subscriptionId")]
        public string SubscriptionId { get; private set; }

        /// <summary>
        /// The tenant ID.
        /// </summary>
        [JsonProperty(PropertyName = "tenantId")]
        public string TenantId { get; private set; }

        /// <summary>
        /// The subscription display name.
        /// </summary>
        [JsonProperty(PropertyName = "displayName")]
        public string DisplayName { get; private set; }

        /// <summary>
        /// The subscription state. Possible values are Enabled, Warned,
        /// PastDue, Disabled, and Deleted. Possible values include:
        /// 'Enabled', 'Warned', 'PastDue', 'Disabled', 'Deleted'
        /// </summary>
        [JsonProperty(PropertyName = "state")]
        public SubscriptionState? State { get; private set; }

        /// <summary>
        /// The subscription policies.
        /// </summary>
        [JsonProperty(PropertyName = "subscriptionPolicies")]
        public SubscriptionPolicies SubscriptionPolicies { get; set; }

        /// <summary>
        /// The authorization source of the request. Valid values are one or
        /// more combinations of Legacy, RoleBased, Bypassed, Direct and
        /// Management. For example, 'Legacy, RoleBased'.
        /// </summary>
        [JsonProperty(PropertyName = "authorizationSource")]
        public string AuthorizationSource { get; set; }

    }
}
