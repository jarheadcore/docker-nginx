Security headers
================

The following security headers are activated through the file `/data/conf/nginx/security-headers.d/00-security-headers.conf`.

If you want or need to overwrite one of the headers, mount your own security-headers config into that directory, with a name coming after `00-security-headers.conf` in the alphabet.


| Header                    | Value                                   | Overwrite this, if...                                                                                                                                                                         |
| --------------------------- | ----------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| X-Content-Type-Options    | nosniff                                 |                                                                                                                                                                                               |
| X-Frame-Options           | SAMEORIGIN                              | you want to allow other users to integrate your site into an iFrame                                                                                                                           |
| Referrer-Policy           | strict-origin-when-cross-origin         |                                                                                                                                                                                               |
| Allow                     | "GET POST PUT DELETE" always            | you want to allow additional HTTP methods (e.g. HEAD, OPTIONS, PATCH, ...)                                                                                                                    |
| Strict-Transport-Security | "max-age=31536000; includeSubDomains"   |                                                                                                                                                                                               |
| *Permissions-Policy*      | **NONE** -- please set this in your own | you want to allow special browser features like geolocation, camera or microphone accesss, ...<br />If you want to get good ratings on pen testing, set this on your own with a good default. |
| *Content-Security-Policy* | **NONE** -- please set this in your own | you want to get better ratings in penetration tests.<br />This header can be quite tricky to configure.                                                                                       |

Additionally:

`if ( $request_method !~ ^(GET|POST|PUT|DELETE)$ ) { return 405; }`

Overwrite this one if you also need to change the "Allow" header.

## Extending and overriding

Create a `01-site-headers.conf` and place it in `/data/conf/nginx/security-headers.d/01-site-headers.conf` (through Docker file mounting).

Inside it you can enable site specific security headers, like a default Permissions-Policy and a default CSP:

If you want to override the default headers (00-security-headers.conf) you are maybe forced to overwrite the whole file because nginx `add_header` config has no duplication check. Two "add_header" with the same header will output the header two times.

## Permissions-Policy

Permissions-Policy is the successor of the Feature-Policy header. Unfortunately it is a blacklist and not a whitelist. You need to explicitly disable the features you don't need. This is a pain in the ass, because all browsers support different features, and some output a info/debug message if they don't understand some features. It won't hurt your website, though.

This is also relevant when implementing content in iFrames - you can use the permissions policy to restrict which features iFrames can use.

See: https://developer.chrome.com/docs/privacy-sandbox/permissions-policy/

Here is a list with permissions not throwing a message in Chrome 100 (currently). You can find this list here: https://github.com/w3c/webappsec-permissions-policy/blob/main/features.md.

Default implementation for denying all these features:

`add_header Permissions-Policy "accelerometer=(), autoplay=(), camera=(), cross-origin-isolated=(), display-capture=(), document-domain=(), encrypted-media=(), fullscreen=(), geolocation=(), gyroscope=(), keyboard-map=(), magnetometer=(), microphone=(), midi=(), payment=(), picture-in-picture=(), publickey-credentials-get=(), screen-wake-lock=(), sync-xhr=(), usb=(), xr-spatial-tracking=(), clipboard-read=(), clipboard-write=(), hid=(), window-placement=()";`

If you want to allow your site to access e.g. the camera, you need to enable it with: `camera=(self)`


| Permission                | May be needed                 |
| --------------------------- | ------------------------------- |
| accelerometer             |                               |
| autoplay                  |                               |
| camera                    | x                             |
| cross-origin-isolated     |                               |
| display-capture           |                               |
| document-domain           |                               |
| encrypted-media           |                               |
| fullscreen                | x                             |
| geolocation               | x                             |
| gyroscope                 |                               |
| keyboard-map              |                               |
| magnetometer              |                               |
| microphone                | x                             |
| midi                      |                               |
| payment                   |                               |
| picture-in-picture        |                               |
| publickey-credentials-get |                               |
| screen-wake-lock          |                               |
| sync-xhr                  |                               |
| usb                       |                               |
| xr-spatial-tracking       |                               |
| clipboard-read            | x                             |
| clipboard-write           | x                             |
| hid                       |                               |
| ~~interest-cohort~~       | (not yet supported by Chrome) |
| window-placement          |                               |

## Content-Security-Policy

The CSP is tricky to configure, especially if you integrate external resources like advertising, tracking tools, iFrames, images, fonts, form endpoints ...

Here is a good starting point for your own CSP. It allows inline-css which may be difficult to get rid off.

`add_header Content-Security-Policy "default-src 'none'; script-src 'self'; connect-src 'self'; img-src 'self'; manifest-src 'self'; style-src 'self' 'unsafe-inline'; font-src 'self'; base-uri 'self'; form-action 'self'; frame-ancestors 'none';"; `
