pipeline {
    agent {
        kubernetes {
            defaultContainer 'helmfile'
            yaml """
kind: Pod
metadata:
  name: helmfile
spec:
  containers:
  - name: busybox
    image: busybox:1.31
    imagePullPolicy: IfNotPresent
    command:
    - cat
    tty: true
  - name: helmfile
    image: chatwork/helmfile:0.108.0
    imagePullPolicy: IfNotPresent
    command:
    - cat
    tty: true
"""
        }
    }
    environment {
        TEST="test"
    }
    stages {
        stage('Helm Upgrade') {
            steps {
                checkout scm
                container(name: 'helmfile') {
                    withCredentials([file(credentialsId: 'kubeconfig-test', variable: 'KUBECONFIG')]) {
                        sh '''
                            export KUBECONFIG
                            cat $KUBECONFIG
                        '''
                    }
                }
            }
        }
    }
}
