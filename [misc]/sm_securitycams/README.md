# Modit.store Script Upload

To use the remote loading system provided by modit.store, follow the steps below CAREFULLY:

1. Make sure you're using a server artifacts build that doesn't break JSON. Recommend 2430, guaranteed to work here.
2. Read the fxmanifest.lua provided, and take note of two things inside the file:
  - mod
    * This is your products SKU from the website.
    * Must correlate between the "Product SKU" that you're uploading on the web panel also.
  version
    * This is for serving multiple versions of your script to the customers.
    * You can create "test builds" with basically any version number you want, and customers can load it by specifying this version number in their fxmanifest.lua.
    * Any time you want to update your script on the webpanel, you must use a new version number, as overwriting previous versions is not allowed.
3. Add the server.lua provided to your script. This file is responsible for remote loading the code that you've uploaded to our back end.
4. Make sure the server.lua is defined FIRST in your fxmanifest.lua, under "server_script(s)".

NOTE: We only remote load server side code. Any additional loading must be handled manually.
