# build Angular application
FROM node:14-alpine AS builder
COPY src/angular/fe-weatherstation /opt/fe-weatherstation/
WORKDIR /opt/fe-weatherstation

RUN npm install -g @angular/cli@13.0.3
RUN npm install

ARG VARIANT
ENV VARIANT=$VARIANT

RUN ng build --configuration $VARIANT

# Create Nginx container with the Angular application
FROM nginx:stable-alpine
ARG VARIANT
ENV VARIANT=$VARIANT

COPY --from=builder /opt/fe-weatherstation/dist/weatherstation-fe /usr/share/nginx/html

LABEL VARIANT=$VARIANT
