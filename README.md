# Mirth Connect Containerized
[![](https://images.microbadger.com/badges/image/michaelleehobbs/mirth:3.7.0.b2399-v0.0.8.svg)](https://microbadger.com/images/michaelleehobbs/mirth:3.7.0.b2399-v0.0.8 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/michaelleehobbs/mirth:3.7.0.b2399-v0.0.8.svg)](https://microbadger.com/images/michaelleehobbs/mirth:3.7.0.b2399-v0.0.8 "Get your own version badge on microbadger.com")
![](https://img.shields.io/docker/pulls/michaelleehobbs/mirth.svg)
![](https://img.shields.io/docker/stars/michaelleehobbs/mirth.svg)
![](https://img.shields.io/docker/cloud/build/michaelleehobbs/mirth.svg)
![](https://img.shields.io/github/issues/michaelleehobbs/mirth.svg)
![](https://img.shields.io/github/license/michaelleehobbs/mirth.svg)

## Version Tags

This image provides various versions that are available via tags. `latest` tag is not used at this time. The tags reflect both the version of Mirth Connect the image uses as well as the image version for the specific version of Mirth Connect the images is being built for.
The image version uses [Semantic Versioning 2.0.0](https://semver.org/) with the Mirth Connection version and image version being separated by a -v.

Tag break down: `{Mirth Connect Version}`-v`{Major.Minor.Patch}`

| Tag | Description |
| :----: | --- |
| 3.7.0.b2399-v0.1.0 | Beta image 0.1.0 with Mirth Connect running on OpenJDK 8 |

## Usage

Here are some example snippets to help you get started creating a container.

### Docker
```
docker create \
  --name=mirth \
  -e TZ=Europe/London \
  -e DB_TYPE=postgres \
  -e DB_HOST=127.0.0.1 \
  -e DB_USERNAME=postgres \
  -e DB_PASSWORD=password \
  -p 80:8080 \
  -p 443:8443 \
  -p 5000:5000 \
  -v <path to mirth-appdata>:/opt/mirthconnect/appdata \
  -v <path to mirth-conf>:/opt/mirthconnect/conf \
  --restart unless-stopped \
  michaelleehobbs/mirth:3.7.0.b2399-v0.0.8
```

### docker-compose

Compatible with docker-compose v3.7 schemas.

#### Docker Compose with Postgres DB Container and .env files

`docker-compose.yml`
```yaml
version: '3.7'

services:
  db:
    image: postgres
    volumes:
      - mirth-db:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    restart: unless-stopped
    env_file: .env.postgres
    networks:
      - mirth

  mirth:
    image: michaelleehobbs/mirth:3.7.0.b2399-v0.0.8
    volumes:
      - mirth-appdata:/opt/mirthconnect/appdata
      - mirth-conf:/opt/mirthconnect/conf
    ports:
      - "80:8080"
      - "443:8443"
      - "5000:5000"
    restart: unless-stopped
    env_file: .env.mirth
    networks:
      - mirth

networks:
  mirth:

volumes:
  mirth-db:
  mirth-appdata:
  mirth-conf:
```

`.env.postgres`
```dotenv
POSTGRES_USER=postgres
POSTGRES_PASSWORD=password
POSTGRES_DB=mirthdb
```

`.env.mirth`
```dotenv
DB_TYPE=postgres
DB_USERNAME=postgres
DB_PASSWORD=password
```

#### Docker Compose with AWS RDS Postgres, EFS for volume stores, and .env files

`docker-compose.yml`
```yaml
version: '3.7'

services:
  mirth:
    image: michaelleehobbs/mirth:3.7.0.b2399-v0.0.8
    volumes:
      - /efs/volumes/mirth/appdata:/opt/mirthconnect/appdata
      - /efs/volumes/mirth/conf:/opt/mirthconnect/conf
    ports:
      - "80:8080"
      - "443:8443"
      - "5000:5000"
    restart: unless-stopped
    env_file: .env.mirth
```

`.env.mirth`
```dotenv
DB_TYPE=postgres
DB_HOST=mirthdb.cjimkjtl3pds.us-east-1.rds.amazonaws.com
DB_USERNAME=postgres
DB_PASSWORD=password
```

## Planed Features
### Coming Soon
* Improved Documentation
* Multiple base version ie Mirth Connect 3.4, 3.5, 3.6, etc...

### Down the Road
* More Examples! 
* Step by Step guides for setting up MC in a variety of ways i.e. deployed to AWS using RDS and EFS 
* Images with Custom Libs
* Poor Mans clustering ie Clustering without 

## Known Issues and Limitations
* When running multiple MC Containers off the same Database ie clustering Mirth without the clustering plugin has many issues with polling channels. 
Thus poor mans clustering should only be used for non-polling channels.  