FROM archlinux:latest AS ZOLA
RUN yay -S zola-bin
COPY . /site
WORKDIR /site
RUN zola build
FROM nginx:stable-alpine
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/old-index.html
COPY --from=ZOLA /site/public/ /usr/share/nginx/html/
EXPOSE 80 443
