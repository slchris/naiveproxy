local_image:
	docker build -t naiveproxy:v1 .
ghcr_image:
	docker buildx build --platform linux/arm64,linux/amd64 -t ghcr.io/slchris/naiveproxy:v1 . -- load 