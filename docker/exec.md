# 설치 linux-mint19


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
