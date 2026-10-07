FROM docker.io/library/maven@sha256:82e47241881f23ad774f5db8829efca15758e8fdb5b1d64ea9f8d6420a85068e AS builder
WORKDIR /build
COPY pom.xml ./
COPY src/ ./src/
RUN mvn -B -ntp clean verify

FROM scratch
COPY --from=builder /build/target/runtime/ /app/dependencies/
COPY --from=builder /build/target/retry-e2e-h2-1.0.0.jar /app/fixture.jar
