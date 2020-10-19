# convert certificate

Converts certificate to *.dart the binary file.

## Description

The utility creates a *.dart file with a certificate.

### FAQ

Mandatory options:
    -n, --name      -   Name of the original certificate.

Optional options:
    -i, --input     -   The directory of the source certificate, by default accepts the directory of the utility.
    -o, --out       -   Converted certificate directory, accepts utility directory by default.
    -h, --help      -   Show help.

#### Exception
    Exception:  Enter the name of the certificate. - did not enter the name of the original certificate.
    Exception:  File certificate $path not found. - certificate not found in the directory.
    Exception:  Certificate conversion error. -  certificate conversion error.