# EKS-Terraform Practice

## 목적
EKS 및 기타 AWS 인프라 요소를 Terraform으로 구성한다.

## 구성 내역
- 체크 박스된 것은 EKS pod에서 동작 확인
- [x] vpc
- [x] eks
- [x] msk
- [x] s3
- [x] dynamo
- [x] cache
- [x] memorydb
- [ ] rds
- [x] secretmanager

## 실행 방법
1. 아래 파일의 값 변경 '## 변수 변경할 내역들'들 변경
- ./terraform.tfvars

2. VPC, EKS, MSK 등 인프라 생성
- terraform init
- terraform apply

## 실행 후, EKS Service Account, ALB 추가 설정
- 인프라 생성 후, EKS의 Service Account, ALB 설정은 아래 위치의 README 참고
- cd ../post-infra