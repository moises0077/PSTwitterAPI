﻿function Send-TwitterDirectMessages_IndicateTyping {
<#
.SYNOPSIS
    Typing indicator and read receipts

.DESCRIPTION
    POST direct_messages/indicate_typing
    
    Displays a visual typing indicator in the recipient’s Direct Message conversation view with the sender. Each request triggers a typing indicator animation with a duration of ~3 seconds.
    
    Usage
    
    A rudimentary approach would be to invoke an API request on every keypress or input event, however the application may quickly hit rate limits. A more sophisticated approach is to capture input events, but limit API requests to a specified interval based on the behavior of your users and the rate limit specified below.

.PARAMETER recipient_id (required)
    

.PARAMETER 204
    

.PARAMETER 400
    

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/direct-messages/typing-indicator-and-read-receipts/api-reference/new-typing-indicator

#>
    [CmdletBinding()]
    Param(
        [string]$recipient_id,
        [string]$204,
        [string]$400
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'POST'
        [string]$Resource    = '/direct_messages/indicate_typing'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/direct_messages/indicate_typing.json'

    }
    Process {

        # Find & Replace any ResourceUrl parameters.
        $UrlParameters = [regex]::Matches($ResourceUrl, '(?<!\w):\w+')
        ForEach ($UrlParameter in $UrlParameters) {
            $UrlParameterValue = $Parameters["$($UrlParameter.Value.TrimStart(":"))"]
            $ResourceUrl = $ResourceUrl -Replace $UrlParameter.Value, $UrlParameterValue
        }

        $OAuthSettings = Get-TwitterOAuthSettings -Resource $Resource
        Invoke-TwitterAPI -Method $Method -ResourceUrl $ResourceUrl -Parameters $Parameters -OAuthSettings $OAuthSettings

    }
    End {

    }
}
