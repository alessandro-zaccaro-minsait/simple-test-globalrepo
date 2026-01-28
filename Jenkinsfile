// Jenkins Declarative Pipeline per monorepo con 4 subcomponenti
// Requisiti lato agente (se NON usi le varianti Docker commentate):
// - Node 18+, Maven 3.9+ (con JDK 17), Python 3.10+, Go 1.21+
// Suggerito: usa agenti Linux.

pipeline {
  agent any
  parameters {
    choice(name: 'COMPONENT', choices: ['service-b', 'none'], description: 'Scegli cosa buildare')
    // Puoi estendere a: ['service-a','service-b','service-c','service-d','all','none']
  }
  options { ansiColor('xterm'); timestamps(); disableConcurrentBuilds() }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
        sh 'echo "Commit: $(git rev-parse --short HEAD)"'
      }
    }

    stage('Build Java (service-b)') {
      when {
        anyOf {
          // Parte se selezioni esplicitamente service-b
          expression { params.COMPONENT == 'service-b' }
          // Oppure se ci sono cambi in service-b
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

    // Facoltativo: altri stage restano ma protetti da when simili o rimossi
  }

  post {
    always {
      archiveArtifacts allowEmptyArchive: true, artifacts: 'subcomponents/service-b/build/**/*', fingerprint: true
    }
  }
}
