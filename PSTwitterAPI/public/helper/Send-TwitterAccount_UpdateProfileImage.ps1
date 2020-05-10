﻿function Send-TwitterAccount_UpdateProfileImage {
<#
.SYNOPSIS
    Manage account settings and profile

.DESCRIPTION
    POST account/update_profile_image
    
    Updates the authenticating user's profile image. Note that this method expects raw multipart data, not a URL to an image.
    
    This method asynchronously processes the uploaded file before updating the user's profile image URL. You can either update your local cache the next time you request the user's information, or, at least 5 seconds after uploading the image, ask for the updated URL using GET users / show.

.PARAMETER image
    The avatar image for the profile, base64-encoded. Must be a valid GIF, JPG, or PNG image of less than 700 kilobytes in size. Images with width larger than 400 pixels will be scaled down. Animated GIFs will be converted to a static GIF of the first frame, removing the animation.

.PARAMETER include_entities
    The entities node will not be included when set to false .

.PARAMETER skip_status
    When set to either true , t or 1 statuses will not be included in the returned user objects.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/accounts-and-users/manage-account-settings/api-reference/post-account-update_profile_image

#>
    [CmdletBinding()]
    Param(
        [string]$image,
        [string]$include_entities,
        [string]$skip_status
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'POST'
        [string]$Resource    = '/account/update_profile_image'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/account/update_profile_image.json'

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
