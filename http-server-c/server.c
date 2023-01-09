#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

const char *index_html = "<html><body>Hello, World!</body></html>";
const char *idk_html = "<html><body>Sorry dont know this path. Try /index.html </body></html>";

int main(int argc, char *argv[]) {
    int sockfd, newsockfd, portno;
    socklen_t clilen;
    char buffer[256];
    struct sockaddr_in serv_addr, cli_addr;
    int n;

    // Check for correct number of arguments
    if (argc < 2) {
        fprintf(stderr, "ERROR, no port provided\n");
        exit(1);
    }

    // Create a socket
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        perror("ERROR opening socket");
        exit(1);
    }

    // Set all values in the serv_addr to 0
    memset((char *) &serv_addr, 0, sizeof(serv_addr));

    // Get the port number
    portno = atoi(argv[1]);

    // Create the socket address structure
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);

    // Bind the socket to the address
    if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0) {
        perror("ERROR on binding");
        exit(1);
    }

    // Listen for incoming connections
    listen(sockfd, 5);
    clilen = sizeof(cli_addr);

    while (1) {
        // Accept an incoming connection
        newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);
        if (newsockfd < 0) {
            perror("ERROR on accept");
            exit(1);
        }

        // Read the request from the client
        memset(buffer, 0, 256);
        n = read(newsockfd, buffer, 255);
        if (n < 0) {
            perror("ERROR reading from socket");
            exit(1);
        }

        // Parse the request
        char method[16];
        char resource[64];
        sscanf(buffer, "%s %s", method, resource);

        // Check if the resource exists
        if (strcmp(resource, "/index.html") == 0) {
            // Send a 200 OK response
            char response[256];
            sprintf(response, "HTTP/1.1 200 OK\nContent-Type: text/html\nContent-Length: %zu\n\n", strlen(index_html));
            n = write(newsockfd, response, strlen(response));
            if (n < 0) {
                perror("ERROR writing to socket");
                exit(1);
            }

            // Send the resource to the client
            n = write(newsockfd, index_html, strlen(index_html));
            if (n < 0) {
                perror("ERROR writing to socket");
                exit(1);
            }
        }else{
            char response[256];
            sprintf(response, "HTTP/1.1 200 OK\nContent-Type: text/html\nContent-Length: %zu\n\n", strlen(idk_html));
            n = write(newsockfd, response, strlen(response));
            if (n < 0) {
                perror("ERROR writing to socket");
                exit(1);
            }

            // Send the resource to the client
            n = write(newsockfd, idk_html, strlen(idk_html));
            if (n < 0) {
                perror("ERROR writing to socket");
                exit(1);
            }
        }
    }
}
