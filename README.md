# MySQL-Python-FinalProject-
MySQL-and-Python

Flask app https://github.com/uym2/MySQL-and-Python deployed on AWS by using EKS and ECR By using terraform will create EKS , ECR , EC2 (act as Jenkins) By anible will deploy jenkins installation , docker , aws cli , Kubectl .... Kuberentes to trigger all files (deplyment , statefullset , confige map , vp , vpc .....)

# Terraform

- terraform init
- terraform apply

# Ansible

    Install Jenkins
    Configure Jenkins access
    Install dependence (Docker , aws cli , Kubectl ,.....)

- ansible-playbook -i Inventory-name --private-key key-name main.yaml

# apply Kuberentes Mainfest

kubectl apply -f [all mainfest ]

-log in EKS

aws eks --region example_region update-kubeconfig --name cluster_name

-log in ECR and push images
aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/flask-app

docker build -t flask-app .

docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/flask-app:latest

# Jenkins

    add credential Dashboard > Manage Jenkins > Credentials > system > Global credentials (unrestricted) + Add Credentials
    add (secert key , access key ,...)
    add Github token
