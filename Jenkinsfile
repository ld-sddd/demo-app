pipeline {
  agent any
  environment {
    IMG_TAG  = "${env.GIT_COMMIT.take(7)}"
    IMG_NAME = "demo-app:${IMG_TAG}"
    KIND_CL  = "demo"
  }
  stages {
    stage('Checkout') { steps { checkout scm } }

    stage('Build Docker image') {
      steps { sh "docker build -t $IMG_NAME ." }
    }

    stage('Load image into Kind') {
      steps { sh "kind load docker-image $IMG_NAME --name $KIND_CL" }
    }

    stage('Deploy to Kind') {
      steps {
        sh """
          kubectl apply -f k8s/namespace.yaml
          sed "s|REPLACE_ME|$IMG_NAME|g" k8s/deploy.yaml | kubectl apply -f -
          kubectl apply -f k8s/svc.yaml
        """
      }
    }
  }
  post {
    success { echo "✅ $IMG_NAME running on Kind" }
    failure { echo "❌ Pipeline failed" }
  }
}
