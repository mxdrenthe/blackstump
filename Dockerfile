FROM gradle:7.3.3-jdk17 AS build
WORKDIR /usr/app

COPY . .
RUN gradle build

FROM gcr.io/distroless/java17-debian11:nonroot
WORKDIR /usr/app
COPY --from=build /usr/app/build/libs/*SNAPSHOT.jar /usr/app/ctf-blackstump.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/app/ctf-blackstump.jar"]
