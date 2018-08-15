# Installing to Franz...

This addition to Franz has not been published to their community repo, so you will need to manually install.

### To install to Franz:

 - Quit any running instances of Franz
 - Open the Franz Plugins folder on your machine:

*This can be done by going to one of the following folders:*

```
    Mac: ~/Library/Application Support/Franz/recipes/
    Windows: %appdata%/Franz/recipes/
    Linux: ~/.config/Franz/recipes/
```

 - copy the `dev` directory into the Franz plugin folder on your machine.

### Restart Franz and use the plug-in!

  - You're good to go (you will need to also stand up the Docker container which Runs the actual Viber Desktop app and publishes it)...

**NOTE:**

If you're like me and running Viber on another instance you will need to edit the `package.json` file and update the `serviceURL` to point to your correctly configured "web based Viber" endpoint.