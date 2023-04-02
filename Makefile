# project_idは6-30文字で小文字英数字で一意に指定する必要がある
GCP_PROJECT_ID = "gcp-test-project-20230329"
GCP_PROJECT_NAME = "gcp-test-project"
GCS_BUCKET_NAME = "gcp-test-project-20230329-test-bucket"

# GCPプロジェクトの作成
create_project:
	gcloud projects create $(GCP_PROJECT_ID) --name=$(GCP_PROJECT_NAME)

# GCPプロジェクトをデフォルトに設定する
set_project:
	gcloud config set project $(GCP_PROJECT_ID)

# terraformアカウントを作成
create_account:
	gcloud iam service-accounts create terraform --display-name="terraform"

# プロジェクトに作成したアカウントを追加する
add_account:
	gcloud projects add-iam-policy-binding $(GCP_PROJECT_ID) \
		--member serviceAccount:"terraform@$(GCP_PROJECT_ID).iam.gserviceaccount.com" \
		--role "roles/owner" \
		--no-user-output-enabled

# GCPのAPI有効化
enable_api:
	gcloud services enable compute.googleapis.com
	gcloud services enable cloudfunctions.googleapis.com
	gcloud services enable sqladmin.googleapis.com
	gcloud services enable servicenetworking.googleapis.com
# gcloud services enable artifactregistry.googleapis.com
# gcloud services enable appengine.googleapis.com
# gcloud services enable iam.googleapis.com
# gcloud services enable run.googleapis.com
# gcloud services enable cloudresourcemanager.googleapis.com
# gcloud services enable firebase.googleapis.com
# gcloud services enable cloudbuild.googleapis.com
# gcloud services enable runtimeconfig.googleapis.com
# gcloud services enable serviceusage.googleapis.com
# gcloud services enable secretmanager.googleapis.com

# GCSにリソースをアップロードする
upload_resources:
	gsutil -m rsync ./resources gs://$(GCS_BUCKET_NAME)