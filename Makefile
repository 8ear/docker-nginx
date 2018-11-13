
init:
	git remote add upstream https://github.com/nginxinc/docker-nginx.git

update:
	git fetch upstream
	git checkout master
	git merge upstream/master

build:
	echo $(PW)| docker login -u 8ear --password-stdin
	docker build -f mainline/alpine/Dockerfile \
		-t 8ear/nginx:$(shell grep "ENV NGINX_VERSION" ./mainline/alpine/Dockerfile|cut -d ' ' -f 3)-alpine \
		-t 8ear/nginx:latest-alpine \
		-t 8ear/nginx:latest \
		./mainline/alpine/
	docker push 8ear/nginx:$(shell grep "ENV NGINX_VERSION" ./mainline/alpine/Dockerfile|cut -d ' ' -f 3)-alpine
	docker push 8ear/nginx:latest-alpine
	docker push 8ear/nginx:latest
