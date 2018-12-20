# 설치 linux-mint19

## Install packages which are needed for adding docker-ce repository.
```
sudo apt install -y apt-transport-https ca-certificates curl \
 software-properties-common
```
## Add docker-ce repository.
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo apt-key add -
export LSB_ETC_LSB_RELEASE=/etc/upstream-release/lsb-release
V=$(lsb_release -cs)
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${V} stable"
sudo apt update -y    
```

## Install docker-ce.
```
sudo apt install -y docker-ce
```
## Add user to docker group. Added user can run docker command without sudo command.
```
sudo gpasswd -a "${USER}" docker
sudo reboot
```


# 실행
```
docker run hello-world
<snip>
Hello from Docker!
<snip>
```

# 이미지확인
* docker images

# Program
## jenkins
* docker run -p 7707:8080 -p 50000:50000 jenkins/jenkins:lts
* docker ps -al
* docker exec -it bewe_jenkins /bin/bash
