FROM openjdk:11
#LABEL maintainer=sim-service
#RUN apt-get update && apt-get upgrade -y

COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac Main.java
RUN java -XX:+PrintFlagsFinal -version | grep -E "UseContainerSupport | InitialRAMPercentage | MaxRAMPercentage | MinRAMPercentage | MinHeapFreeRatio | MaxHeapFreeRatio"
#CMD ["java", "Main"]
#CMD ["java","-XX:InitialRAMPercentage=10","-XX:MaxRAMPercentage=75"]
ENTRYPOINT ["java","-XX:InitialRAMPercentage=10","-XX:MaxRAMPercentage=75","Main"]
#CMD ["500"]