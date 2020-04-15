pipeline {
  agent any
  stages {
    stage('Docker Build') {
      steps {
        sh "docker build -t pawanitzone/hyt-http:${env.BUILD_NUMBER} ."
      }
    }
    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerHubUser', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh "docker push pawanitzone/hyt-http:${env.BUILD_NUMBER}"
        }
      }
    }
    stage('Docker Remove Image') {
      steps {
        sh "docker rmi pawanitzone/hyt-http:${env.BUILD_NUMBER}"
      }
    }
    stage('Apply Kubernetes Files') {
      steps {
          withKubeConfig([credentialsId: 'credentialsId', 
	  serverUrl: 'https://192.168.99.100:8443']) {
          sh 'cat hyt-deployment.yaml | sed "s/{{BUILD_NUMBER}}/$BUILD_NUMBER/g" |kubectl apply -f -'
          sh 'kubectl apply -f hyt-testing-service.yaml'
        }
      }
  }
}
}

