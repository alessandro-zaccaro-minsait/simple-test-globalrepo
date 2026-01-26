# Prova Monorepo

Questo repository contiene un monorepo con 4 subcomponenti di esempio e una pipeline Jenkins per build/test paralleli.

## Struttura
```
prova/
├─ Jenkinsfile
├─ subcomponents/
│  ├─ service-a/   # Node.js
│  ├─ service-b/   # Java (Maven)
│  ├─ service-c/   # Python
│  └─ service-d/   # Go
```

## Prerequisiti locali (se non usi Docker in Jenkins)
- Node.js >= 18
- Maven >= 3.9 (JDK 17)
- Python >= 3.10
- Go >= 1.21

## Esecuzione build locali (per singolo servizio)
```bash
cd subcomponents/service-a && ./build.sh
cd subcomponents/service-b && ./build.sh
cd subcomponents/service-c && ./build.sh
cd subcomponents/service-d && ./build.sh
```

## Pipeline Jenkins
- Usa `Jenkinsfile` alla radice del repo.
- Esegue i 4 subcomponenti in **parallelo**.
- Ogni stage viene eseguito **solo se** ci sono modifiche nel rispettivo path (`when { changeset ... }`).

Vedi il file `Jenkinsfile` per i dettagli e la variante Docker (commentata) in ogni stage.
