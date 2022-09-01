# Post-Infra

## 목적
EKS의 Service Account, ALB 설정을 Terraform으로 구성한다.

## 실행 방법
1. 아래 파일에서 Service Account에 부여할 권한을 설정
- ./terraform.tfvars

2. 설정할 EKS를 지정
- aws eks update-kubeconfig --name [EKS명]

3. Service Account, ALB 생성
- terraform init
- terraform apply