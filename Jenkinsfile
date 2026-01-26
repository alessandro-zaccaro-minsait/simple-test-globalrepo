// Jenkins Declarative Pipeline per monorepo con 4 subcomponenti
// Requisiti lato agente (se NON usi le varianti Docker commentate):
// - Node 18+, Maven 3.9+ (con JDK 17), Python 3.10+, Go 1.21+
// Suggerito: usa agenti Linux.

pipeline {
  agent any
  options {
    ansiColor('xterm')
    timestamps()
    disableConcurrentBuilds()
  }
  triggers {
    // Abilita webhook GitHub per push/PR sul job (consigliato)
  }
  environment {
    // Variabili comuni se servono
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
        sh 'echo "Commit: $(git rev-parse --short HEAD)"'
      }
    }

    stage('Build subcomponents (parallel)') {
      parallel {
        stage('service-a (Node)') {
          when {
            beforeAgent true
            anyOf {
              changeset pattern: 'subcomponents/service-a/**', comparator: 'ANT'
              changeset pattern: 'Jenkinsfile', comparator: 'ANT'
            }
          }
          steps {
            dir('subcomponents/service-a') {
              sh 'chmod +x build.sh && ./build.sh'
            }
          }
          // Esempio alternativa con Docker (decommenta e rimuovi agent any in alto se vuoi usare solo Docker)
          // agent { docker { image 'node:18-alpine' } }
        }

        stage('service-b (Maven)') {
          when {
            beforeAgent true
            anyOf {
              changeset pattern: 'subcomponents/service-b/**', comparator: 'ANT'
              changeset pattern: 'Jenkinsfile', comparator: 'ANT'
            }
          }
          steps {
            dir('subcomponents/service-b') {
              sh 'chmod +x build.sh && ./build.sh'
            }
          }
          post {
            always {
              junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'
            }
          }
          // agent { docker { image 'maven:3.9-eclipse-temurin-17' } }
        }

        stage('service-c (Python)') {
          when {
            beforeAgent true
            anyOf {
              changeset pattern: 'subcomponents/service-c/**', comparator: 'ANT'
              changeset pattern: 'Jenkinsfile', comparator: 'ANT'
            }
          }
          steps {
            dir('subcomponents/service-c') {
              sh 'chmod +x build.sh && ./build.sh'
            }
          }
          // agent { docker { image 'python:3.11-alpine' } }
        }

        stage('service-d (Go)') {
          when {
            beforeAgent true
            anyOf {
              changeset pattern: 'subcomponents/service-d/**', comparator: 'ANT'
              changeset pattern: 'Jenkinsfile', comparator: 'ANT'
            }
          }
          steps {
            dir('subcomponents/service-d') {
              sh 'chmod +x build.sh && ./build.sh'
            }
          }
          // agent { docker { image 'golang:1.22-alpine' } }
        }
      }
    }
  }
  post {
    success { echo '✅ Build completata con successo.' }
    unstable { echo '⚠️ Build instabile. Controlla i report.' }
    failure { echo '❌ Build fallita.' }
    always { archiveArtifacts allowEmptyArchive: true, artifacts: 'subcomponents/**/build/**/*', fingerprint: true }
  }
}
