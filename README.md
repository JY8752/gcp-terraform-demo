# GCP入門 by terraform

UdemyのGCP入門コースをterraformで受講した時の成果物。

## setup

```
# プロジェクト作成
make creae_project

# 作成したプロジェクトをデフォルトに設定
make set_project

# デフォルトに設定されているプロジェクトを確認
gcloud config get-value project
> gcp-test-project-20230329

# terraformサービスアカウントを作成
make create_account

# アカウントを追加
make add_account

# login
gcloud auth application-default login

# init
terraform init
```

GCPプロジェクトへの請求アカウントの紐付けは手動で実施。

## tflint

### pre-commit設定

```
git config core.hooksPath .githooks
```