# 📬 API RQUEST PROVIDER

## BRIEF:

 - 🛵 This is the Deliveryman class who delivers the URL request to the server and then waits for a response (or Money = Bad joke 😠)

 ### Input:

 - APIRequestProtocol.

 - APIRequestCompletion.
  - consist of two types:
    - Data
    - Error (APIRequestProviderError) -> It is enum that consists of the expected errors.

 ### 🕵️‍♂️ How does it work

 - created a protocol to contain function perform(apiRequest,APIRequestCompletion) then I confirm on this protocol from a class called APIRequestProvider. 

 - created private func to perform request through the URLSession.

 - a protocol function checks the internet first by injected Property internet manager if it passed will perform the request.

## 🚀 Contributing

⚙ Made by: Mohamed Gamal