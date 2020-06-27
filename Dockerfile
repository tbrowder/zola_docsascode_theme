FROM debian:latest AS ZOLA
COPY . /site
WORKDIR /site
ADD https://github.com/getzola/zola/releases/download/v0.10.1/zola-v0.10.1-x86_64-unknown-linux-gnu.tar.gz /tmp
RUN tar -C /usr/bin -xvzf /tmp/zola-v0.10.1-x86_64-unknown-linux-gnu.tar.gz && zola build
FROM nginx:stable-alpine
RUN rm /usr/share/nginx/html/index.html
COPY --from=ZOLA /site/public/ /usr/share/nginx/html/
EXPOSE 80
