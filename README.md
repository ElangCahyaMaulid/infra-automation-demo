# 🛠 infra-automation-demo

**infra-automation-demo** adalah proyek Infrastructure as Code (IaC) yang mendemonstrasikan otomatisasi infrastruktur lengkap dengan **Ansible**, **Docker**, **Kubernetes**, **Jenkins**, dan stack monitoring **Prometheus + Grafana**. Proyek ini cocok digunakan untuk pembelajaran DevOps modern dan praktik CI/CD serta monitoring berbasis container dan cloud-native.

---

## 📦 Fitur Utama

* Provisioning otomatis dengan **Ansible**
* Layanan monitoring dengan **Prometheus**, **Node Exporter**, **cAdvisor**, dan **Grafana**
* Manajemen container menggunakan **Docker Compose** dan **Kubernetes YAML**
* CI/CD pipeline menggunakan **Jenkins**
* Setup reverse proxy (opsional) menggunakan **Nginx** untuk akses domain custom

---

## 🧰 Teknologi

* Ubuntu/Debian Linux
* Ansible
* Docker & Docker Compose
* Kubernetes (Minikube + kubectl)
* Jenkins
* Prometheus + Grafana + Node Exporter + cAdvisor

---

## 📁 Struktur Proyek

```
infra-automation-demo/
├── ansible/
│   ├── inventory.yml
│   ├── site.yml
│   └── roles/
│       └── monitoring/
│           ├── tasks/
│           │   └── main.yml
│           ├── templates/
│           │   └── prometheus.yml.j2
│           └── files/
│               └── grafana-dashboard.json
├── docker/
│   └── docker-compose.monitoring.yml
├── kubernetes/
│   └── monitoring/
│       ├── prometheus-deployment.yaml
│       ├── grafana-deployment.yaml
│       ├── node-exporter-daemonset.yaml
│       └── ...
├── jenkins/
│   └── Jenkinsfile
├── nginx/
│   └── grafana.conf
├── .gitignore
└── README.md
```

---

## ✅ Prasyarat Instalasi

Pastikan Anda telah menginstal:

* [Docker & Docker Compose](https://docs.docker.com/get-docker/)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [Minikube](https://minikube.sigs.k8s.io/docs/start/)
* [Jenkins](https://www.jenkins.io/download/) (opsional via Docker)

---

## 🚀 Langkah Instalasi & Menjalankan Layanan

### 1. Clone Repositori

```bash
git clone https://github.com/ElangCahyaMaulid/infra-automation-demo.git
cd infra-automation-demo
```

### 2. Setup Virtual Environment & Ansible (opsional)

```bash
python3 -m venv venv
source venv/bin/activate
pip install ansible
```

### 3. Konfigurasi Inventori Ansible

\`\`

```yaml
[local]
localhost ansible_connection=local
```

\`\`

```yaml
- hosts: all
  become: true
  roles:
    - monitoring
```

### 4. Jalankan Ansible

```bash
cd ansible
ansible-playbook -i inventory.yml site.yml
```

Ansible akan menyalin file konfigurasi Prometheus dan dashboard Grafana otomatis.

---

## 🐳 Jalankan Monitoring dengan Docker Compose

```bash
cd docker
docker-compose -f docker-compose.monitoring.yml up -d
```

Akses:

* Grafana: [http://localhost:3000](http://localhost:3000)
* Prometheus: [http://localhost:9090](http://localhost:9090)

Default login Grafana:

* Username: `admin`
* Password: `admin`

---

## ☸ Jalankan Monitoring di Kubernetes

### 1. Start Minikube

```bash
minikube start
```

### 2. Deploy Semua YAML

```bash
kubectl apply -f kubernetes/monitoring/
```

### 3. Akses Service Grafana

```bash
minikube service grafana-service
```

---

## 🔧 Setup Jenkins (CI/CD)

### 1. Jalankan Jenkins via Docker

```bash
docker run -d \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts
```

Akses Jenkins di [http://localhost:8080](http://localhost:8080) dan ikuti petunjuk setup awal.

### 2. Buat Pipeline dengan Jenkinsfile

\`\`

```groovy
pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'Build stage (opsional)'
      }
    }
    stage('Deploy to Kubernetes') {
      steps {
        sh 'kubectl apply -f kubernetes/monitoring/'
      }
    }
  }
}
```

---

## 🌍 Setup Domain Lokal & TLS (Opsional)

### 1. Edit `/etc/hosts`

```
127.0.0.1 grafana.mysite.local
```

### 2. Setup Reverse Proxy Nginx

\`\`

```nginx
server {
    listen 80;
    server_name grafana.mysite.local;

    location / {
        proxy_pass http://localhost:3000;
    }
}
```

Aktifkan Nginx:

```bash
sudo ln -s $(pwd)/nginx/grafana.conf /etc/nginx/sites-enabled/
sudo systemctl restart nginx
```

---

## 📈 Monitoring Dashboard

### 1. Prometheus Target

* `localhost:9100` untuk Node Exporter
* `localhost:8080/metrics` dari aplikasi Anda

### 2. Grafana Dashboard

* Tambahkan `datasource` Prometheus
* Import dashboard JSON dari `ansible/roles/monitoring/files/grafana-dashboard.json`
* Atau gunakan ID publik: 1860 (Node Exporter), 193 (Docker)

---

## 🧪 Troubleshooting

| Masalah                                | Solusi                                      |
| -------------------------------------- | ------------------------------------------- |
| Port konflik di Docker                 | `docker ps` lalu `docker stop <id>`         |
| Grafana kosong/tidak tampil            | Cek datasource dan target Prometheus        |
| Prometheus tidak deteksi Node Exporter | Cek endpoint dan konfigurasi prometheus.yml |

---

## 🤝 Kontribusi

Silakan fork repositori ini dan kirim pull request. Laporan bug dan saran fitur juga sangat diapresiasi!

---

## 📜 Lisensi

MIT License. Bebas digunakan dan dikembangkan kembali untuk keperluan pribadi maupun profesional.
