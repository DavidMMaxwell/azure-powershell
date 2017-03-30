﻿using Microsoft.Azure.Commands.Network.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Microsoft.Azure.Commands.Network
{
    public static class ApplicationGatewayPowerShellFormatting
    {
        /// <summary>
        /// The size of the tab used to indent the output.
        /// </summary>
        private const int TabSize = 4;
        /// <summary>
        /// The maximum number of digits a ruleId can have (ruleId is at most 2^31 - 1)
        /// </summary>
        private const int MaxRuleIdLength = 10;
        /// <summary>
        /// The output format for a simple rule within the RuleGroup context.
        /// </summary>
        private const string RuleFormat = "{0}{1} {2}\n";

        public static string Format(PSApplicationGatewayFirewallRule rule, int depth = 0)
        {
            string prefix = new string(' ', depth * ApplicationGatewayPowerShellFormatting.TabSize);
            return string.Format(
                ApplicationGatewayPowerShellFormatting.RuleFormat, 
                prefix, 
                ApplicationGatewayPowerShellFormatting.NormalizeStringLength(Convert.ToString(rule.RuleId), ApplicationGatewayPowerShellFormatting.MaxRuleIdLength),
                rule.Description);
        }

        public static string Format(PSApplicationGatewayFirewallRuleGroup ruleGroup, int depth = 0)
        {
            string prefix = new string(' ', depth * ApplicationGatewayPowerShellFormatting.TabSize);
            StringBuilder output = new StringBuilder();

            output.AppendFormat("{0}{1}:\n", prefix, ruleGroup.RuleGroupName);

            depth++;
            prefix = new string(' ', depth * ApplicationGatewayPowerShellFormatting.TabSize);

            output.AppendFormat("{0}{1}\n", prefix, "Description:");

            depth++;
            prefix = new string(' ', depth * ApplicationGatewayPowerShellFormatting.TabSize);

            output.AppendFormat("{0}{1}\n", prefix, ruleGroup.Description);

            depth--;
            prefix = new string(' ', depth * ApplicationGatewayPowerShellFormatting.TabSize);

            output.AppendFormat("{0}{1}\n", prefix, "Rules:");

            depth++;
            prefix = new string(' ', depth * ApplicationGatewayPowerShellFormatting.TabSize);

            output.AppendFormat(
                ApplicationGatewayPowerShellFormatting.RuleFormat,
                prefix,
                ApplicationGatewayPowerShellFormatting.NormalizeStringLength("RuleId", ApplicationGatewayPowerShellFormatting.MaxRuleIdLength),
                "Description");
            output.AppendFormat(
                ApplicationGatewayPowerShellFormatting.RuleFormat,
                prefix,
                ApplicationGatewayPowerShellFormatting.NormalizeStringLength("------", ApplicationGatewayPowerShellFormatting.MaxRuleIdLength),
                "-----------");

            foreach (var rule in ruleGroup.Rules)
            {
                output.Append(ApplicationGatewayPowerShellFormatting.Format(rule, depth));
            }


            return output.ToString();
        }

        public static string Format(PSApplicationGatewayFirewallRuleSet ruleSet, int depth = 0)
        {
            string prefix = new string(' ', depth * ApplicationGatewayPowerShellFormatting.TabSize);
            StringBuilder output = new StringBuilder();

            output.AppendFormat("{0}{1} (Ver. {2}):\n", prefix, ruleSet.RuleSetType, ruleSet.RuleSetVersion);
            foreach (var ruleGroup in ruleSet.RuleGroups)
            {
                output.AppendLine();
                output.Append(ApplicationGatewayPowerShellFormatting.Format(ruleGroup, depth + 1));
            }


            return output.ToString();
        }

        public static string Format(PSApplicationGatewayAvailableWafRuleSetsResult availableWafRuleSets, int depth = 0)
        {
            string prefix = new string(' ', depth * ApplicationGatewayPowerShellFormatting.TabSize);
            StringBuilder output = new StringBuilder();

            foreach (var ruleSet in availableWafRuleSets.Value)
            {
                output.Append(ApplicationGatewayPowerShellFormatting.Format(ruleSet, depth));
                output.AppendLine();
            }


            return output.ToString();
        }

        private static string NormalizeStringLength(string value, int maxLength, char filling = ' ')
        {
            if (maxLength < 3) throw new ArgumentException("The size to normalize to must be at least 3.");

            if(string.IsNullOrEmpty(value))
            {
                return new string(filling, maxLength);
            }
            else if (value.Length < maxLength)
            {
                return value + new string(filling, maxLength - value.Length);
            }
            else if (value.Length > maxLength)
            {
                return value.Substring(0, maxLength - 2) + "..";
            }
            else
            {
                return value;
            }
        }
    }
}
