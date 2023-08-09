FROM alpine:latest
RUN apk update && apk add make g++ git
WORKDIR /app
RUN git clone https://github.com/justinfrankel/ninjam
WORKDIR /app/ninjam/ninjam/server
RUN make


FROM alpine:latest
RUN apk add libstdc++

COPY --from=0 /app/ninjam/ninjam/server/ninjamsrv /app/ninjamsrv
COPY --from=0 /app/ninjam/ninjam/server/example.cfg /app/config.cfg
WORKDIR /app
ENTRYPOINT ["/app/ninjamsrv", "config.cfg"]
