﻿function Send-TwitterMedia_Upload {
<#
.SYNOPSIS
    Upload media

.DESCRIPTION
    POST media/upload (INIT)
    
    Overview
    
    The INIT command request is used to initiate a file upload session. It returns a media_id which should be used to execute all subsequent requests. The next step after a successful return from INIT command is the APPEND command.
    
    See the Uploading media guide for constraints and requirements on media files.
    
    Request
    
    Requests should be either multipart/form-data or application/x-www-form-urlencoded POST formats.
    
    Note: The domain for this endpoint is upload.twitter.com
    
    Response
    
    The response provides a media identifier in the media_id (64-bit integer) and media_id_string (string) fields. Use the media_id_string provided in the API response from JavaScript and other languages that cannot accurately represent a long integer.
    
    The entire file must be uploaded before expires_after_secs seconds.
    
    The additional_owners field enables media to be uploaded media as user A and then used to create Tweets as user B.

.PARAMETER command
    Must be set to INIT (case sensitive).

.PARAMETER total_bytes
    The size of the media being uploaded in bytes.

.PARAMETER media_type
    The MIME type of the media being uploaded.

.PARAMETER media_category
    A string enum value which identifies a media usecase. This identifier is used to enforce usecase specific constraints (e.g. file size, video duration) and enable advanced features.

.PARAMETER additional_owners
    A comma-separated list of user IDs to set as additional owners allowed to use the returned media_id in Tweets or Cards. Up to 100 additional owners may be specified.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/media/upload-media/api-reference/post-media-upload-init

#>
    [CmdletBinding()]
    Param(
        [string]$command,
        [string]$total_bytes,
        [string]$media_type,
        [string]$media_category,
        [string]$additional_owners
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'POST'
        [string]$Resource    = '/media/upload'
        [string]$ResourceUrl = 'https://upload.twitter.com/1.1/media/upload.json'

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
