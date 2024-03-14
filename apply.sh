apt update &> /dev/null
apt install figlet &> /dev/null


echo "Running terraform init in $DIR"
terraform -chdir=$1 init -reconfigure -backend-config=backend.conf
echo "Terraform Successfully initialized in $1"


figlet "# TF Apply -"
figlet "$1"
terraform -chdir=$1 apply --auto-approve | grep -v "\.\.\." | grep -v "Read complete after"
