echo "Running terraform init in $DIR"
terraform -chdir=$1 init -reconfigure -backend-config=backend.conf
echo "Terraform Successfully initialized in $1"

terraform -chdir=$1 destroy --auto-approve 
