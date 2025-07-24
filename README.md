# Gestion Coffre Deploy

This repository contains the deployment configuration for the Gestion Coffre application, including both backend and frontend components as Git submodules.

## Quick Start

### Clone with submodules (Recommended)

To clone this repository along with all submodules in one command:

```bash
git clone --recurse-submodules https://github.com/AmirBnsL/gestion_coffre_deploy.git
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
docker-compose up
```

## Troubleshooting

### Submodules not cloned
If you see empty submodule directories, run:
```bash
git submodule update --init --recursive
```

### Permission issues
If you encounter authentication issues when cloning submodules, make sure the submodule repositories are public or you have the necessary access permissions.

## Contributing

1. Fork the repository
2. Clone with submodules: `git clone --recurse-submodules <your-fork-url>`
3. Make your changes
4. Submit a pull request
