# MySQL-Python-FinalProject-
MySQL-and-Python

Flask app https://github.com/uym2/MySQL-and-Python deployed on AWS by using EKS and ECR By using terraform will create EKS , ECR , EC2 (act as Jenkins) By anible will deploy jenkins installation , docker , aws cli , Kubectl .... Kuberentes to trigger all files (deplyment , statefullset , confige map , vp , vpc .....)

#Terraform

    EKS
    EC2
    ECR

- terraform init
- terraform apply

#Ansible

    Install Jenkins
    Configure Jenkins access
    Install dependence (Docker , aws cli , Kubectl ,.....)

- anible-playbook -i Inventory-name --private-key key-name playbook.yml

apply Kuberentes Mainfest

kubectl apply -f [all mainfest ]

-log in to EKS

aws eks --region example_region update-kubeconfig --name cluster_name

-log in to ECR and push images

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/y1x1a8h4

docker build -t flask-app .

docker tag flask-app:latest public.ecr.aws/y1x1a8h4/flask-app:latest

docker push public.ecr.aws/y1x1a8h4/flask-app:latest

#Jenkins

    add credential Dashboard > Manage Jenkins > Credentials > system > Global credentials (unrestricted) + Add Credentials
    add (secert key , access key ,...)
    add Github token
