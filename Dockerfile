FROM debian:latest AS ZOLA
COPY . /site
WORKDIR /site
RUN wget -c https://github.com/getzola/zola/releases/download/v0.10.1/zola-v0.10.1-x86_64-unknown-linux-gnu.tar.gz -O - | tar -xz && mv zola /usr/bin && zola build
FROM nginx:stable-alpine
RUN rm /usr/share/nginx/html/index.html
COPY --from=ZOLA /site/public/ /usr/share/nginx/html/
EXPOSE 80
