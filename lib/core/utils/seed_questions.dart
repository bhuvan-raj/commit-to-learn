import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/question.dart';

class QuestionSeeder {
  static Future<void> seedAllQuestions() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference questions = firestore.collection('questions');

    List<Question> devopsQuestions = [
      // EASY QUESTIONS

      Question(
        id: '',
        text: "Which operating system is widely used in DevOps servers?",
        options: ["Windows", "Linux", "MacOS", "Solaris"],
        correctAnswerIndex: 1,
        explanation: "Linux is the most commonly used operating system in DevOps environments.",
        category: "Linux",
        difficulty: Difficulty.easy,
      ),

      Question(
        id: '',
        text: "Which AWS service provides virtual machines?",
        options: ["Lambda", "S3", "EC2", "RDS"],
        correctAnswerIndex: 2,
        explanation: "EC2 provides scalable virtual servers in AWS.",
        category: "AWS",
        difficulty: Difficulty.easy,
      ),

      Question(
        id: '',
        text: "Which AWS service provides object storage?",
        options: ["EBS", "EFS", "S3", "IAM"],
        correctAnswerIndex: 2,
        explanation: "Amazon S3 is AWS object storage service.",
        category: "AWS",
        difficulty: Difficulty.easy,
      ),

      Question(
        id: '',
        text: "Which Linux command lists files in a directory?",
        options: ["pwd", "ls", "cd", "cat"],
        correctAnswerIndex: 1,
        explanation: "ls is used to list files and directories.",
        category: "Linux",
        difficulty: Difficulty.easy,
      ),

      Question(
        id: '',
        text: "Which AWS service runs serverless functions?",
        options: ["EC2", "Lambda", "S3", "CloudFront"],
        correctAnswerIndex: 1,
        explanation: "AWS Lambda runs serverless functions.",
        category: "AWS",
        difficulty: Difficulty.easy,
      ),

      // INTERMEDIATE QUESTIONS

      Question(
        id: '',
        text: "Which tool is commonly used for containerization?",
        options: ["Ansible", "Docker", "Jenkins", "Git"],
        correctAnswerIndex: 1,
        explanation: "Docker is the most common containerization platform.",
        category: "Docker",
        difficulty: Difficulty.intermediate,
      ),

      Question(
        id: '',
        text: "Which tool is widely used for container orchestration?",
        options: ["Docker", "Kubernetes", "Maven", "Terraform"],
        correctAnswerIndex: 1,
        explanation: "Kubernetes is used to orchestrate containers at scale.",
        category: "Kubernetes",
        difficulty: Difficulty.intermediate,
      ),

      Question(
        id: '',
        text: "Which monitoring tool uses exporters?",
        options: ["Grafana", "Prometheus", "Nagios", "Datadog"],
        correctAnswerIndex: 1,
        explanation: "Prometheus uses exporters to collect metrics.",
        category: "Monitoring",
        difficulty: Difficulty.intermediate,
      ),

      Question(
        id: '',
        text: "Which AWS service provides shared file storage?",
        options: ["EBS", "EFS", "S3", "Glacier"],
        correctAnswerIndex: 1,
        explanation: "EFS provides shared file storage for multiple EC2 instances.",
        category: "AWS",
        difficulty: Difficulty.intermediate,
      ),

      Question(
        id: '',
        text: "Which Linux command changes file permissions?",
        options: ["chmod", "chown", "mv", "touch"],
        correctAnswerIndex: 0,
        explanation: "chmod is used to modify file permissions.",
        category: "Linux",
        difficulty: Difficulty.intermediate,
      ),

      // HARD QUESTIONS

      Question(
        id: '',
        text: "Which Infrastructure as Code tool is created by HashiCorp?",
        options: ["Ansible", "Terraform", "Chef", "Puppet"],
        correctAnswerIndex: 1,
        explanation: "Terraform is HashiCorp's Infrastructure as Code tool.",
        category: "Terraform",
        difficulty: Difficulty.expert,
      ),

      Question(
        id: '',
        text: "Which Kubernetes object exposes pods externally?",
        options: ["Ingress", "Service", "ReplicaSet", "Namespace"],
        correctAnswerIndex: 1,
        explanation: "A Service exposes pods to internal or external traffic.",
        category: "Kubernetes",
        difficulty: Difficulty.expert,
      ),

      Question(
        id: '',
        text: "Which AWS networking component is stateless?",
        options: ["SecurityGroup", "NACL", "Route53", "IAM"],
        correctAnswerIndex: 1,
        explanation: "Network ACLs are stateless firewalls in AWS.",
        category: "AWS",
        difficulty: Difficulty.expert,
      ),

      Question(
        id: '',
        text: "Which protocol is used by AWS EFS?",
        options: ["SMB", "FTP", "NFS", "HTTP"],
        correctAnswerIndex: 2,
        explanation: "Amazon EFS uses the NFS protocol.",
        category: "AWS",
        difficulty: Difficulty.expert,
      ),

      Question(
        id: '',
        text: "Which Kubernetes package manager is widely used?",
        options: ["Helm", "Kubectl", "Istio", "Minikube"],
        correctAnswerIndex: 0,
        explanation: "Helm is the package manager for Kubernetes.",
        category: "Kubernetes",
        difficulty: Difficulty.expert,
      ),
    ];

    for (var q in devopsQuestions) {
      await questions.add(q.toFirestore());
    }

    print("🚀 Questions successfully seeded to Firestore!");
  }
}