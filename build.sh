#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default values
IMAGE_NAME="dev-sandbox"
CONTAINER_NAME="dev-sandbox"
WORKSPACE_DIR="./workspace"
ACTION="build"

# Print help
function show_help {
  echo -e "${BLUE}Docker Development Sandbox${NC}"
  echo
  echo "Usage: $0 [options] [action]"
  echo
  echo "Actions:"
  echo "  build       Build the Docker image (default)"
  echo "  run         Run the container"
  echo "  start       Start an existing container"
  echo "  stop        Stop a running container"
  echo "  cleanup     Remove container and image"
  echo
  echo "Options:"
  echo "  -h, --help               Show this help message"
  echo "  -i, --image NAME         Set the image name (default: dev-sandbox)"
  echo "  -c, --container NAME     Set the container name (default: dev-sandbox)"
  echo "  -w, --workspace DIR      Set the workspace directory (default: ./workspace)"
  echo
  echo "Examples:"
  echo "  $0 build                  # Build the image"
  echo "  $0 run                    # Run a new container"
  echo "  $0 --workspace ~/projects run  # Run with a custom workspace"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -h|--help)
      show_help
      exit 0
      ;;
    -i|--image)
      IMAGE_NAME="$2"
      shift
      shift
      ;;
    -c|--container)
      CONTAINER_NAME="$2"
      shift
      shift
      ;;
    -w|--workspace)
      WORKSPACE_DIR="$2"
      shift
      shift
      ;;
    build|run|start|stop|cleanup)
      ACTION="$1"
      shift
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      show_help
      exit 1
      ;;
  esac
done

# Create workspace directory if it doesn't exist
if [ ! -d "$WORKSPACE_DIR" ]; then
  echo -e "${YELLOW}Creating workspace directory: $WORKSPACE_DIR${NC}"
  mkdir -p "$WORKSPACE_DIR"
fi

# Perform the requested action
case $ACTION in
  build)
    echo -e "${GREEN}Building Docker image: $IMAGE_NAME${NC}"
    docker build -t "$IMAGE_NAME" .
    ;;
  run)
    echo -e "${GREEN}Running new container: $CONTAINER_NAME${NC}"
    echo -e "${YELLOW}Mounting workspace: $WORKSPACE_DIR -> /home/developer/workspace${NC}"
    docker run -it --rm --name "$CONTAINER_NAME" \
      -v "$(realpath "$WORKSPACE_DIR"):/home/developer/workspace" \
      "$IMAGE_NAME"
    ;;
  start)
    echo -e "${GREEN}Starting existing container: $CONTAINER_NAME${NC}"
    docker start -i "$CONTAINER_NAME"
    ;;
  stop)
    echo -e "${GREEN}Stopping container: $CONTAINER_NAME${NC}"
    docker stop "$CONTAINER_NAME"
    ;;
  cleanup)
    echo -e "${YELLOW}Cleaning up container and image...${NC}"
    docker stop "$CONTAINER_NAME" 2>/dev/null || true
    docker rm "$CONTAINER_NAME" 2>/dev/null || true
    docker rmi "$IMAGE_NAME" 2>/dev/null || true
    echo -e "${GREEN}Cleanup complete${NC}"
    ;;
esac 