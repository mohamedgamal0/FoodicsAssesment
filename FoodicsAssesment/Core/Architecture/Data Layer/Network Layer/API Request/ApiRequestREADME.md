# 🎩 BASE API REQUEST

## BRIEF:

- 👨‍🍳 This is the kitchen class where the URLRequest is prepared.
- this is abstract class cannot instantiate it, you can extend only one class.

### The components of a URLRequest:

  - scheme:

     - The scheme identifies the protocol to be used to access the resource on the Internet. It can be HTTP (without SSL) or HTTPS (with SSL).


 - host:

     - The host name identifies the host that holds the resource. For example, www.example.com. A server provides services in the name of the host.


 - URL:

    - It indicates the location of a web resource like a street address indicates where a person lives physically — because of this, an URL is often referred to as: “web address”.

    - A URL contains the following information:

      - The protocol used to access the resource.
      - The location of the server (whether by IP address or domain name).
      - The port number on the server (optional).
      - The location of the resource in the directory structure of the server.
      - A fragment identifier (optional).

 - portNumber:

     -  Well-known port numbers for a service are normally omitted from the URL. Most servers use the well-known port numbers for HTTP and HTTPS , so most HTTP URLs omit the port number.
     - HTTP : 80
     - HTTPS: 443


 - path:

     - The path identifies the specific resource in the host that the web client wants to access.

 - queryParams:

     - If a query string is used, it follows the path component, and provides a string of information that the resource can use for some purpose (for example, as parameters for a search or as data to be processed). The query string is usually a string of name and value pairs; for example, term=bluebird. Name and value pairs are separated from each other by an ampersand (&); for example, term=bluebird&source=browser-search.


 - APIAuthorization:

    - Involves checking resources that the user is authorized to access or modify via defined roles or claims.


 - HTTPMethod:	


   - The HTTP methods comprise a major portion of our “uniform interface” constraint and provide us the action counterpart to the noun-based resource.

 - headers:

   - let the client and the server pass additional information with an HTTP request or response.


 - queryBody:

   - The body parameter is defined in the operation’s parameters section. 

### 🕵️‍♂️ How does it work

I created a protocol to contain all URL Request component then I confirm on this protocol from a class called BaseAPIRequest to prepare the request.

 - At first, collect the URL Request components, then pass them all over to the requestURL 💅

## 🚀 Contributing

⚙ Made by: Mohamed Gamal