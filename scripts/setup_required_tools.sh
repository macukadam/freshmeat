echo "=== Updating and upgrading system packages... ==="
sudo apt-get update -y && sudo apt-get upgrade -y

echo "=== Installing build essentials ... ==="
sudo apt-get install build-essential pkg-config libssl-dev -y

echo "=== Installing npm... ==="
sudo apt-get install npm -y

echo "=== Installing dotnet-vault... ==="
npx --yes dotenv-vault@latest

echo "=== Setting up environment variables... ==="
npx dotenv-vault@latest pull development .env

echo "=== Installing pip... ==="
sudo apt-get install python3-pip -y

echo "=== Installing venv... ==="
sudo apt-get install python3-venv -y

echo "=== Installing Docker... ==="
sudo apt-get install docker.io -y

echo "=== Installing Docker Compose... ==="
sudo apt-get install docker-compose -y

echo "=== Installing curl... ==="
sudo apt-get install curl -y

echo "=== Installing picom... ==="
sudo apt-get install picom -y

echo "=== Installing feh... ==="
sudo apt-get install feh -y
