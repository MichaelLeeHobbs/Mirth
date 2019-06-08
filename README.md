# Mirth
Mirth Containerized


## Version Tags

This image provides various versions that are available via tags. `latest` tag is not used at this time. The tags reflect both the version of Mirth Connect the image uses as well as the image version for the specific version of Mirth Connect the images is being built for.
The image version uses [Semantic Versioning 2.0.0](https://semver.org/) with the Mirth Connection version and image version being separated by a -v.

| Tag | Description |
| {MCVersion}-v{Major.Minor.Patch} | --- |
| :----: | --- |
| 3.7.0.b2399-v0.0.8 | Beta image 0.0.8 with Mirth Connect running on OpenJDK 8 |

## Usage

Here are some example snippets to help you get started creating a container.

### docker
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