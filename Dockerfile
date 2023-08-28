FROM golang:1.21 AS builder

WORKDIR /app

COPY main.go .
COPY go.mod .

RUN go get github.com/gorilla/mux
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o note-service .

FROM alpine

COPY --from=builder /app/note-service /note-service

EXPOSE 8080

CMD ["/note-service"]
