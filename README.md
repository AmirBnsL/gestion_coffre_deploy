# Gestion Coffre Deploy

This repository contains the deployment configuration for the Gestion Coffre application, including both backend and frontend components as Git submodules.

## Quick Start

### Clone with submodules (Recommended)

To clone this repository along with all submodules in one command:

```bash
git clone --recurse-submodules git@github.com/AmirBnsL/gestion_coffre_deploy.git
```

### If you already cloned without submodules

If you've already cloned the repository but the submodule folders are empty:

```bash
git submodule update --init --recursive
```

## Project Structure

```
gestion_coffre_deploy/
├── docker-compose.yaml       # Docker composition configuration
├── Dockerfile               # Main Docker configuration
├── wait-for-mysql.sh        # MySQL wait script
├── gestion_coffre_backend/  # Backend submodule
└── gestion-coffre/          # Frontend submodule
```

## Submodules

This project includes the following submodules:

- **Backend**: [gestion_coffre_backend](https://github.com/AmirBnsL/gestion_coffre_backend.git)
- **Frontend**: [gestion-coffre](https://github.com/AmirBnsL/gestion_coffre_frontend.git)

## Development

After cloning with submodules, you can run the application using Docker:

```bash
docker compose up --build 
```

## Troubleshooting

### Submodules not cloned
If you see empty submodule directories, run:
```bash
git submodule update --init --recursive
```


# Production Environment Variables for gestion-coffre-backend

You must provide the following environment variables in your backend .env file:

- APP_SECRET=<your_app_secret> # Generate using a PHP library, e.g. bin/console secrets:generate-keys or random_bytes()
- DATABASE_URL=mysql://<user>:<password>@<host>:<port>/<db>?serverVersion=8.0.32&charset=utf8mb4 #from docker-compose.yaml mysql service
- JWT_SECRET_KEY=%kernel.project_dir%/config/jwt/private.pem # Generate using openssl
- JWT_PUBLIC_KEY=%kernel.project_dir%/config/jwt/public.pem # Generate using openssl
- JWT_PASSPHRASE=<your_jwt_passphrase>


## Notes
- Generate JWT keys using:
  ```bash
  mkdir -p gestion_coffre_backend/config/jwt
  openssl genpkey -algorithm RSA -out gestion_coffre_backend/config/jwt/private.pem -pkeyopt rsa_keygen_bits:4096
  openssl rsa -pubout -in gestion_coffre_backend/config/jwt/private.pem -out gestion_coffre_backend/config/jwt/public.pem
  ```
- Set `JWT_SECRET_KEY` and `JWT_PUBLIC_KEY` in `.env` as:
  ```
  JWT_SECRET_KEY=%kernel.project_dir%/config/jwt/private.pem
  JWT_PUBLIC_KEY=%kernel.project_dir%/config/jwt/public.pem
  JWT_PASSPHRASE=your_generated_passphrase
  ```
- Make sure the key files are readable by your backend container.
- Restart your backend container after generating the keys and updating `.env`.
- Generate APP_SECRET using a PHP library or Symfony command:
  ```bash
  php -r "echo bin2hex(random_bytes(32));"
  ```
