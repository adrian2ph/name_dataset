# Dockerfile
FROM alpine:latest

# Install MySQL client
RUN apk update && \
    apk add --no-cache mysql-client

# Set the working directory
WORKDIR /app

# Copy the SQL dump file into the container (optional)
# Uncomment the following line and replace 'name_dataset_dump.sql' with your dump file
COPY name_dataset_dump.sql /app/

# Set the entrypoint to the MySQL client (optional)
# ENTRYPOINT ["/bin/sleep infinit"]
