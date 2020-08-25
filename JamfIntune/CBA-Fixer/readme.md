This Script and Plist is intended to be deployed with Jamf Pro

The issue that this project fixes is when there is a Certificate Authentication infront of ADFS. The issues is that CompanyPortal (as of writing this) create keychain items in the uses keychain. The issue is that it assumes that the same certificate that is used only the once and creates 2 keychain Items that default to /adfs/ls and adfs/ls/. The certificate that it forces and defaults to is the certificate that is installed via the company portal. It causes the JamfAAD agent to send that cert in authentication resulting in bad Auth. 

The use case is slim but there is still a use if you look close at what this does :) 

The complete package is in the CBA-Helper.zip with some basic documentation. Spelling is not my strong point

Be kind to each other, the world is mean enough.
