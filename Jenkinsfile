node {
    // Change DOCKER_REPO to use the docker repository where build artifacts
    // will be pushed. If you are using Docker Hub, this would look like:
    // your-username/sample-service
    def DOCKER_REPO = 'opsani/sample-service'
    def version     = ''
    def img         = ''

    stage('build') {
        checkout scm
        version = readFile('sample-service/version').trim()
        img = docker.build("${DOCKER_REPO}:${version}", "sample-service")
    }

    stage('publish') {
        docker.withRegistry('https://index.docker.io/v1/', 'sample-docker-registry-id') {
            img.push("${version}")
        }
    }

    stage('deploy') {
        // Create an env file that defines the version of the container
        sh "echo 'vars:' > env-build.yaml"
        sh "echo '  sample_service_ver: ${version}' >> env-build.yaml"
        sh "echo '  sample_service_img: ${DOCKER_REPO}' >> env-build.yaml"

        // Run Skopos CLI
        // Note:  the --replace-all flag forces a re-deploy every time the pipeline
        // runs.  Remove the flag if that is not desired and Skopos will only deploy
        // if the version of the service changed.
        // Note:  change the address in the -bind parameter to be the address where
        // Skopos can be reached.
        sh "/skopos/bin/skopos run -project ${JOB_NAME} -wait -bind 172.17.0.1:8100 --replace-all -env env.yaml -env env-build.yaml model.yaml"
    }

    // Optionally, run tests against the deployed app
    // stage("test")
    // ...
    // stage("deploy to production")
    // ... same as deploy stage, but call Skopos instance that runs on
    // production cluster
}
