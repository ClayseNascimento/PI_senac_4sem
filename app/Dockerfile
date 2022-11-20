#Stage 1 - Install dependencies and build the app in a build environment
FROM debian:latest AS build-env

# Install flutter dependencies
RUN apt-get update
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 sed
RUN apt-get clean

# Clone the flutter repo
RUN git clone -b 3.0.5 --depth 1 https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter path
ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"

# Run flutter doctor
RUN flutter doctor -v

# Copy files to container and build
WORKDIR /usr/src/app
COPY . ./

RUN flutter pub upgrade
RUN flutter pub get

RUN flutter build web --web-renderer html

# Stage 2 - Create the run-time image
FROM nginx:1.21.1-alpine
COPY --from=build-env /usr/src/app/build/web /usr/share/nginx/html

EXPOSE 80