---
title: Authentication | Gengo API
---

# Authentication

API users must have a registered Gengo account to acquire a pair of keys - a public key (api_key), or token, and private key (private_key). The api_key is used to identify a user, and the private_key is used to authenticate each API call. The combination effectively functions as a username and password. Therefore you should keep the private_key (surprise, surprise!) private.

The keys are created and retrieved from your user Account section.

Every restricted (non public) REST call will need to be authenticated by Gengo. The process of making an authenticated request is simple, and is as follows:

## Signing Calls

All authenticated calls must be signed. The process for signing is as follows:

* Sort the argument list in alphabetical order by parameter name
example: "food=steak&cuisine=french&drink=wine" sorts to "cuisine=french&drink=wine&food=steak"
* Calculate the SHA1 hash of the parameters as a string
* Append the value of this hash to the argument list as a parameter named api_sig

## Example API authenticated call

    // submit a comment for job ID 20

    $params = array('body' => 'please use British spelling');

    // curl can't send nested arrays, only straight key-value pairs,
    // so 'data' must be flattened; we use json_encode()
    $params = array(
        'api_key' => 'kZ|G@SbBAjffh}!~%',
        '_method' => 'put',
        'data' => json_encode($params));

    // use your private_key to create an hmac
    $private_key = '$Z)YI=@ndYn@]zpu=AqOc=I}pGQZ';
    $hmac = hash_hmac('sha1', json_encode($params), $private_key);
    $params['api_sig'] = $hmac;
    $url = 'http://api.mygengo.com/v1/translate/job/20/comment'
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
    $response = curl_exect($ch); curl_close($ch);