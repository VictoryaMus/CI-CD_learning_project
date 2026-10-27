set -eu

<<<<<<< HEAD
USER="${DEPLOY_USER:-stoutmin}"
HOST="${DEPLOY_HOST:?DEPLOY_HOST is not set}"
KEY="${SSH_KEY_PATH:-$HOME/.ssh/id_ed25519}"
=======
USER="stoutmin"
HOST="192.168.50.141"
KEY="/home/gitlab-runner/.ssh/id_ed25519"
>>>>>>> bfbc6b536e3350fcdeda63f7dcd5910e161915b8
BINARY="DO"

scp -i "$KEY" -o StrictHostKeyChecking=no "$BINARY" "$USER@$HOST:/tmp/DO"
ssh -i "$KEY" -o StrictHostKeyChecking=no "$USER@$HOST" \
    "sudo mv /tmp/DO /usr/local/bin/ && sudo chmod +x /usr/local/bin/DO"