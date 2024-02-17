FROM nginx:latest
COPY finally.html /usr/share/nginx/html/
COPY nextpage.html /usr/share/nginx/html/
COPY yes.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
EXPOSE 80
CMD [ "nginx","-g","daemon off;" ]