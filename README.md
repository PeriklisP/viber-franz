# Franz Viber Plugin

This is a plugin for the [Franz Messaging App](https://meetfranz.com/) that wraps Viber inside a docker container, published via novnc.

_(In simple terms think of this as a "web based" Viber wrapper...)_

-------------------

![Screenshot](franz-plugin/screenshot.jpg)

### Steps to get started:

To get up and running you will need to:

 1. Install [Docker](https://www.docker.com/) (on your machine, or a server somewhere that will "publish" your Viber application)...
 2. Install [Docker Compose](https://docs.docker.com/compose/install/) - Pretty straightforward, follow the instructions...
 3. Configure & start the Viber container...
 4. Install the Viber plugin to Franz.

### Configuring & Starting Viber Container

This is fairly straightforward, just run the following commands from the `viber-docker` directory:

```
docker-compose up --build -d
```

By default the container will auto-start when Docker starts (so if you restart your computer, it will come back automatically).

### Install plugin to Franz

Please see the [franz-plugin/readme](franz-plugin/readme.md) file for instructions on installing and enabling the Viber Plugin within Franz.

### Moving Files/Directories?

If you move this project's files around after you have stood up the docker container, you will need to: `docker-compose down && docker-compose up -d` the _viber-docker_ directory again.

### Publishing the Viber Server on the web (web based Viber)

If you want to run just the docker container on the web (to publish Viber as if it was a Web Based Chat app) I suggest you put a service such as [Caddy](https://caddyserver.com/) in-front of the service to provide a free SSL certificate (via Lets Encrypt) - You will also want to change the default VNC password in `viber-docker/docker-root/etc/cont-init.d/10-setup-vnc` to something unique and secure.

You may then access the service via your favourite browser like so:
`https://<your-viber-server>/?autoconnect=true&reconnect=true&resize=remote&reconnect_delay=1000`

### Future Improvements
- There's currently no notifications hooked into Franz - We might be able to do this by monitor any signal sent via libpulse and assume it's a Notification? 

- Map audio through to Host Client from Libpulse (See: https://github.com/novnc/noVNC/issues/302)