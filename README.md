# gami_acad

GamiAcad App

## Introduction

The GamiAcad Mobile App offers a mobile interface to access gamified educational content and features provided by the GamiAcad platform.

### Author: Diogo Vasques

## Prerequisites

- Flutter 3.13.1
- Dart 3.1.0
- Node.js 18

## Configuration Steps

Before running the application, make sure to set up the required environment variables:

- GAMIACAD_API_URL: URL for the GamiAcad API.
- CLIENT_ID: Client ID for authentication purposes.

Create a .env file at the root of the project and add these variables:

```properties
GAMIACAD_API_URL=gamiacad_api_url
CLIENT_ID=your_client_id
```

## Development:

### LeftHook Setup

Before committing any changes, LeftHook must be installed and activated:

1. Install LeftHook globally:

`npm install -g lefthook --save-dev`

2. Activate LeftHook using the lefthook.yml configurations:

`lefthook install`

### Git Ignore .env File

To ignore changes made to the .env file:

`git update-index --assume-unchanged ./.env`

### Testing

Before testing your code, generate mock files:

`dart run build_runner build`

Then run tests:

`flutter test`
