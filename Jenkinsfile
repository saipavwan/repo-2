pipeline {
    stages {
        stage ('Build') {
            steps{
            sh """
            echo "Preparing the application....."
            npm install
	    bower install
            """
            }
        }
        stage ('Tests') {
            steps {
                sh """
                echo "Testing the application...."
                grunt all
                """     
            }
        }
    } 
}
