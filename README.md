## Docker image for MailHog

Docker image build script for [MailHog](https://github.com/mailhog/MailHog), a SMTP testing tool (AKA Mail Catcher).

The image is based on RedHat's UBI Base Image which fit best for deployment on RedHat OpenShift platform (but not limited to that)

#### Building the image

To build the image using docker build, run:

```
$ docker build . -t mailhog
```

#### Container Settings

The container supports Basic Auth access limit on the UI of the app (Not for the SMTP server),
To configure credentials - set the following environment variables:

| Name             | Details                     |
| ---------------- | --------------------------- |
| `MH_UI_USERNAME` | Username for the MailHog UI |
| `MH_UI_PASSWORD` | Password for the MailHog UI |

#### Running the container

Using docker:

```
$ docker run -it -e "MH_UI_USERNAME=user" -e "MH_UI_PASSWORD=pass" -p "8025:8025" -p "1025:1025" mailhog
```

This command will run the container and open access to 2 services from your local machine:

- On Port 1025 - SMTP Server (No Auth, No TLS, See [MailHog](https://github.com/mailhog/MailHog) for Further details)
- On http://localhost:8025 - the MailHog UI, used to view traffic from SMTP (Username: `user`, Password: `pass`)
