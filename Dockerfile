FROM j1mc/docker-zola:latest AS ZOLA
COPY . /site
WORKDIR /site
CMD ["zola build"]
FROM nginx:stable-alpine
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/old-index.html
COPY --from=ZOLA /site/public/ /usr/share/nginx/html/
EXPOSE 80 443
