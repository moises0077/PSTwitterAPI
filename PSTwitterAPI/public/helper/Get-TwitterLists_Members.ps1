﻿function Get-TwitterLists_Members {
<#
.SYNOPSIS
    Create and manage lists

.DESCRIPTION
    GET lists/members
    
    members/*
    
    Returns the members of the specified list. Private list members will only be shown if the authenticated user owns the specified list.

.PARAMETER list_id
    The numerical id of the list.

.PARAMETER slug
    You can identify a list by its slug instead of its numerical id. If you decide to do so, note that you'll also have to specify the list owner using the owner_id or owner_screen_name parameters.

.PARAMETER owner_screen_name
    The screen name of the user who owns the list being requested by a slug.

.PARAMETER owner_id
    The user ID of the user who owns the list being requested by a slug.

.PARAMETER count
    Specifies the number of results to return per page (see cursor below). The default is 20, with a maximum of 5,000.

.PARAMETER cursor
    Causes the collection of list members to be broken into "pages" of consistent sizes (specified by the count parameter). If no cursor is provided, a value of -1 will be assumed, which is the first "page."

.PARAMETER The response from the API will include a previous_cursor and next_cursor to allow paging back and forth. See Using cursors to navigate collections for more information.
    12893764510938

.PARAMETER include_entities
    The entities node will not be included when set to false.

.PARAMETER skip_status
    When set to either true, t or 1 statuses will not be included in the returned user objects.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/accounts-and-users/create-manage-lists/api-reference/get-lists-members

#>
    [CmdletBinding()]
    Param(
        [string]$list_id,
        [string]$slug,
        [string]$owner_screen_name,
        [string]$owner_id,
        [string]$count,
        [string]$cursor,
        [string]$The,
        [string]$include_entities,
        [string]$skip_status
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/lists/members'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/lists/members.json'

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
